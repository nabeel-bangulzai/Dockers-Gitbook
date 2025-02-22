# Docker Installation on Linux & Best Practices
## Introduction
Docker is a containerization platform that allows developers to package applications with their dependencies into lightweight, portable containers. This document provides a step-by-step guide on installing Docker on Linux and explores methodologies.

<p align="center">
  <img src="https://github.com/user-attachments/assets/c1bba9fe-52d3-457b-8ad1-a1ea2dc7d345" alt="Docker Installation" width="500">
</p>

## Installing Docker on Linux
### Step 1: Create this script:
```bash
#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
### Step 2: Save this file and assign execution rights:
```bash
sudo chmod +x docker.sh
```
### Step 3: Execute the script:
```bash
./docker.sh
```
### Step 4: Add your user in Docker group.(nabeel is user here)
```bash
sudo usermod -aG docker nabeel
```
### Step 5: Verify:
```bash
docker version
```
#### Output:
<p align="center">
  <img src="https://github.com/user-attachments/assets/79907471-6a1a-40c0-a108-90921cf8ef90" alt="Docker Installation" width="500">
</p>

## Running a Simple Nginx Container
### Step 1: Pulling the image:
```bash
docker pull nginx
```
#### verify:
```bash
docker images
```
#### Output:
<p align="center">
  <img src="https://github.com/user-attachments/assets/c57bd5ce-0514-4e80-99ca-f692d140faea" alt="Docker Installation" width="500">
</p>

### Step 2: Running the image:
```bash
docker run -d -p 8087:80 nginx
```
#### verify:
```bash
docker container ls
```
#### Output:
<p align="center">
  <img src="https://github.com/user-attachments/assets/e9662581-1fac-468a-b279-69840409cb0e" alt="Docker Installation" width="500">
</p>

### Step 3: access the container:
```bash
curl localhost:8087
```
#### Output:
<p align="center">
  <img src="https://github.com/user-attachments/assets/6a35d5b6-5fb5-460c-bf51-260af4db0e1a" alt="Docker Installation" width="500">
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/15c77b49-b564-4fc4-be9d-225f72de006a" alt="Docker Installation" width="500">
</p>

## Dockerfile & Docker Compose
### Why Use Dockerfile & Docker Compose?
* #### Dockerfile is used to automate the creation of Docker images, ensuring consistency across environments. It allows developers to define a customized image with specific dependencies, configurations, and application code.
* #### Docker Compose is used to define multi-container applications, simplifying service management. It allows defining services, networks, and volumes in a single file, making deployments easier.
## Sample Dockerfile
### Step 1: Create a Dockerfile
1. Create a new directory for your project:
```bash
mkdir webserver && cd webserver
```
2. Create a file named Dockerfile:
```bash
touch Dockerfile
```
3. Open the Dockerfile in a text editor and add your content:
```bash
# Use an official base image
FROM ubuntu:latest  

# Install necessary packages
RUN apt update && apt install -y nginx  

# Expose port 80 to allow external access
EXPOSE 80  

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
```
### Step 2: Build the Docker Image
1. Run the following command in the same directory where your Dockerfile is located:
```bash
docker build -t my-nginx-image .
```
* -t my-nginx-image assigns a name to the image.
* . means Docker should use the current directory as the build context.
### Step 3: Run a Container from the Image
```bash
docker run -d -p 8087:80 --name my-nginx-container my-nginx-image
```
* -d runs the container in detached mode.
* -p 8087:80 maps port 80 in the container to 8087 on the host.
* --name my-nginx-container names the container.
* my-nginx-image is the name of the image you just built.
## Sample Docker Compose
### Step 1: Install docker-compose
1. Install Docker Compose from Git Repo:
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
2. Assign Execution rights:
```bash
sudo chmod +x /usr/local/bin/docker-compose
```
3. Verify:
```bash
docker-compose
```
### Step 2: Create a docker-compose.yml File
1. Create a new directory for your project:
```bash
mkdir webserver-compose && cd webserver-compose
```
2. Create a docker-compose.yml file:
```bash
touch docker-compose.yml
```
3. Open the file in a text editor and add your content:
```bash
version: '3'
services:
  web:
    image: nginx:latest
    ports:
      - "8087:80"
```
* version: '3' → Defines the Docker Compose file version.
* services: → Declares the services to run.
* web: → Defines a service named web (container).
* image: nginx:latest → Uses the official Nginx image.
* ports: → Maps port 80 of the container to 8087 on the host.
### Step 3: Run Docker Compose
```bash
docker-compose up -d
```
* -d runs the containers in detached mode (background).
* Docker will pull the Nginx image if it’s not already downloaded and run the service.
