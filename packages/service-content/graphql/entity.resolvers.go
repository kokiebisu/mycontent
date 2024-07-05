package graphql

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.
// Code generated by github.com/99designs/gqlgen version v0.17.48

import (
	"context"
	"fmt"
)

// FindContentByID is the resolver for the findContentByID field.
func (r *entityResolver) FindContentByID(ctx context.Context, id string) (*Content, error) {
	panic(fmt.Errorf("not implemented: FindContentByID - findContentByID"))
}

// Entity returns EntityResolver implementation.
func (r *Resolver) Entity() EntityResolver { return &entityResolver{r} }

type entityResolver struct{ *Resolver }