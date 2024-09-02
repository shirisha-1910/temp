#!/bin/bash
set -e

# Define your ECR repository and image tag
ECR_REPO_URI="905418202800.dkr.ecr.ap-south-1.amazonaws.com/temp"
IMAGE_TAG="latest"  # Specify the image tag you want to use
IMAGE_NAME="$ECR_REPO_URI:$IMAGE_TAG"
PORT=8000

# Authenticate Docker to your AWS ECR registry
echo "Authenticating Docker to AWS ECR..."
aws ecr get-login-password --region ap-south-1 | sudo docker login --username AWS --password-stdin $ECR_REPO_URI

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
    sudo docker stop "$CONTAINER_ID"
    sudo docker rm "$CONTAINER_ID"
  fi

  echo "Stopped existing container."
else
  echo "Port $PORT is not in use."
fi
