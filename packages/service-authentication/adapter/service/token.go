package service

import (
	"context"
	"errors"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/google/uuid"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
)

type TokenService struct {
	secret string
}

func NewTokenService(secret string) *TokenService {
	return &TokenService{secret: secret}
}

func (s *TokenService) GenerateToken(ctx context.Context, userId uuid.UUID, role enum.Role) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"user_id": userId.String(),
		"role": role.String(),
		"exp":    time.Now().Add(time.Hour * 24).Unix(),
	})
	return token.SignedString([]byte(s.secret))
}

func (s *TokenService) ValidateToken(ctx context.Context, token string) (bool, error) {
	_, err := jwt.Parse(token, func(token *jwt.Token) (interface{}, error) {
		return []byte(s.secret), nil
	})
	if err != nil {
		return false, err
	}
	return true, nil
}

func (s *TokenService) InvalidateToken(ctx context.Context, token string) error {
	_, err := jwt.Parse(token, func(token *jwt.Token) (interface{}, error) {
		return []byte(s.secret), nil
	})
	if err != nil {
		return err
	}
	return nil
}

func (s *TokenService) GetToken(ctx context.Context) (string, error) {
	token, ok := ctx.Value("authToken").(string)
	if !ok {
		return "", errors.New("token not found")
	}
	return token, nil
}