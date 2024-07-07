package resolver

import "github.com/kokiebisu/mycontent/packages/service-user/port"

// This file will not be regenerated automatically.
//
// It serves as dependency injection for your app, add any dependencies you require here.

type Resolver struct{
	UserService port.UserService
}
