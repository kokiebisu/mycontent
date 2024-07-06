package graphql

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.
// Code generated by github.com/99designs/gqlgen version v0.17.48

import (
	"context"
	"fmt"
	"strconv"
	"time"
)

// DeleteBlog is the resolver for the deleteBlog field.
func (r *mutationResolver) DeleteBlog(ctx context.Context, id string) (*Blog, error) {
	intId, err := strconv.Atoi(id)
	if err != nil {
		return nil, fmt.Errorf("failed to convert id to int: %w", err)
	}
	blog, err := r.Client.Blog.Get(ctx, intId)
	if err != nil {
		return nil, fmt.Errorf("failed to find blog with id %s: %w", id, err)
	}

	err = r.Client.Blog.DeleteOne(blog).Exec(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to delete blog with id %s: %w", id, err)
	}

	return &Blog{
		ID: strconv.Itoa(blog.ID),
		Title: blog.Title,
		Content: blog.Content,
		CreatedAt: blog.CreatedAt.Format(time.RFC3339),
		UpdatedAt: blog.UpdatedAt.Format(time.RFC3339),
	}, nil
}

// Blog is the resolver for the blog field.
func (r *queryResolver) Blog(ctx context.Context, id string) (*Blog, error) {
	intId, err := strconv.Atoi(id)
	if err != nil {
		return nil, fmt.Errorf("failed to convert id to int: %w", err)
	}
	blog, err := r.Client.Blog.Get(ctx, intId)
	if err != nil {
		return nil, fmt.Errorf("failed to find blog with id %s: %w", id, err)
	}

	return &Blog{
		ID: strconv.Itoa(blog.ID),
		Title: blog.Title,
		Content: blog.Content,
		CreatedAt: blog.CreatedAt.Format(time.RFC3339),
		UpdatedAt: blog.UpdatedAt.Format(time.RFC3339),
	}, nil
}

// Blogs is the resolver for the blogs field.
func (r *queryResolver) Blogs(ctx context.Context) ([]*Blog, error) {
	blogs, err := r.Client.Blog.Query().All(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve blogs: %w", err)
	}

	var result []*Blog
	for _, blog := range blogs {
		result = append(result, &Blog{
			ID: strconv.Itoa(blog.ID),
			Title: blog.Title,
			Content: blog.Content,
			CreatedAt: blog.CreatedAt.Format(time.RFC3339),
			UpdatedAt: blog.UpdatedAt.Format(time.RFC3339),
		})
	}

	return result, nil
}

// Mutation returns MutationResolver implementation.
func (r *Resolver) Mutation() MutationResolver { return &mutationResolver{r} }

// Query returns QueryResolver implementation.
func (r *Resolver) Query() QueryResolver { return &queryResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }
