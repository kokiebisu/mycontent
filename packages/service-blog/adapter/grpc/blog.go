package grpc

import (
	"context"
	"log"

	"github.com/kokiebisu/mycontent/packages/service-blog/port"
	"github.com/kokiebisu/mycontent/packages/service-blog/stub"
)

type Adapter struct {
	service port.BlogService
	stub.UnimplementedBlogServiceServer
}

func NewGRPCAdapter(service port.BlogService) *Adapter {
	return &Adapter{service: service}
}

func (a *Adapter) CreateBlog(ctx context.Context, req *stub.CreateBlogRequest) (*stub.CreateBlogResponse, error) {
	blog, err := a.service.Create(ctx, req.UserId, req.Title, req.Url)
	if err != nil {
		log.Printf("Error creating blog: %v", err)
		return &stub.CreateBlogResponse{Error: err.Error()}, nil
	}
	return &stub.CreateBlogResponse{Id: blog.ID.String()}, nil
}
