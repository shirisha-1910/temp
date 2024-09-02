#!/bin/bash
set -e

# Define your ECR repository and image tag
ECR_REPO_URI="905418202800.dkr.ecr.ap-south-1.amazonaws.com/temp"
IMAGE_TAG="latest"  # Specify the image tag you want to use
IMAGE_NAME="$ECR_REPO_URI:$IMAGE_TAG"
PORT=8000

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
  echo "AWS CLI could not be found. Please install AWS CLI."
  exit 1
fi

# Authenticate Docker to your AWS ECR registry
echo "Authenticating Docker to AWS ECR..."
if ! aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ECR_REPO_URI; then
  echo "Failed to authenticate Docker to AWS ECR."
  exit 1
fi

# Start the Docker container
echo "Starting Docker container..."
if ! sudo docker run -d -p $PORT:8000 --name my_container $IMAGE_NAME; then
  echo "Failed to start Docker container."
  exit 1
fi

echo "Docker container started successfully."
