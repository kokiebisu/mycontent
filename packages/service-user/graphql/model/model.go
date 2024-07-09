// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package model

import (
	"github.com/kokiebisu/mycontent/packages/shared/enum"
)

type CreateUserInput struct {
	FirstName         string        `json:"firstName"`
	LastName          string        `json:"lastName"`
	Email             string        `json:"email"`
	Username          string        `json:"username"`
	Password          string        `json:"password"`
	Interest          enum.Interest `json:"interest"`
	YearsOfExperience int           `json:"yearsOfExperience"`
	PublishTime       string        `json:"publishTime"`
}

type UpdateUserInput struct {
	FirstName         string        `json:"firstName"`
	LastName          string        `json:"lastName"`
	Email             string        `json:"email"`
	Username          string        `json:"username"`
	Password          string        `json:"password"`
	Interest          enum.Interest `json:"interest"`
	YearsOfExperience int           `json:"yearsOfExperience"`
	PublishTime       string        `json:"publishTime"`
}
