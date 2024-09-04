#!/bin/bash
set -e

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install required packages
echo "Installing required packages..."
sudo apt-get install -y unzip curl

# Download the AWS CLI version 2 package
echo "Downloading AWS CLI version 2..."
curl "https://d1uj6qtbmh3dt5.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the package
echo "Unzipping AWS CLI version 2 package..."
unzip awscliv2.zip

# Install AWS CLI version 2
echo "Installing AWS CLI version 2..."
sudo ./aws/install

# Verify installation
echo "Verifying AWS CLI installation..."
aws --version

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
