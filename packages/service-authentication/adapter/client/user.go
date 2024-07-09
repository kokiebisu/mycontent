package client

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/kokiebisu/mycontent/packages/service-user/ent"
	"github.com/kokiebisu/mycontent/packages/service-user/ent/user"
	"github.com/kokiebisu/mycontent/packages/service-user/proto"
)

type UserServiceClient struct {
	userClient proto.UserServiceClient
}

func NewUserServiceClient(userClient proto.UserServiceClient) *UserServiceClient {
	return &UserServiceClient{userClient: userClient}
}

func (s *UserServiceClient) CreateUser(ctx context.Context, firstName string, lastName string, email string, username string, interest user.Interest, yearsOfExperience int, publishTime time.Time, password string) (*ent.User, error) {
	res, err := s.userClient.CreateUser(ctx, &proto.CreateUserRequest{
		FirstName: firstName,
		LastName: lastName,
		Email: email,
		Username: username,
		Interest: interest.String(),
		YearsOfExperience: int32(yearsOfExperience),
		PublishTime: publishTime.Format(time.RFC3339),
		Password: password,
	})
	if err != nil {
		return nil, err
	}

	parsedId, err := uuid.Parse(res.Id)
	if err != nil {
		return nil, err
	}

	return &ent.User{
		ID: parsedId,
	}, nil
}

func (s *UserServiceClient) GetUserByEmail(ctx context.Context, email string) (*ent.User, error) {
	res, err := s.userClient.GetUserByEmail(ctx, &proto.GetUserByEmailRequest{
		Email: email,
	})
	if err != nil {
		return nil, err
	}
	parsedId, err := uuid.Parse(res.Id)
	if err != nil {
		return nil, err
	}

	parsedPublishTime, err := time.Parse(time.RFC3339, res.PublishTime)
	if err != nil {
		return nil, err
	}

	return &ent.User{
		ID: parsedId,
		FirstName: res.FirstName,
		LastName: res.LastName,
		Email: res.Email,
		Username: res.Username,
		Interest: user.Interest(res.Interest),
		YearsOfExperience: int(res.YearsOfExperience),
		PublishTime: parsedPublishTime,
	}, nil
}