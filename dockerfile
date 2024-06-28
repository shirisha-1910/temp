FROM amazonlinux:latest

# Install NGINX
RUN yum update -y && \
    yum install -y nginx && \
    yum clean all

# Copy your HTML files and NGINX configuration
COPY temp.html /usr/share/nginx/html/index.html
COPY temp.jpg /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]

docker build -t temperature-converter .
docker run -p 8080:80 temperature-converter
