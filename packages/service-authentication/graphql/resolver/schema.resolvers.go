package resolver

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.
// Code generated by github.com/99designs/gqlgen version v0.17.48

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/kokiebisu/mycontent/packages/service-authentication/graphql/generated"
	"github.com/kokiebisu/mycontent/packages/service-authentication/graphql/model"
	"github.com/kokiebisu/mycontent/packages/service-authentication/utils"
	"github.com/kokiebisu/mycontent/packages/shared/ent"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
)

// Register is the resolver for the register field.
func (r *mutationResolver) Register(ctx context.Context, input *model.RegisterInput) (*model.AuthPayload, error) {
	user, err := r.UserServiceClient.GetUserByEmail(ctx, input.Email)
	if err == nil && user != nil {
		return nil, fmt.Errorf("user already exists")
	}
	if err != nil && !strings.Contains(err.Error(), "user not found") {
		return nil, fmt.Errorf("error fetching user by email: %w", err)
	}

	publishTime, err := utils.ParseTime(input.PublishTime)
	if err != nil {
		return nil, fmt.Errorf("invalid publish time format: %w", err)
	}

	user, err = r.UserServiceClient.CreateUser(ctx, input.FirstName, input.LastName, input.Email, input.Username, enum.Interest(input.Interest), input.YearsOfExperience, publishTime, input.Password)
	if err != nil {
		return nil, fmt.Errorf("failed to create user: %w", err)
	}

	token, err := r.TokenService.GenerateToken(ctx, user.ID.String())
	if err != nil {
		return nil, fmt.Errorf("failed to generate token: %w", err)
	}

	return &model.AuthPayload{UserID: user.ID.String(), AuthToken: token}, nil
}

// Login is the resolver for the login field.
func (r *mutationResolver) Login(ctx context.Context, input *model.LoginInput) (*model.AuthPayload, error) {
	// Check if the user exists
	user, err := r.UserServiceClient.GetUserByEmail(ctx, input.Email)
	if err != nil {
		return nil, err
	}
	if user != nil {
		user, err := r.UserServiceClient.GetUserByEmail(ctx, input.Email)
		if err != nil {
			return nil, err
		}
		if user.Password != input.Password {
			return nil, fmt.Errorf("incorrect password")
		}
		token, err := r.TokenService.GenerateToken(ctx, user.ID.String())
		if err != nil {
			return nil, err
		}
		return &model.AuthPayload{UserID: user.ID.String(), AuthToken: token}, nil
	} else {
		return nil, fmt.Errorf("user does not exist")
	}
}

// Logout is the resolver for the logout field.
func (r *mutationResolver) Logout(ctx context.Context) (*model.LogoutPayload, error) {
	// Retrieve the token from the context
	token, err := r.TokenService.GetToken(ctx)
	if err != nil {
		return nil, err
	}
	// Invalidate the token
	err = r.TokenService.InvalidateToken(ctx, token)
	if err != nil {
		return nil, err
	}
	return &model.LogoutPayload{Message: "Logout successful"}, nil
}

// ID is the resolver for the id field.
func (r *userResolver) ID(ctx context.Context, obj *ent.User) (string, error) {
	return obj.ID.String(), nil
}

// PublishTime is the resolver for the publishTime field.
func (r *userResolver) PublishTime(ctx context.Context, obj *ent.User) (string, error) {
	return obj.PublishTime.Format(time.RFC3339), nil
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

// User returns generated.UserResolver implementation.
func (r *Resolver) User() generated.UserResolver { return &userResolver{r} }

type mutationResolver struct{ *Resolver }
type userResolver struct{ *Resolver }
