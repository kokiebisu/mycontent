package main

import (
	"bytes"
	"context"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strings"

	"entgo.io/ent/dialect/sql/schema"
	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	grpc_client "github.com/kokiebisu/mycontent/packages/service-user/adapter/grpc"
	"github.com/kokiebisu/mycontent/packages/service-user/adapter/service"
	"github.com/kokiebisu/mycontent/packages/service-user/graphql/generated"
	"github.com/kokiebisu/mycontent/packages/service-user/graphql/resolver"
	"github.com/kokiebisu/mycontent/packages/service-user/stub"
	"github.com/kokiebisu/mycontent/packages/shared/ent"

	_ "github.com/lib/pq"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
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

	if err := client.Schema.Create(context.Background(), schema.WithDropIndex(true), schema.WithDropColumn(true)); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}

	userService := service.NewUserService(client)

	go func() {
		graphqlPort := os.Getenv("GRAPHQL_PORT")
		if graphqlPort == "" {
			log.Fatal("GRAPHQL_PORT is not set")
		}

		authMiddleware := func(next http.Handler) http.Handler {
			return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				// Allow introspection queries without authentication
				if r.URL.Path == "/query" && r.Method == "POST" {
					body, err := io.ReadAll(r.Body)
					if err != nil {
						http.Error(w, "Error reading request body", http.StatusInternalServerError)
						return
					}
					if strings.Contains(string(body), "__schema") {
						newRequest := r.Clone(r.Context())
						newRequest.Body = io.NopCloser(bytes.NewBuffer(body))
						next.ServeHTTP(w, newRequest)
						return
					}
					r.Body = io.NopCloser(bytes.NewBuffer(body))
				}

				ctx := r.Context()
				userID := r.Header.Get("x-user-id")
				if userID != "" {
					ctx = context.WithValue(ctx, "userID", userID)
				} else {
					ctx = context.WithValue(ctx, "userID", "guest")
				}
				role := r.Header.Get("x-role")
				ctx = context.WithValue(ctx, "role", role)

				next.ServeHTTP(w, r.WithContext(ctx))
			})
		}

		srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &resolver.Resolver{
			UserService: userService,
		}}))
	
		http.Handle("/playground", playground.Handler("GraphQL playground", "/query"))
		http.Handle("/query", authMiddleware(srv))
	
		log.Printf("connect to http://localhost:%s/playground for GraphQL playground", graphqlPort)
		log.Fatal(http.ListenAndServe(":"+graphqlPort, nil))
	}()

	userGrpcPort := os.Getenv("USER_GRPC_PORT")
	if userGrpcPort == "" {
		log.Fatal("USER_GRPC_PORT is not set")
	}

	lis, err := net.Listen("tcp", ":"+userGrpcPort)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	defer lis.Close()
	

	adapter := grpc_client.NewGRPCAdapter(userService)
	grpcServer := grpc.NewServer()
	stub.RegisterUserServiceServer(grpcServer, adapter)

	reflection.Register(grpcServer)

	log.Printf("gRPC server listening on port %s", userGrpcPort)

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
