package service

import (
	"context"
	"time"

	"github.com/golang-jwt/jwt"
)

type TokenService struct {
	secret string
}

func NewTokenService(secret string) *TokenService {
	return &TokenService{secret: secret}
}

func (s *TokenService) GenerateToken(userId string) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"user_id": userId,
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
