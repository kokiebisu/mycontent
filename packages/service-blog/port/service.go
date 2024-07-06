package port

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
)

type BlogService interface {
	CreateBlog(ctx context.Context, userID string, interest string) (*ent.Blog, error)
}
