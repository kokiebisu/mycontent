// Code generated by ent, DO NOT EDIT.

package migrate

import (
	"entgo.io/ent/dialect/sql/schema"
	"entgo.io/ent/schema/field"
)

var (
	// UsersColumns holds the columns for the "users" table.
	UsersColumns = []*schema.Column{
		{Name: "id", Type: field.TypeUUID},
		{Name: "first_name", Type: field.TypeString, Size: 255},
		{Name: "last_name", Type: field.TypeString, Size: 255},
		{Name: "email", Type: field.TypeString, Size: 255},
		{Name: "username", Type: field.TypeString, Size: 255},
		{Name: "password", Type: field.TypeString, Size: 255},
		{Name: "interest", Type: field.TypeEnum, Enums: []string{"REACT", "NODEJS", "PYTHON", "GO", "RUST"}},
		{Name: "years_of_experience", Type: field.TypeInt},
		{Name: "created_at", Type: field.TypeTime},
		{Name: "updated_at", Type: field.TypeTime},
	}
	// UsersTable holds the schema information for the "users" table.
	UsersTable = &schema.Table{
		Name:       "users",
		Columns:    UsersColumns,
		PrimaryKey: []*schema.Column{UsersColumns[0]},
	}
	// Tables holds all the tables in the schema.
	Tables = []*schema.Table{
		UsersTable,
	}
)

func init() {
}
