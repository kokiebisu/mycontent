package schema

import (
	"time"

	"entgo.io/contrib/entgql"
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
		field.Int("id").Unique().Immutable(),
		field.String("first_name").MaxLen(255).NotEmpty().Annotations(
			entgql.OrderField("FIRST_NAME"),
		),
		field.String("last_name").MaxLen(255).NotEmpty().Annotations(
			entgql.OrderField("LAST_NAME"),
		),
		field.String("email").MaxLen(255).NotEmpty().Annotations(
			entgql.OrderField("EMAIL"),
		),
		field.String("username").MaxLen(255).NotEmpty().Annotations(
			entgql.OrderField("USERNAME"),
		),
		field.String("password").MaxLen(255).NotEmpty().Annotations(
			entgql.OrderField("PASSWORD"),
		),
		field.Enum("interest").Values(INTERESTS...).Annotations(
			entgql.OrderField("INTEREST"),
		),
		field.Int("years_of_experience").Positive().Annotations(
			entgql.OrderField("YEARS_OF_EXPERIENCE"),
		),
		field.Time("created_at").Default(time.Now).Immutable(),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
	}
}

// Edges of the User.
func (User) Edges() []ent.Edge {
	return nil
}
