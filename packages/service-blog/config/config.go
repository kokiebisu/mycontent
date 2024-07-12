package config

import (
	"github.com/joho/godotenv"
)

func LoadEnv() {
	// TODO: Add error handling
	godotenv.Load("./config/.env")
	// if err != nil {
	// 	log.Fatalf("Error loading .env file: %v", err)
	// }
}
