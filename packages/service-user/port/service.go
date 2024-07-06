package port

import "github.com/kokiebisu/mycontent/packages/service-user/graphql"

type UserService interface {
	Create(name string, email string, password string) (graphql.User, error)
	GetUser(id string) (graphql.User, error)
	GetUsers() ([]graphql.User, error)
	Update(id string, name string, email string, password string) (graphql.User, error)
	Delete(id string) (graphql.User, error)
}
