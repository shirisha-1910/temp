#!/bin/bash
set -e

# Set the region and repository URL
REGION="ap-south-1"
REPO_URL="905418202800.dkr.ecr.${REGION}.amazonaws.com/temp:latest"

# Authenticate Docker to the ECR registry
echo "Authenticating Docker to ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin 905418202800.dkr.ecr.${REGION}.amazonaws.com

# Pull the Docker image from ECR
echo "Pulling Docker image from ECR..."
docker pull $REPO_URL

# Run the Docker image as a container
echo "Running Docker container..."
docker run -d -p 8000:8000 $REPO_URL
