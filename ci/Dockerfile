# Use the official Playwright image (includes all browsers and dependencies)
FROM mcr.microsoft.com/playwright:v1.48.2-jammy
ARG DOCKER_USER

RUN apt-get update && apt-get install -y \
    bash \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/app

# Ensure proper permissions for the application directory
RUN mkdir -p /usr/app/traces && chmod -R 777 /usr/app

# Install dependencies only (no dev dependencies for smaller image)
COPY ../package.json ../package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Copy application source code
COPY . .

COPY ci/docker-entrypoint.sh /usr/local/bin
COPY ci/startup.sh /

# Add non-root user
RUN useradd -ms /bin/bash -U -G users pwuser && \
    chown -R pwuser /usr/app

USER pwuser

ENTRYPOINT [ "/startup.sh" ]

EXPOSE 3002