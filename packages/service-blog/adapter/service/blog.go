package service

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/google/uuid"

	"github.com/kokiebisu/mycontent/packages/service-blog/port"
	"github.com/kokiebisu/mycontent/packages/shared/ent"
	"github.com/kokiebisu/mycontent/packages/shared/ent/blog"
	"github.com/sashabaranov/go-openai"
)

type BlogService struct {
	db *ent.Client
}

func NewBlogService(db *ent.Client) port.BlogService {
	return &BlogService{db: db}
}

func (s *BlogService) Get(ctx context.Context, id string) (*ent.Blog, error) {
	uuidParsed, err := uuid.Parse(id)
	if err != nil {
		return nil, fmt.Errorf("failed to parse id: %w", err)
	}
	blog, err := s.db.Blog.Get(ctx, uuidParsed)
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

func (s *BlogService) GetAllByUserId(ctx context.Context, userId string) ([]*ent.Blog, error) {
	blogs, err := s.db.Blog.Query().Where(blog.UserIDEQ(userId)).All(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to get blogs: %w", err)
	}
	return blogs, nil
}

func (s *BlogService) Create(ctx context.Context, userId string, interest blog.Interest) (*ent.Blog, error) {
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
		SetInterest(interest).
		Save(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to save blog: %w", err)
	}

	blogModel := &ent.Blog{
		ID:    blog.ID,
		Title: blog.Title,
		Content:   blog.Content,
		CreatedAt: blog.CreatedAt,
		UpdatedAt: blog.UpdatedAt,
	}

	return blogModel, nil
}

func (s *BlogService) Delete(ctx context.Context, id string) (string, error) {
	uuidParsed, err := uuid.Parse(id)
	if err != nil {
		return "", fmt.Errorf("failed to parse id: %w", err)
	}
	err = s.db.Blog.DeleteOneID(uuidParsed).Exec(context.Background())
	if err != nil {
		return "", fmt.Errorf("failed to delete blog: %w", err)
	}
	// TODO: Should eventually delete from all blog platforms
	return id, nil
}