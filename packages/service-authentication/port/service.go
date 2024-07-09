package port

import (
	"context"
)


type TokenService interface {
	GenerateToken(ctx context.Context, userId string) (string, error)
	ValidateToken(ctx context.Context, token string) (string, error)
}
