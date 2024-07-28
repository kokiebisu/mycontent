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

saga_base_packages=("saga-blog-processor")

# Function to process saga packages
process_saga_package() {
    echo "Processing saga package: $(basename "$1")"
    (cd "../$1" && make push-to-ecr)
}

# Process saga packages in parallel
for saga_base_package in "${saga_base_packages[@]}"; do
    saga_base_dir="packages/$saga_base_package"
    for saga_package in "$saga_base_dir"/*; do
        if [ -d "$saga_package" ]; then
            process_saga_package "$saga_package" &
        fi
    done
done

# Wait for all background processes to finish
wait

echo "All packages processed"