package port

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
)

type BlogService interface {
	Get(ctx context.Context, id string) (*ent.Blog, error)
	GetAll(ctx context.Context) ([]*ent.Blog, error)
	Create(ctx context.Context, userID string, interest string) (*ent.Blog, error)
	Delete(ctx context.Context, id string) (string, error)
}
