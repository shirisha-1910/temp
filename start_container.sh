#!/bin/bash
set -e

PORT=8000
ECR_REPO_URI="905418202800.dkr.ecr.ap-south-1.amazonaws.com/temp"
IMAGE_TAG="latest"  # Specify the image tag you want to use

# Authenticate Docker to your AWS ECR registry
echo "Authenticating Docker to AWS ECR..."
aws ecr get-login-password --region ap-south-1 | sudo docker login --username AWS --password-stdin $ECR_REPO_URI

# Pull the Docker image from AWS ECR
echo "Pulling Docker image from AWS ECR..."
sudo docker pull $ECR_REPO_URI:$IMAGE_TAG

# Run the Docker container
echo "Running Docker container..."
sudo docker run -d --name tempert -p 8000:80 $ECR_REPO_URI:$IMAGE_TAG

echo "HI Now it's running fine"
