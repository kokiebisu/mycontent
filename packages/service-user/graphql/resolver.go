package graphql

import (
	"github.com/99designs/gqlgen/graphql"
	"github.com/kokiebisu/mycontent/packages/service-user/ent"
)

type Resolver struct{
	Client *ent.Client
}

func NewSchema(client *ent.Client) graphql.ExecutableSchema {
	return NewExecutableSchema(Config{Resolvers: &Resolver{
		Client: client,
	}})
}