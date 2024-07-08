package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/field"
	"github.com/google/uuid"
)

type Blog struct {
	ent.Schema
}

var INTERESTS = []string{"REACT", "NODEJS", "PYTHON", "GO", "RUST", "DOCKER", "KUBERNETES"}

// Fields of the Content.
func (Blog) Fields() []ent.Field {
	return []ent.Field{
		field.UUID("id", uuid.UUID{}).
            Default(uuid.New),
		field.String("title"),
		field.String("content"),
		field.String("user_id"),
		field.Enum("interest").Values(INTERESTS...),
		field.Time("created_at").Default(time.Now).Immutable(),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
	}
}

// Edges of the Content.
func (Blog) Edges() []ent.Edge {
	return nil
}
