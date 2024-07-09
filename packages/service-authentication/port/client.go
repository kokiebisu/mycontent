package port

import (
	"context"
	"time"

	"github.com/kokiebisu/mycontent/packages/shared/ent"
	"github.com/kokiebisu/mycontent/packages/shared/enum"
)

type UserServiceClient interface {
	GetByID(ctx context.Context, id string) (*ent.User, error)
	CreateUser(ctx context.Context, firstName string, lastName string, email string, username string, interest enum.Interest, yearsOfExperience int, publishTime time.Time, password string) (*ent.User, error)
	GetUserByEmail(ctx context.Context, email string) (*ent.User, error)
}
