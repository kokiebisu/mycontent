package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/field"
	"github.com/google/uuid"
)

type Integration struct {
	ent.Schema
}

var PLATFORMS = []string{"ZENN", "QIITA", "MEDIUM"}

func (Integration) Fields() []ent.Field {
	return []ent.Field{
		field.UUID("id", uuid.UUID{}).
            Default(uuid.New),
		field.Enum("platform").Values(PLATFORMS...),
		field.String("api_key").MaxLen(255).Optional(),
		field.UUID("user_id", uuid.UUID{}),
		field.Time("created_at").Default(time.Now),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
	}
}