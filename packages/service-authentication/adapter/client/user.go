package client

import (
	"context"
	"time"

	"github.com/google/uuid"

	"github.com/kokiebisu/mycontent/packages/shared/ent"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
	"github.com/kokiebisu/mycontent/packages/shared/proto"
)

type UserServiceClient struct {
	userClient proto.UserServiceClient
}

func NewUserServiceClient(userClient proto.UserServiceClient) *UserServiceClient {
	return &UserServiceClient{userClient: userClient}
}

func (s *UserServiceClient) CreateUser(ctx context.Context, firstName string, lastName string, email string, username string, interest enum.Interest, yearsOfExperience int, publishTime time.Time, password string) (*ent.User, error) {
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

	parsedCreatedAt, err := time.Parse(time.RFC3339, res.CreatedAt)
	if err != nil {
		return nil, err
	}

	parsedUpdatedAt, err := time.Parse(time.RFC3339, res.UpdatedAt)
	if err != nil {
		return nil, err
	}

	return &ent.User{
		ID: parsedId,
		FirstName: res.FirstName,
		LastName: res.LastName,
		Email: res.Email,
		Username: res.Username,
		Interest: enum.Interest(res.Interest),
		YearsOfExperience: int(res.YearsOfExperience),
		PublishTime: publishTime,
		Password: password,
		CreatedAt: parsedCreatedAt,
		UpdatedAt: parsedUpdatedAt,
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
	parsedCreatedAt, err := time.Parse(time.RFC3339, res.CreatedAt)
	if err != nil {
		return nil, err
	}
	parsedUpdatedAt, err := time.Parse(time.RFC3339, res.UpdatedAt)
	if err != nil {
		return nil, err
	}

	return &ent.User{
		ID: parsedId,
		FirstName: res.FirstName,
		LastName: res.LastName,
		Email: res.Email,
		Password: res.Password,
		Username: res.Username,
		Interest: enum.Interest(res.Interest),
		YearsOfExperience: int(res.YearsOfExperience),
		PublishTime: parsedPublishTime,
		CreatedAt: parsedCreatedAt,
		UpdatedAt: parsedUpdatedAt,
	}, nil
}


func (s *UserServiceClient) GetUserById(ctx context.Context, id string) (*ent.User, error) {
	res, err := s.userClient.GetById(ctx, &proto.GetByIdRequest{
		Id: id,
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


func (s *UserServiceClient) DeleteUser(ctx context.Context, id string) (string, error) {
	res, err := s.userClient.DeleteUser(ctx, &proto.DeleteUserRequest{
		Id: id,
	})
	if err != nil {
		return "", err
	}

	return res.Id, nil
}
