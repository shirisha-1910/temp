#!/bin/bash

# Pull the latest Docker image from Docker Hub
docker pull sirishassss/new-temp:latest

# Stop any existing containers running the previous version
docker stop new-temp-container || true
docker rm new-temp-container || true

# Run a new container with the updated image
docker run -d --name new-temp-container -p 8080:80 sirishassss/new-temp:latest
