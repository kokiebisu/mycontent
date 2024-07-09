package port

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/shared/proto"
)

type GRPCAdapter interface {
	CreateBlog(context.Context, *proto.CreateBlogRequest) (*proto.CreateBlogResponse, error)
	proto.UnimplementedBlogServiceServer
}
