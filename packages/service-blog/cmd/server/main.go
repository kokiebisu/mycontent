package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"

	"entgo.io/ent/dialect/sql/schema"
	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	grpc_client "github.com/kokiebisu/mycontent/packages/service-blog/adapter/grpc"
	"github.com/kokiebisu/mycontent/packages/service-blog/adapter/service"
	"github.com/kokiebisu/mycontent/packages/service-blog/graphql/generated"
	"github.com/kokiebisu/mycontent/packages/shared/ent"
	"github.com/kokiebisu/mycontent/packages/shared/proto"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/kokiebisu/mycontent/packages/service-blog/graphql/resolver"
	_ "github.com/lib/pq"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	// config.LoadEnv()
	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")
	dbUser := os.Getenv("DB_USER")
	dbName := os.Getenv("DB_NAME")
	dbPassword := os.Getenv("DB_PASSWORD")

	dbClient, err := ent.Open("postgres", "host=" + dbHost + " port=" + dbPort + " user=" + dbUser + " dbname=" + dbName + " sslmode=disable password=" + dbPassword)
	if err != nil {
		log.Fatalf("failed opening connection to postgres: %v", err)
	}
	defer dbClient.Close()

	if err := dbClient.Schema.Create(context.Background(), schema.WithDropIndex(true), schema.WithDropColumn(true),); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}
	s3Endpoint := os.Getenv("S3_ENDPOINT")
	environment := os.Getenv("ENVIRONMENT")

	var cfg aws.Config
	region := os.Getenv("AWS_DEFAULT_REGION")
	if environment != "production" {
		fmt.Println("Loading S3 credentials for Non-Production...")
		accessKey := os.Getenv("AWS_ACCESS_KEY_ID")
		secretKey := os.Getenv("AWS_SECRET_ACCESS_KEY")

		cfg, err = config.LoadDefaultConfig(context.TODO(),
			config.WithRegion(region),
			config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(accessKey, secretKey, "")),
		)
	} else {
		fmt.Println("Using IAM role for Production...")
		cfg, err = config.LoadDefaultConfig(context.TODO(),
			config.WithRegion(region),
		)
	}

	if err != nil {
		log.Fatalf("unable to load SDK config, %v", err)
	}

	s3Client := s3.NewFromConfig(cfg, func(o *s3.Options) {
		if s3Endpoint != "" {
			o.BaseEndpoint = aws.String(s3Endpoint)
			o.UsePathStyle = true
			fmt.Printf("S3 Endpoint set to: %s\n", s3Endpoint)
		}
	})

	blogService := service.NewBlogService(dbClient)
	integrationService := service.NewIntegrationService(dbClient)
	storageService := service.NewStorageService(s3Client)

	go func() {
		port := os.Getenv("GRAPHQL_PORT")
		if port == "" {
			log.Fatal("GRAPHQL_PORT is not set")
		}
		srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &resolver.Resolver{ BlogService: blogService, IntegrationService: integrationService, StorageService: storageService }}))
	
		http.Handle("/playground", playground.Handler("GraphQL playground", "/query"))
		http.Handle("/query", srv)
	
		log.Printf("connect to http://localhost:%s/playground for GraphQL playground", port)
		log.Fatal(http.ListenAndServe(":"+port, nil))
	}()

	blogGrpcPort := os.Getenv("BLOG_GRPC_PORT")
	if blogGrpcPort == "" {
		log.Fatal("BLOG_GRPC_PORT is not set")
	}

	lis, err := net.Listen("tcp", ":"+blogGrpcPort)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	defer lis.Close()

	adapter := grpc_client.NewGRPCAdapter(blogService)
	grpcServer := grpc.NewServer()
	proto.RegisterBlogServiceServer(grpcServer, adapter)

	reflection.Register(grpcServer)

	log.Printf("gRPC server listening on port %s", blogGrpcPort)

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}