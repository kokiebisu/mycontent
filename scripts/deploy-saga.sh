#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

saga_base_packages=("saga-blog-processor")

# Function to process saga packages
process_saga_package() {
    echo "Processing saga package: $(basename "$1")"
    (cd "$1" && make push-to-ecr)
}

# Process saga packages in parallel
for saga_base_package in "${saga_base_packages[@]}"; do
    saga_base_dir="$SCRIPT_DIR/../packages/$saga_base_package"
    for saga_package in "$saga_base_dir"/*; do
        if [ -d "$saga_package" ]; then
            process_saga_package "$saga_package" &
        fi
    done
done

# Wait for all background processes to finish
wait