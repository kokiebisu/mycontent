package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/field"
	"github.com/google/uuid"
)

// User holds the schema definition for the User entity.
type User struct {
	ent.Schema
}

var INTERESTS = []string{"REACT", "NODEJS", "PYTHON", "GO", "RUST", "DOCKER", "KUBERNETES"}

// Fields of the User.
func (User) Fields() []ent.Field {
	return []ent.Field{
		field.UUID("id", uuid.UUID{}).
            Default(uuid.New),
		field.String("first_name").MaxLen(255).NotEmpty(),
		field.String("last_name").MaxLen(255).NotEmpty(),
		field.String("email").MaxLen(255).NotEmpty(),
		field.String("username").MaxLen(255).NotEmpty(),
		field.String("password").MaxLen(255).NotEmpty(),
		field.Enum("interest").Values(INTERESTS...),
		field.Int("years_of_experience").Positive(),
		field.Time("created_at").Default(time.Now).Immutable(),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
	}
}

// Edges of the User.
func (User) Edges() []ent.Edge {
	return nil
}
