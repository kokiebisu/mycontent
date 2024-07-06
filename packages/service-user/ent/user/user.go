// Code generated by ent, DO NOT EDIT.

package user

import (
	"fmt"
	"io"
	"strconv"
	"time"

	"entgo.io/ent/dialect/sql"
)

const (
	// Label holds the string label denoting the user type in the database.
	Label = "user"
	// FieldID holds the string denoting the id field in the database.
	FieldID = "id"
	// FieldFirstName holds the string denoting the first_name field in the database.
	FieldFirstName = "first_name"
	// FieldLastName holds the string denoting the last_name field in the database.
	FieldLastName = "last_name"
	// FieldEmail holds the string denoting the email field in the database.
	FieldEmail = "email"
	// FieldUsername holds the string denoting the username field in the database.
	FieldUsername = "username"
	// FieldPassword holds the string denoting the password field in the database.
	FieldPassword = "password"
	// FieldInterest holds the string denoting the interest field in the database.
	FieldInterest = "interest"
	// FieldYearsOfExperience holds the string denoting the years_of_experience field in the database.
	FieldYearsOfExperience = "years_of_experience"
	// FieldCreatedAt holds the string denoting the created_at field in the database.
	FieldCreatedAt = "created_at"
	// FieldUpdatedAt holds the string denoting the updated_at field in the database.
	FieldUpdatedAt = "updated_at"
	// Table holds the table name of the user in the database.
	Table = "users"
)

// Columns holds all SQL columns for user fields.
var Columns = []string{
	FieldID,
	FieldFirstName,
	FieldLastName,
	FieldEmail,
	FieldUsername,
	FieldPassword,
	FieldInterest,
	FieldYearsOfExperience,
	FieldCreatedAt,
	FieldUpdatedAt,
}

// ValidColumn reports if the column name is valid (part of the table columns).
func ValidColumn(column string) bool {
	for i := range Columns {
		if column == Columns[i] {
			return true
		}
	}
	return false
}

var (
	// FirstNameValidator is a validator for the "first_name" field. It is called by the builders before save.
	FirstNameValidator func(string) error
	// LastNameValidator is a validator for the "last_name" field. It is called by the builders before save.
	LastNameValidator func(string) error
	// EmailValidator is a validator for the "email" field. It is called by the builders before save.
	EmailValidator func(string) error
	// UsernameValidator is a validator for the "username" field. It is called by the builders before save.
	UsernameValidator func(string) error
	// PasswordValidator is a validator for the "password" field. It is called by the builders before save.
	PasswordValidator func(string) error
	// YearsOfExperienceValidator is a validator for the "years_of_experience" field. It is called by the builders before save.
	YearsOfExperienceValidator func(int) error
	// DefaultCreatedAt holds the default value on creation for the "created_at" field.
	DefaultCreatedAt func() time.Time
	// DefaultUpdatedAt holds the default value on creation for the "updated_at" field.
	DefaultUpdatedAt func() time.Time
	// UpdateDefaultUpdatedAt holds the default value on update for the "updated_at" field.
	UpdateDefaultUpdatedAt func() time.Time
)

// Interest defines the type for the "interest" enum field.
type Interest string

// Interest values.
const (
	InterestReact      Interest = "react"
	InterestNodejs     Interest = "nodejs"
	InterestPython     Interest = "python"
	InterestGo         Interest = "go"
	InterestRust       Interest = "rust"
	InterestDocker     Interest = "docker"
	InterestKubernetes Interest = "kubernetes"
	InterestAWS        Interest = "aws"
	InterestGcp        Interest = "gcp"
	InterestAzure      Interest = "azure"
	InterestTerraform  Interest = "terraform"
	InterestGit        Interest = "git"
)

func (i Interest) String() string {
	return string(i)
}

// InterestValidator is a validator for the "interest" field enum values. It is called by the builders before save.
func InterestValidator(i Interest) error {
	switch i {
	case InterestReact, InterestNodejs, InterestPython, InterestGo, InterestRust, InterestDocker, InterestKubernetes, InterestAWS, InterestGcp, InterestAzure, InterestTerraform, InterestGit:
		return nil
	default:
		return fmt.Errorf("user: invalid enum value for interest field: %q", i)
	}
}

// OrderOption defines the ordering options for the User queries.
type OrderOption func(*sql.Selector)

// ByID orders the results by the id field.
func ByID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldID, opts...).ToFunc()
}

// ByFirstName orders the results by the first_name field.
func ByFirstName(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldFirstName, opts...).ToFunc()
}

// ByLastName orders the results by the last_name field.
func ByLastName(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldLastName, opts...).ToFunc()
}

// ByEmail orders the results by the email field.
func ByEmail(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEmail, opts...).ToFunc()
}

// ByUsername orders the results by the username field.
func ByUsername(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldUsername, opts...).ToFunc()
}

// ByPassword orders the results by the password field.
func ByPassword(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldPassword, opts...).ToFunc()
}

// ByInterest orders the results by the interest field.
func ByInterest(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldInterest, opts...).ToFunc()
}

// ByYearsOfExperience orders the results by the years_of_experience field.
func ByYearsOfExperience(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldYearsOfExperience, opts...).ToFunc()
}

// ByCreatedAt orders the results by the created_at field.
func ByCreatedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldCreatedAt, opts...).ToFunc()
}

// ByUpdatedAt orders the results by the updated_at field.
func ByUpdatedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldUpdatedAt, opts...).ToFunc()
}

// MarshalGQL implements graphql.Marshaler interface.
func (e Interest) MarshalGQL(w io.Writer) {
	io.WriteString(w, strconv.Quote(e.String()))
}

// UnmarshalGQL implements graphql.Unmarshaler interface.
func (e *Interest) UnmarshalGQL(val interface{}) error {
	str, ok := val.(string)
	if !ok {
		return fmt.Errorf("enum %T must be a string", val)
	}
	*e = Interest(str)
	if err := InterestValidator(*e); err != nil {
		return fmt.Errorf("%s is not a valid Interest", str)
	}
	return nil
}
