package port

import (
	"context"

	"github.com/google/uuid"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
)


type TokenService interface {
	GenerateToken(ctx context.Context, userId uuid.UUID, role enum.Role) (string, error)
	ValidateToken(ctx context.Context, token string) (bool, error)
	InvalidateToken(ctx context.Context, token string) error
	GetToken(ctx context.Context) (string, error)
}
