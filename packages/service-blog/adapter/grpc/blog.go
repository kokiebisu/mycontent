package grpc

import (
	"context"
	"log"

	"github.com/kokiebisu/mycontent/packages/service-blog/port"

	"github.com/kokiebisu/mycontent/packages/shared/proto"
)

type Adapter struct {
	service port.BlogService
	proto.UnimplementedBlogServiceServer
}

func NewGRPCAdapter(service port.BlogService) *Adapter {
	return &Adapter{service: service}
}

func (a *Adapter) CreateBlog(ctx context.Context, req *proto.CreateBlogRequest) (*proto.CreateBlogResponse, error) {
	blog, err := a.service.Create(ctx, req.UserId, req.Title, req.Url)
	if err != nil {
		log.Printf("Error creating blog: %v", err)
		return &proto.CreateBlogResponse{Error: err.Error()}, nil
	}
	return &proto.CreateBlogResponse{Id: blog.ID.String()}, nil
}
