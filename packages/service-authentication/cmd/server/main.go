package main

import (
	"log"
	"net/http"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/kokiebisu/mycontent/packages/service-authentication/adapter/client"
	"github.com/kokiebisu/mycontent/packages/service-authentication/graphql/generated"
	"github.com/kokiebisu/mycontent/packages/service-authentication/graphql/resolver"
	"github.com/kokiebisu/mycontent/packages/shared/proto"
	_ "github.com/lib/pq"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	userGrpcPort := os.Getenv("USER_GRPC_PORT")
	if userGrpcPort == "" {
		log.Fatal("USER_GRPC_PORT is not set")
	}
	conn, err := grpc.NewClient("service-user:"+userGrpcPort, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("Failed to dial: %v", err)
	}
	defer conn.Close()

	userClient := proto.NewUserServiceClient(conn)
	userServiceClient := client.NewUserServiceClient(userClient)

	srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &resolver.Resolver{
		UserServiceClient: userServiceClient,
	}}))

	http.Handle("/playground", playground.Handler("GraphQL playground", "/query"))
	http.Handle("/query", srv)

	graphqlPort := os.Getenv("GRAPHQL_PORT")
	if graphqlPort == "" {
		log.Fatal("GRAPHQL_PORT is not set")
	}
	log.Printf("connect to http://localhost:%s/playground for GraphQL playground", graphqlPort)
	log.Fatal(http.ListenAndServe(":"+graphqlPort, nil))
}
