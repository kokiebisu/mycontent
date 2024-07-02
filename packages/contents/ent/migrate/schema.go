// Code generated by ent, DO NOT EDIT.

package migrate

import (
	"entgo.io/ent/dialect/sql/schema"
	"entgo.io/ent/schema/field"
)

var (
	// ContentsColumns holds the columns for the "contents" table.
	ContentsColumns = []*schema.Column{
		{Name: "id", Type: field.TypeInt, Increment: true},
		{Name: "content_type", Type: field.TypeString},
		{Name: "title", Type: field.TypeString},
		{Name: "creator", Type: field.TypeString},
		{Name: "image_url", Type: field.TypeString},
		{Name: "updated_at", Type: field.TypeTime},
	}
	// ContentsTable holds the schema information for the "contents" table.
	ContentsTable = &schema.Table{
		Name:       "contents",
		Columns:    ContentsColumns,
		PrimaryKey: []*schema.Column{ContentsColumns[0]},
	}
	// Tables holds all the tables in the schema.
	Tables = []*schema.Table{
		ContentsTable,
	}
)

func init() {
}
