#!/bin/bash

# Ensure the script is executed inside a Git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: This script must be run inside a Git repository."
    exit 1
fi

# Get the repository folder name
REPO_PATH=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_PATH")

# Define files to update
DEVCONTAINER_FILE="$REPO_PATH/.devcontainer/devcontainer.json"
DOCKER_COMPOSE_FILE="$REPO_PATH/docker-compose.yml"

# Function to replace "infra" with the repository name
replace_in_file() {
    local file=$1
    if [[ -f "$file" ]]; then
        sed -i "s/infra/$REPO_NAME/g" "$file"
        echo "Updated: $file"
    else
        echo "Warning: $file not found."
    fi
}

# Perform replacements
replace_in_file "$DEVCONTAINER_FILE"
replace_in_file "$DOCKER_COMPOSE_FILE"

echo "Replacement complete."
rm -rf rewrite.sh
echo "deleting rewrite.sh"