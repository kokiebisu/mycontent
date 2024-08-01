package port

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/service-blog/stub"
)

type GRPCAdapter interface {
	CreateBlog(context.Context, *stub.CreateBlogRequest) (*stub.CreateBlogResponse, error)
	stub.UnimplementedBlogServiceServer
}
