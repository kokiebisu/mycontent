package main

import (
	"context"
	"log"
	"net"
	"net/http"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/kokiebisu/mycontent/packages/service-authentication/graphql/generated"
	grpc_client "github.com/kokiebisu/mycontent/packages/service-user/adapter/grpc"
	"github.com/kokiebisu/mycontent/packages/service-user/adapter/service"
	"github.com/kokiebisu/mycontent/packages/service-user/graphql/resolver"
	"github.com/kokiebisu/mycontent/packages/service-user/proto"
	"github.com/kokiebisu/mycontent/packages/shared/ent"
	_ "github.com/lib/pq"
	"google.golang.org/grpc"
)

const (
	graphqlPort = "4003"
	grpcPort = "50053"
)

func main() {
	client, err := ent.Open("postgres", "host=db port=5432 user=postgres dbname=mydb sslmode=disable password=mypassword")
	if err != nil {
		log.Fatalf("failed openidfgdng connection to postgres: %v", err)
	}
	defer client.Close()

	if err := client.Schema.Create(context.Background()); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = graphqlPort
	}

	userService := service.NewUserService(client)

	go func() {
		srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &resolver.Resolver{
			UserService: userService,
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
	

	adapter := grpc_client.NewGRPCAdapter(userService)
	grpcServer := grpc.NewServer()
	proto.RegisterUserServiceServer(grpcServer, adapter)
	grpcServer.Serve(lis)
}
