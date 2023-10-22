# Step 1: Build the Next.js application
FROM node:16 AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy the project files into the docker image
COPY . .

# Install dependencies
RUN npm install

# Build the project
RUN npm run build

# Step 2: Serve the app
FROM node:16

# Set the working directory
WORKDIR /usr/src/app

# Copy the build files from the build stage
COPY --from=build /usr/src/app/.next ./.next
COPY --from=build /usr/src/app/public ./public
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

# Expose port 3000 for the HTTP server
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
