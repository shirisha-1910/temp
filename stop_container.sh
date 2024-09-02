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

# Check if port is in use
if sudo lsof -i :$PORT > /dev/null; then
  echo "Port $PORT is in use. Stopping existing container..."

  # Get the container ID running the image
  CONTAINER_ID=$(sudo docker ps -q --filter "ancestor=$IMAGE_NAME")

  # Check if a container ID was found
  if [ -z "$CONTAINER_ID" ]; then
    echo "No running container found for image $IMAGE_NAME."
  else
    echo "Stopping container with ID $CONTAINER_ID..."
    if ! sudo docker stop "$CONTAINER_ID"; then
      echo "Failed to stop container."
      exit 1
    fi
    if ! sudo docker rm "$CONTAINER_ID"; then
      echo "Failed to remove container."
      exit 1
    fi
    echo "Stopped and removed existing container."
  fi
else
  echo "Port $PORT is not in use."
fi
