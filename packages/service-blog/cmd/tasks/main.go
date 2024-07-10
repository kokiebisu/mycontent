package main

import (
	"context"
	"log"
	"os"
	"time"

	"github.com/kokiebisu/mycontent/packages/shared/proto"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	blogGrpcPort := os.Getenv("BLOG_GRPC_PORT")
	if blogGrpcPort == "" {
		log.Fatal("BLOG_GRPC_PORT is not set")
	}
	conn, err := grpc.NewClient("localhost:"+blogGrpcPort, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("Failed to dial: %v", err)
	}
	defer conn.Close()
	client := proto.NewBlogServiceClient(conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second * 60)
  defer cancel()
		
	req := &proto.CreateBlogRequest{
		UserId: "1",
		Interest: "REACT",
	}
	_, err = client.CreateBlog(ctx, req)
	if err != nil {
		log.Fatalf("Failed to create blog: %v", err)
	}
	os.Exit(0)
}