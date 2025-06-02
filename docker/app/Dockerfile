# Use the official Playwright image (includes all browsers and dependencies)
FROM mcr.microsoft.com/playwright:v1.48.2-jammy
ARG DOCKER_USER

RUN apt-get update && apt-get install -y \
    bash \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/app

# Install dependencies only (no dev dependencies for smaller image)
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Add non-root user
RUN useradd -ms /bin/bash -U -G users ${DOCKER_USER} && \
    chown -R ${DOCKER_USER} /usr/app && \
    chown -R ${DOCKER_USER} /home/${DOCKER_USER} && \
    ln -s /home/${DOCKER_USER} /home/user

COPY ./docker/app/docker-entrypoint.sh /usr/local/bin
COPY ./docker/app/startup.sh /

USER ${DOCKER_USER}

ENTRYPOINT [ "/startup.sh" ]

EXPOSE 3002