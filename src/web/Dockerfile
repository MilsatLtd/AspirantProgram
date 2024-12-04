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

# Copy source files and .env
COPY . . 
COPY .env .env

# Build the Next.js application and export static files
RUN npm run build && npx next export

# Production stage
FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html

# Copy the exported app to nginx's serving directory
COPY --from=builder /app/out /usr/share/nginx/html

# Copy the .env file (optional: if needed by frontend JavaScript)
COPY --from=builder /app/.env .env

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
