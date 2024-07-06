package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

// User holds the schema definition for the User entity.
type User struct {
	ent.Schema
}

var INTERESTS = []string{"react", "nodejs", "python", "go", "rust", "docker", "kubernetes", "aws", "gcp", "azure", "terraform", "git"}

// Fields of the User.
func (User) Fields() []ent.Field {
	return []ent.Field{
		field.String("first_name").MaxLen(255).NotEmpty(),
		field.String("last_name").MaxLen(255).NotEmpty(),
		field.String("email").MaxLen(255).NotEmpty(),
		field.String("username").MaxLen(255).NotEmpty(),
		field.String("password").MaxLen(255).NotEmpty(),
		field.Enum("interest").Values(INTERESTS...),
		field.Int("years_of_experience").Positive(),
	}
}

// Edges of the User.
func (User) Edges() []ent.Edge {
	return nil
}
