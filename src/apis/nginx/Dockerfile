# Use a stable version of nginx based on Alpine for lightweight image
FROM nginx:stable-alpine

# Copy the Nginx configuration file
COPY default.conf /etc/nginx
COPY default.conf /etc/nginx/conf.d/

# Expose port 80 for HTTP traffic
EXPOSE 80
