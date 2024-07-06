package main

import (
	"context"
	"log"
	"os"
	"time"

	"github.com/kokiebisu/mycontent/packages/service-blog/proto"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	conn, err := grpc.NewClient("localhost:50051", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("Failed to dial: %v", err)
	}
	defer conn.Close()
	client := proto.NewBlogServiceClient(conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second * 60)
  defer cancel()
		
	req := &proto.CreateBlogRequest{
		UserId: "1",
		Interest: "React",
	}
	_, err = client.CreateBlog(ctx, req)
	if err != nil {
		log.Fatalf("Failed to create blog: %v", err)
	}
	os.Exit(0)
}