package resolver

import "github.com/kokiebisu/mycontent/packages/service-blog/port"

type Resolver struct{
	BlogService port.BlogService
	IntegrationService port.IntegrationService
	StorageService port.StorageService
}
