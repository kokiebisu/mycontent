package port

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
)

type IntegrationService interface {
	Create(ctx context.Context, integration *ent.Integration) (*ent.Integration, error)
	Get(ctx context.Context, id string) (*ent.Integration, error)
	GetAllByUserId(ctx context.Context, userID string) ([]*ent.Integration, error)
	Delete(ctx context.Context, id string) error
}
