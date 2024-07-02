package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

// User holds the schema definition for the User entity.
type User struct {
	ent.Schema
}

// Fields of the User.
func (User) Fields() []ent.Field {
	return []ent.Field{
		field.String("name").MaxLen(255).NotEmpty(),
		field.String("email").MaxLen(255).NotEmpty(),
		field.Enum("personality_type").Values("INTJ", "INTP", "ENTP", "INFJ", "INFP", "ENTJ", "ISTJ", "ISFJ", "ISTP", "ISFP", "ESTP", "ESFP", "ESTJ", "ENFJ", "ENFP", "ESFJ"),
		field.String("username").MaxLen(255).NotEmpty(),
		field.String("password").MaxLen(255).NotEmpty(),
	}
}

// Edges of the User.
func (User) Edges() []ent.Edge {
	return nil
}
