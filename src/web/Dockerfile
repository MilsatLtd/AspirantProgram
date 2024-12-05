# Build stage
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package manager files and install dependencies
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN \
  if [ -f yarn.lock ]; then yarn install --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm install --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

# Copy source files
COPY . .
COPY .env .env 

# Build the static files
RUN npm run build

# Production stage
FROM node:18-alpine
WORKDIR /app

# Install a lightweight HTTP server
RUN npm install -g serve

# Copy the static export folder from the build stage
COPY --from=builder /app/out .
COPY --from=builder /app/.env .env

# Expose port 3000
EXPOSE 3000

# Use 'serve' to serve the static files
CMD ["serve", "-s", ".", "-l", "3000"]
