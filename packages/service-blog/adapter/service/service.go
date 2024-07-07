package service

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
	"github.com/kokiebisu/mycontent/packages/service-blog/port"
	"github.com/sashabaranov/go-openai"
)

type BlogService struct {
	db *ent.Client
}

func NewBlogService(db *ent.Client) port.BlogService {
	return &BlogService{db: db}
}

func (s *BlogService) Get(ctx context.Context, id string) (*ent.Blog, error) {
	blog, err := s.db.Blog.Get(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("failed to get blog: %w", err)
	}
	return blog, nil
}

func (s *BlogService) GetAll(ctx context.Context) ([]*ent.Blog, error) {
	blogs, err := s.db.Blog.Query().All(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to get blogs: %w", err)
	}
	return blogs, nil
}

func (s *BlogService) Create(ctx context.Context, userId string, interest string) (*ent.Blog, error) {
	openaiAPIKey := os.Getenv("OPENAI_API_KEY")
	client := openai.NewClient(openaiAPIKey)

	req := openai.ChatCompletionRequest{
		Model: openai.GPT3Dot5Turbo0125,
		Messages: []openai.ChatCompletionMessage{
			{
				Role: openai.ChatMessageRoleUser,
				Content: `{
					"role": "user",
					"content": [
						{
							"type": "text",
							"text": "Reactについての面白い豆知識のブログを書いて。JSON形式で\"title\"と\"content\"がキー。５００文字以で。jsonだけ返して。"
						}
					]
				}`,
			},
		},
		MaxTokens: 500,
	}

	resp, err := client.CreateChatCompletion(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to generate blog content: %w", err)
	}

	var blogData struct {
		Title   string `json:"title"`
		Content string `json:"content"`
	}

	err = json.Unmarshal([]byte(resp.Choices[0].Message.Content), &blogData)
	if err != nil {
		return nil, fmt.Errorf("failed to unmarshal blog content: %w", err)
	}

	blog, err := s.db.Blog.
		Create().
		SetUserID(userId).
		SetTitle(blogData.Title).
		SetContent(blogData.Content).
		Save(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to save blog: %w", err)
	}

	blogModel := &ent.Blog{
		ID:    blog.ID,
		Title: blog.Title,
		Content: blog.Content,
	}

	return blogModel, nil
}

func (s *BlogService) Delete(ctx context.Context, id string) (string, error) {
	err := s.db.Blog.DeleteOneID(id).Exec(context.Background())
	if err != nil {
		return "", fmt.Errorf("failed to delete blog: %w", err)
	}
	return id, nil
}