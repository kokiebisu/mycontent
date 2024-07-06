package service

import (
	"context"
	"strconv"

	"github.com/kokiebisu/mycontent/packages/service-user/ent"
	"github.com/kokiebisu/mycontent/packages/service-user/ent/user"
	"github.com/kokiebisu/mycontent/packages/service-user/graphql"
)

type UserService struct {
	db *ent.Client
}

func NewUserService(db *ent.Client) *UserService {
	return &UserService{db: db}
}

func (s *UserService) CreateUser(firstName string, lastName string, email string, password string, interest string, yearsOfExperience int, username string) (graphql.User, error) {
	user, err := s.db.User.Create().SetFirstName(firstName).SetLastName(lastName).SetEmail(email).SetPassword(password).SetInterest(user.Interest(interest)).SetYearsOfExperience(yearsOfExperience).SetUsername(username).Save(context.Background())
	if err != nil {
		return graphql.User{}, err
	}
	id := strconv.Itoa(user.ID)
	return graphql.User{
		ID: id,
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Password: user.Password,
	}, nil
}

func (s *UserService) GetUser(id string) (graphql.User, error) {
	idInt, err := strconv.Atoi(id)
	if err != nil {
		return graphql.User{}, err
	}
	user, err := s.db.User.Get(context.Background(), idInt)
	if err != nil {
		return graphql.User{}, err
	}
	return graphql.User{
		ID: id,
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Password: user.Password,
	}, nil
}

func (s *UserService) GetUsers() ([]*graphql.User, error) {
	entities, err := s.db.User.Query().All(context.Background())
	if err != nil {
		return nil, err
	}
	users := make([]*graphql.User, len(entities))
	for i, entity := range entities {
		id := strconv.Itoa(entity.ID)
		users[i] = &graphql.User{
			ID:        id,
			FirstName: entity.FirstName,
			LastName:  entity.LastName,
			Email:     entity.Email,
			Password:  entity.Password,
		}
	}
	return users, nil
}
