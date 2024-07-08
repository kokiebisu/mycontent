package port

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
	"github.com/kokiebisu/mycontent/packages/service-blog/ent/blog"
)

type BlogService interface {
	Get(ctx context.Context, id string) (*ent.Blog, error)
	GetAll(ctx context.Context) ([]*ent.Blog, error)
	GetAllByUserId(ctx context.Context, userId string) ([]*ent.Blog, error)
	Create(ctx context.Context, userID string, interest blog.Interest) (*ent.Blog, error)
	Delete(ctx context.Context, id string) (string, error)
}
