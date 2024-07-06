//go:build ignore
// +build ignore

package main

import (
	"log"

	"entgo.io/contrib/entgql"
	"entgo.io/ent/entc"
	"entgo.io/ent/entc/gen"
)

func main() {
	entGqlEx, err := entgql.NewExtension(
    entgql.WithConfigPath("../gqlgen.yml"),
		entgql.WithSchemaGenerator(),
		entgql.WithSchemaPath("../graphql/schema.graphql"),
	)
  if err != nil {
    log.Fatalf("creating entgql extension: %v", err)
  }
  if err := entc.Generate("../ent/schema", &gen.Config{}, entc.Extensions(entGqlEx)); err != nil {
    log.Fatalf("running ent codegen: %v", err)
  }
}