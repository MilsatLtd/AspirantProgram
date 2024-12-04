# Step 1: Build the React application
FROM node:16 AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy the project files into the docker image
COPY . .

# Copy the .env file
COPY .env .env

# Install dependencies
RUN npm install

# Build the project
RUN npm run build

# Step 2: Serve the app from Nginx
FROM nginx:alpine

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the build files from the build stage
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

# Copy the .env file (optional for runtime use)
COPY --from=build /usr/src/app/.env /usr/share/nginx/html/.env

# Expose port 3001 for the HTTP server
EXPOSE 3001

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
