package port

import (
	"context"
)


type TokenService interface {
	GenerateToken(ctx context.Context, userId string) (string, error)
	ValidateToken(ctx context.Context, token string) (bool, error)
	InvalidateToken(ctx context.Context, token string) error
	GetToken(ctx context.Context) (string, error)
}
