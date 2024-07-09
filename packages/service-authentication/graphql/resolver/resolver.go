package resolver

import "github.com/kokiebisu/mycontent/packages/service-authentication/port"

type Resolver struct{
	UserServiceClient port.UserServiceClient
	TokenService port.TokenService
}
