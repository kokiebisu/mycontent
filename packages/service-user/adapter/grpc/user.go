package grpc

import (
	"context"
	"time"

	"github.com/kokiebisu/mycontent/packages/service-user/port"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
	"github.com/kokiebisu/mycontent/packages/shared/proto"
)

type Adapter struct {
	UserService port.UserService
	proto.UnimplementedUserServiceServer
}

func NewGRPCAdapter(userService port.UserService) *Adapter {
	return &Adapter{UserService: userService}
}

func (a *Adapter) CreateUser(ctx context.Context, req *proto.CreateUserRequest) (*proto.CreateUserResponse, error) {
	user, err := a.UserService.Create(ctx, req.FirstName, req.LastName, req.Email, req.Password, enum.Interest(req.Interest), int(req.YearsOfExperience), req.Username, req.PublishTime)
	if err != nil {
		return nil, err
	}

	return &proto.CreateUserResponse{
		Id: user.ID.String(),
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Username: user.Username,
		Interest: user.Interest.String(),
		YearsOfExperience: int32(user.YearsOfExperience),
		PublishTime: user.PublishTime.Format(time.RFC3339),
		CreatedAt: user.CreatedAt.Format(time.RFC3339),
		UpdatedAt: user.UpdatedAt.Format(time.RFC3339),
	}, nil
}

func (a *Adapter) GetUserByEmail(ctx context.Context, req *proto.GetUserByEmailRequest) (*proto.GetUserByEmailResponse, error) {
	user, err := a.UserService.GetByEmail(ctx, req.Email)
	if err != nil {
		return nil, err
	}
	return &proto.GetUserByEmailResponse{
		Id: user.ID.String(),
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Username: user.Username,
		Password: user.Password,
		Interest: user.Interest.String(),
		YearsOfExperience: int32(user.YearsOfExperience),
		PublishTime: user.PublishTime.Format(time.RFC3339),
		CreatedAt: user.CreatedAt.Format(time.RFC3339),
		UpdatedAt: user.UpdatedAt.Format(time.RFC3339),
	}, nil
}

func (a *Adapter) DeleteUser(ctx context.Context, req *proto.DeleteUserRequest) (*proto.DeleteUserResponse, error) {
	userId, err := a.UserService.Delete(ctx, req.Id)
	if err != nil {
		return nil, err
	}
	return &proto.DeleteUserResponse{Id: userId}, nil
}