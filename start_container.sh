#!/bin/bash
set -e

# Pull the Docker image from  ECR
docker pull 905418202800.dkr.ecr.ap-south-1.amazonaws.com/temp:latest

# Run the Docker image as a container
docker run -d -p 8000:8000 905418202800.dkr.ecr.ap-south-1.amazonaws.com/temp:latest