#!/bin/bash

# Function to check if pre-commit is installed, and install if not
install_pre_commit() {
    if ! command -v pre-commit &> /dev/null; then
        echo "pre-commit is not installed. Installing it now..."
        pip install pre-commit
        if [ $? -ne 0 ]; then
            echo "Failed to install pre-commit. Please install it manually."
            exit 1
        fi
        echo "pre-commit installed successfully."
    fi
}

# Function to check if git is installed, and install if not
install_git() {
    if ! command -v git &> /dev/null; then
        echo "git is not installed. Please install git and try again."
        exit 1
    fi
}

# Function to check if pre-commit is initialized
check_pre_commit_initialized() {
    if [ ! -f .pre-commit-config.yaml ]; then
        echo ".pre-commit-config.yaml not found. Please initialize pre-commit using 'pre-commit install' and configure it."
        exit 1
    fi
}

# Function to check if it's a git repository, if not, initialize it
check_git_repo() {
    if [ ! -d .git ]; then
        echo "Not a git repository. Initializing git repository..."
        git init -b main
        if [ $? -ne 0 ]; then
            echo "Failed to initialize git repository. Please check your Git installation."
            exit 1
        fi
    fi
}

# Main script execution
install_git
install_pre_commit
check_git_repo
check_pre_commit_initialized

git add .
# Run pre-commit hooks on all files
pre-commit run --all-files

