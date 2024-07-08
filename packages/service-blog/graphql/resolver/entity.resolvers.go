package resolver

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.
// Code generated by github.com/99designs/gqlgen version v0.17.48

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
	"github.com/kokiebisu/mycontent/packages/service-blog/graphql/generated"
)

// FindBlogByID is the resolver for the findBlogByID field.
func (r *entityResolver) FindBlogByID(ctx context.Context, id string) (*ent.Blog, error) {
	blog, err := r.BlogService.Get(ctx, id)
	if err != nil {
		return nil, err
	}
	return blog, nil
}

// FindIntegrationByID is the resolver for the findIntegrationByID field.
func (r *entityResolver) FindIntegrationByID(ctx context.Context, id string) (*ent.Integration, error) {
	integration, err := r.IntegrationService.Get(ctx, id)
	if err != nil {
		return nil, err
	}
	return integration, nil
}

// Entity returns generated.EntityResolver implementation.
func (r *Resolver) Entity() generated.EntityResolver { return &entityResolver{r} }

type entityResolver struct{ *Resolver }
