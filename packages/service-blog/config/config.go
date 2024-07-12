package config

import (
	"log"
	"os"
	"path/filepath"

	"github.com/joho/godotenv"
)

func LoadEnv() {
	// Get the current working directory
	cwd, err := os.Getwd()
	if err != nil {
		log.Printf("Warning: Error getting current working directory: %v", err)
		return
	}

	// Construct the path to the .env file
	envPath := filepath.Join(cwd, "packages", "service-blog", "config", ".env")

	// Attempt to load the .env file
	err = godotenv.Load(envPath)
	if err != nil {
		log.Printf("Warning: Error loading .env file: %v", err)
		log.Println("Continuing without .env file. Make sure environment variables are set correctly.")
	} else {
		log.Println("Successfully loaded .env file")
	}
}