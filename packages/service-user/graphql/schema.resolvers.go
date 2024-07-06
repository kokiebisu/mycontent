package graphql

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.
// Code generated by github.com/99designs/gqlgen version v0.17.49

import (
	"context"
	"strconv"

	"github.com/kokiebisu/mycontent/packages/service-user/ent"
)

// Node is the resolver for the node field.
func (r *queryResolver) Node(ctx context.Context, id string) (ent.Noder, error) {
	idInt, err := strconv.Atoi(id)
	if err != nil {
		return nil, err
	}
	return r.Client.Noder(ctx, idInt)
}

// Nodes is the resolver for the nodes field.
func (r *queryResolver) Nodes(ctx context.Context, ids []string) ([]ent.Noder, error) {
	idsInt := make([]int, len(ids))
	for i, id := range ids {
		idInt, err := strconv.Atoi(id)
		if err != nil {
			return nil, err
		}
		idsInt[i] = idInt
	}
	return r.Client.Noders(ctx, idsInt)
}

// Users is the resolver for the users field.
func (r *queryResolver) Users(ctx context.Context) ([]*User, error) {
	users, err := r.Client.User.Query().All(ctx)
	if err != nil {
		return nil, err
	}
	usersGql := make([]*User, len(users))
	for i, user := range users {
		usersGql[i] = &User{
			ID:       strconv.Itoa(user.ID),
			Username: user.Username,
			Email:    user.Email,
		}
	}
	return usersGql, nil
}

// Query returns QueryResolver implementation.
func (r *Resolver) Query() QueryResolver { return &queryResolver{r} }

type queryResolver struct{ *Resolver }
