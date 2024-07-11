package enum

import "fmt"

type Role string

const (
	User Role = "user"
	Admin Role = "admin"
)

func (r Role) IsValid() bool {
	return r == User || r == Admin
}

func AllRoles() []Role {
	return []Role{User, Admin}
}

func (Role) Values() []string {
	return []string{User.String(), Admin.String()}
}

func (r Role) String() string {
	return string(r)
}

func (r Role) Validate() error {
	if !r.IsValid() {
		return fmt.Errorf("invalid role: %s", r)
	}
	return nil
}
