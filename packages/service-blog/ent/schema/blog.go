package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

type Blog struct {
	ent.Schema
}

// Fields of the Content.
func (Blog) Fields() []ent.Field {
	return []ent.Field{
		field.String("title"),
		field.String("content"),
		field.String("user_id"),
		field.Time("created_at").Default(time.Now).UpdateDefault(time.Now),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
	}
}

// Edges of the Content.
func (Blog) Edges() []ent.Edge {
	return nil
}
