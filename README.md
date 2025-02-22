# Docker Installation on Linux & Best Practices
## Introduction
Docker is a containerization platform that allows developers to package applications with their dependencies into lightweight, portable containers. This document provides a step-by-step guide on installing Docker on Linux and explores methodologies.

<p align="center">
  <img src="https://github.com/user-attachments/assets/c1bba9fe-52d3-457b-8ad1-a1ea2dc7d345" alt="Docker Installation" width="500">
</p>

## Installing Docker on Linux
### Step 1: Create this script.
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
### Step 2: Save this file and assign execution rights.
```bash
sudo chmod +x docker.sh
```
### Step 3: Execute the script.
```bash
./docker.sh
```
### Step 4: Add your user in Docker group.(nabeel is user here)
```bash
sudo usermod -aG docker nabeel
```
### Step 5: Verify.
```bash
docker version
```
### Output:
<p align="center">
  <img src="https://github.com/user-attachments/assets/79907471-6a1a-40c0-a108-90921cf8ef90" alt="Docker Installation" width="500">
</p>


