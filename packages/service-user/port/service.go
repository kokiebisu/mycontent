package port

import (
	"context"

	"github.com/kokiebisu/mycontent/packages/shared/ent"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
)


type UserService interface {
	Create(ctx context.Context, firstName string, lastName string, email string, password string, interest enum.Interest, yearsOfExperience int, username string, publishTime string) (*ent.User, error)
	Get(ctx context.Context, id string) (*ent.User, error)
	GetAll(ctx context.Context) ([]*ent.User, error)
	GetByEmail(ctx context.Context, email string) (*ent.User, error)
	Update(ctx context.Context, id string, firstName string, lastName string, email string, password string, interest enum.Interest, yearsOfExperience int, username string) (*ent.User, error)
	UpdatePassword(ctx context.Context, id string, currentPassword string, newPassword string) (*ent.User, error)
	Delete(ctx context.Context, id string) (string, error)
}
