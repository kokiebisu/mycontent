package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema"
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
		field.String("id").Unique().Immutable(),
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

func (User) Annotations() []schema.Annotation {
	return []schema.Annotation{
			MethodAnnotation{},
	}
}

// MethodAnnotation implements the schema.Annotation interface.
type MethodAnnotation struct{}

// Name implements schema.Annotation interface.
func (MethodAnnotation) Name() string {
    return "IsEntity"
}

// Merge implements schema.Annotation interface.
func (MethodAnnotation) Merge(other schema.Annotation) schema.Annotation {
    return nil
}

// Decode implements schema.Annotation interface.
func (MethodAnnotation) Decode(data interface{}) error {
    return nil
}
