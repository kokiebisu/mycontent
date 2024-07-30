#!/bin/bash

# Define an array of package directories
packages=("gateway" "service-user" "service-blog" "service-authentication")

# Function to process a package
process_package() {
    echo "Processing package: $1"
    (cd "../packages/$1" && make push-to-ecr)
}

# Process service packages in parallel
for package in "${packages[@]}"; do
    process_package "$package" &
done

