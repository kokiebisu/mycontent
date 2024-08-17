#!/bin/bash

# Define an array of package directories
packages=("gateway" "service-user" "service-blog" "service-authentication" "web")

# Function to process a package
process_package() {
    echo "Processing package: $1"
    (cd "../packages/$1" && make push-to-ecr)
}

# Array to store background process PIDs
pids=()

# Process service packages in parallel
for package in "${packages[@]}"; do
    process_package "$package" &
    pids+=($!)
done

# Wait for all background processes to complete
for pid in "${pids[@]}"; do
    wait $pid
done

echo "All packages processed successfully"
