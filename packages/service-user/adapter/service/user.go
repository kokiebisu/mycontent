package service

import (
	"context"
	"strconv"

	"github.com/kokiebisu/mycontent/packages/service-user/ent"
	"github.com/kokiebisu/mycontent/packages/service-user/ent/user"
	"github.com/kokiebisu/mycontent/packages/service-user/graphql/model"
)

type UserService struct {
	db *ent.Client
}

func NewUserService(db *ent.Client) *UserService {
	return &UserService{db: db}
}

func (s *UserService) Create(firstName string, lastName string, email string, password string, interest model.Interest, yearsOfExperience int, username string) (*model.User, error) {
	user, err := s.db.User.Create().SetFirstName(firstName).SetLastName(lastName).SetEmail(email).SetPassword(password).SetInterest(user.Interest(interest)).SetYearsOfExperience(yearsOfExperience).SetUsername(username).Save(context.Background())
	if err != nil {
		return &model.User{}, err
	}
	id := strconv.Itoa(user.ID)
	return &model.User{
		ID: id,
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Password: user.Password,
		Interest: model.Interest(user.Interest),
		YearsOfExperience: user.YearsOfExperience,
		Username: user.Username,
	}, nil
}

func (s *UserService) Get(id string) (*model.User, error) {
	idInt, err := strconv.Atoi(id)
	if err != nil {
		return &model.User{}, err
	}
	user, err := s.db.User.Get(context.Background(), idInt)
	if err != nil {
		return &model.User{}, err
	}
	return &model.User{
		ID: id,
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Password: user.Password,
		Interest: model.Interest(user.Interest),
		YearsOfExperience: user.YearsOfExperience,
		Username: user.Username,
	}, nil
}

func (s *UserService) GetAll() ([]*model.User, error) {
	entities, err := s.db.User.Query().All(context.Background())
	if err != nil {
		return nil, err
	}
	users := make([]*model.User, len(entities))
	for i, entity := range entities {
		id := strconv.Itoa(entity.ID)
		users[i] = &model.User{
			ID:        id,
			FirstName: entity.FirstName,
			LastName:  entity.LastName,
			Email:     entity.Email,
			Password:  entity.Password,
			Interest: model.Interest(entity.Interest),
			YearsOfExperience: entity.YearsOfExperience,
			Username: entity.Username,
		}
	}
	return users, nil
}

func (s *UserService) Update(ctx context.Context, id string, firstName string, lastName string, email string, password string, interest model.Interest, yearsOfExperience int, username string) (*model.User, error) {
	idInt, err := strconv.Atoi(id)
	if err != nil {
		return &model.User{}, err
	}
	user, err := s.db.User.Get(context.Background(), idInt)
	if err != nil {
		return &model.User{}, err
	}
	user, err = user.Update().SetFirstName(firstName).SetLastName(lastName).SetEmail(email).SetPassword(password).SetInterest(interest).SetYearsOfExperience(yearsOfExperience).SetUsername(username).Save(context.Background())
	if err != nil {
		return &model.User{}, err
	}

	return &model.User{
		ID:                id,
		FirstName:         user.FirstName,
		LastName:          user.LastName,
		Email:             user.Email,
		Password:          user.Password,
		Interest:          model.Interest(user.Interest),
		YearsOfExperience: user.YearsOfExperience,
		Username:          user.Username,
	}, nil
}

func (s *UserService) Delete(ctx context.Context, id string) (string, error) {
	idInt, err := strconv.Atoi(id)
	if err != nil {
		return "", err
	}
	if err := s.db.User.DeleteOneID(idInt).Exec(context.Background()); err != nil {
		return "", err
	}
	return id, nil
}