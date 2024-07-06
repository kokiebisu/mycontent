package port

import "github.com/kokiebisu/mycontent/packages/service-user/graphql/model"


type UserService interface {
	Create(name string, email string, password string) (model.User, error)
	GetUser(id string) (model.User, error)
	GetUsers() ([]model.User, error)
	Update(id string, name string, email string, password string) (model.User, error)
	Delete(id string) (model.User, error)
}
