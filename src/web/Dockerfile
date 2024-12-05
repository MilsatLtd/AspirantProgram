# Build stage
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package manager files and install dependencies
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./ 
# RUN \
#   if [ -f yarn.lock ]; then yarn install --frozen-lockfile; \
#   elif [ -f package-lock.json ]; then npm ci; \
#   elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm install --frozen-lockfile; \
#   else echo "Lockfile not found." && exit 1; \
#   fi

# Copy source files and .env
COPY . . 
# COPY .env .env

# Build the Next.js application
RUN npm install
RUN npm run build

# Production stage
FROM node:18-alpine
WORKDIR /app


# Copy the built application from the builder
COPY --from=builder /app /app

# Expose port 3000
EXPOSE 3000

# Start the Next.js application
CMD ["npm", "start"]
