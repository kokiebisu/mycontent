package types

type User struct {
	ID string `json:"id"`
	FirstName string `json:"first_name"`
	LastName string `json:"last_name"`
	Email string `json:"email"`
	Username string `json:"username"`
	Interest string `json:"interest"`
	YearsOfExperience int `json:"years_of_experience"`
	PublishTime string `json:"publish_time"`
	Password string `json:"password"`
}
