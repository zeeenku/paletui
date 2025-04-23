# Build stage
FROM node:23-alpine AS builder

WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

COPY . .

# Install dependencies and build
RUN pnpm install
RUN pnpm build

# Production stage
FROM node:23-alpine

WORKDIR /app

# Install pnpm again
RUN corepack enable && corepack prepare pnpm@latest --activate

COPY --from=builder /app .

EXPOSE 3000
CMD ["pnpm", "start", "--", "-H", "0.0.0.0"]
