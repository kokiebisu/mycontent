package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

type Blog struct {
	ent.Schema
}

var INTERESTS = []string{"REACT", "NODEJS", "PYTHON", "GO", "RUST"}

// Fields of the Content.
func (Blog) Fields() []ent.Field {
	return []ent.Field{
		field.String("id").Unique(),
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
