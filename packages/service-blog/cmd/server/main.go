package main

import (
	"context"
	"log"
	"net"
	"net/http"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	grpc_client "github.com/kokiebisu/mycontent/packages/service-blog/adapter/grpc"
	"github.com/kokiebisu/mycontent/packages/service-blog/adapter/service"
	"github.com/kokiebisu/mycontent/packages/service-blog/config"
	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
	"github.com/kokiebisu/mycontent/packages/service-blog/graphql"
	"github.com/kokiebisu/mycontent/packages/service-blog/proto"
	_ "github.com/lib/pq"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

const (
	graphqlPort = "4002"
	grpcPort = "50051"
)

func main() {
	config.LoadEnv()
	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")
	dbUser := os.Getenv("DB_USER")
	dbName := os.Getenv("DB_NAME")
	dbPassword := os.Getenv("DB_PASSWORD")

	client, err := ent.Open("postgres", "host=" + dbHost + " port=" + dbPort + " user=" + dbUser + " dbname=" + dbName + " sslmode=disable password=" + dbPassword)
	if err != nil {
		log.Fatalf("failed opening connection to postgres: %v", err)
	}
	defer client.Close()

	if err := client.Schema.Create(context.Background()); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}

	port := os.Getenv("GRAPHQL_PORT")
	if port == "" {
		port = graphqlPort
	}

	go func() {
		srv := handler.NewDefaultServer(graphql.NewExecutableSchema(graphql.Config{Resolvers: &graphql.Resolver{
			Client: client,
		}}))
	
		http.Handle("/playground", playground.Handler("GraphQL playground", "/query"))
		http.Handle("/query", srv)
	
		log.Printf("connect to http://localhost:%s/playground for GraphQL playground", port)
		log.Fatal(http.ListenAndServe(":"+port, nil))
	}()

	lis, err := net.Listen("tcp", ":"+grpcPort)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	defer lis.Close()

	svc := service.NewBlogService(client)
	adapter := grpc_client.NewGRPCAdapter(svc)

	grpcServer := grpc.NewServer()
	proto.RegisterBlogServiceServer(grpcServer, adapter)

	reflection.Register(grpcServer)

	log.Printf("gRPC server listening on port %s", grpcPort)

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
