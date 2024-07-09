package service

import (
	"context"
	"time"

	"github.com/google/uuid"

	"github.com/kokiebisu/mycontent/packages/shared/ent"
	"github.com/kokiebisu/mycontent/packages/shared/ent/user"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
)

type UserService struct {
	db *ent.Client
}

func NewUserService(db *ent.Client) *UserService {
	return &UserService{db: db}
}

func (s *UserService) Create(ctx context.Context, firstName string, lastName string, email string, password string, interest enum.Interest, yearsOfExperience int, username string, publishTime string) (*ent.User, error) {
	var parsedPublishTime time.Time
	var err error
	formats := []string{"15:04", "15", "3:04PM", "3PM"}
	for _, format := range formats {
		parsedPublishTime, err = time.Parse(format, publishTime)
		if err == nil {
			break
		}
	}

	if err != nil {
		return &ent.User{}, err
	}
	user, err := s.db.User.Create().SetFirstName(firstName).SetLastName(lastName).SetEmail(email).SetPassword(password).SetInterest(interest).SetYearsOfExperience(yearsOfExperience).SetUsername(username).SetPublishTime(parsedPublishTime).SetID(uuid.New()).Save(context.Background())
	if err != nil {
		return &ent.User{}, err
	}
	return &ent.User{
		ID: user.ID,
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Password: user.Password,
		Interest: user.Interest,
		YearsOfExperience: user.YearsOfExperience,
		Username: user.Username,
		PublishTime: user.PublishTime,
		CreatedAt: user.CreatedAt,
		UpdatedAt: user.UpdatedAt,
	}, nil
}

func (s *UserService) Get(ctx context.Context, id string) (*ent.User, error) {
	uuidParsed, err := uuid.Parse(id)
	if err != nil {
		return &ent.User{}, err
	}
	user, err := s.db.User.Get(context.Background(), uuidParsed)
	if err != nil {
		return &ent.User{}, err
	}
	return &ent.User{
		ID: uuidParsed,
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
		Password: user.Password,
		Interest: user.Interest,
		YearsOfExperience: user.YearsOfExperience,
		Username: user.Username,
		PublishTime: user.PublishTime,
		CreatedAt: user.CreatedAt,
		UpdatedAt: user.UpdatedAt,
	}, nil
}

func (s *UserService) GetAll(ctx context.Context) ([]*ent.User, error) {
	entities, err := s.db.User.Query().All(context.Background())
	if err != nil {
		return nil, err
	}
	users := make([]*ent.User, len(entities))
	for i, entity := range entities {
		users[i] = &ent.User{
			ID:        entity.ID,
			FirstName: entity.FirstName,
			LastName:  entity.LastName,
			Email:     entity.Email,
			Password:  entity.Password,
			Interest: enum.Interest(entity.Interest),
			YearsOfExperience: entity.YearsOfExperience,
			Username: entity.Username,
			PublishTime: entity.PublishTime,
			CreatedAt: entity.CreatedAt,
			UpdatedAt: entity.UpdatedAt,
		}
	}
	return users, nil
}

func (s *UserService) Update(ctx context.Context, id string, firstName string, lastName string, email string, password string, interest enum.Interest, yearsOfExperience int, username string) (*ent.User, error) {
	uuidParsed, err := uuid.Parse(id)
	if err != nil {
		return &ent.User{}, err
	}
	user, err := s.db.User.Get(context.Background(), uuidParsed)
	if err != nil {
		return &ent.User{}, err
	}
	user, err = user.Update().SetFirstName(firstName).SetLastName(lastName).SetEmail(email).SetPassword(password).SetInterest(interest).SetYearsOfExperience(yearsOfExperience).SetUsername(username).Save(context.Background())
	if err != nil {
		return &ent.User{}, err
	}

	return &ent.User{
		ID:                uuidParsed,
		FirstName:         user.FirstName,
		LastName:          user.LastName,
		Email:             user.Email,
		Password:          user.Password,
		Interest:          user.Interest,
		YearsOfExperience: user.YearsOfExperience,
		Username:          user.Username,
		PublishTime:       user.PublishTime,
		CreatedAt:         user.CreatedAt,
		UpdatedAt:         user.UpdatedAt,
	}, nil
}

func (s *UserService) Delete(ctx context.Context, id string) (string, error) {
	uuidParsed, err := uuid.Parse(id)
	if err != nil {
		return "", err
	}
	if err := s.db.User.DeleteOneID(uuidParsed).Exec(context.Background()); err != nil {
		return "", err
	}
	return id, nil
}

func (s *UserService) GetByEmail(ctx context.Context, email string) (*ent.User, error) {
	user, err := s.db.User.Query().Where(user.Email(email)).First(context.Background())
	if err != nil || user == nil {
		return nil, err
	}
	return user, nil
}
