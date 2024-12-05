# Step 1: Build the React application
FROM node:16 AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy the project files into the Docker image
COPY . .

# Copy the .env file
COPY .env.local .env

# Install dependencies
RUN npm install

# Build the project
RUN npm run build

# Step 2: Serve the app directly using a Node.js server
FROM node:16

# Set the working directory
WORKDIR /usr/src/app

# Copy the build files from the build stage
COPY --from=build /usr/src/app/dist/ ./dist

# Copy the .env file (optional for runtime use)
 COPY --from=build /usr/src/app/.env .env

# Install a lightweight static file server (e.g., serve)
RUN npm install -g serve

# Expose port 3001 for the HTTP server
EXPOSE 3001

# Command to serve the app on port 3001
CMD ["serve", "-s", "dist", "-l", "3001"]
