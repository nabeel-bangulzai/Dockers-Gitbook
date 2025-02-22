# Use an official base image
FROM ubuntu:latest  

# Install necessary packages
RUN apt update && apt install -y nginx  

# Expose port 80 to allow external access
EXPOSE 80  

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
