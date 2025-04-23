# Build stage
FROM node:23-alpine AS builder

WORKDIR /

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

COPY . .

# Install dependencies and build
RUN pnpm install
RUN pnpm build

# Production stage
FROM node:23-alpine

WORKDIR /

# Install pnpm again
RUN corepack enable && corepack prepare pnpm@latest --activate

COPY --from=builder / .

EXPOSE 3000
CMD ["pnpm", "exec", "next", "start", "-H", "0.0.0.0"]
