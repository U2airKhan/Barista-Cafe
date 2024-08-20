# Stage 1: Get code from GitHub repository
FROM alpine:latest AS builder

# Install git and other necessary packages
RUN apk add --no-cache git

# Clone the GitHub repository
RUN git clone https://github.com/U2airKhan/Barista-Cafe.git /app

# Stage 2: Setup Apache server
FROM php:apache

# Install necessary packages (e.g., git for potential future needs)
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy the code from the builder stage to Apache's web directory
COPY --from=builder /app /var/www/html

# Adjust permissions (if needed)
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80
