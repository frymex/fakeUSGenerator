#!/bin/bash

# Check domain argument
if [ -z "$1" ]; then
  echo "Usage: ./build.sh <your-domain.com>"
  exit 1
fi

DOMAIN="$1"
echo "Configuring nginx with domain: $DOMAIN"

# Check template exists
if [ ! -f nginx/default.conf.template ]; then
  echo "ERROR: Template nginx/default.conf.template not found."
  exit 1
fi

# Generate nginx config
sed "s/{{DOMAIN_NAME}}/$DOMAIN/g" nginx/default.conf.template > nginx/default.conf
echo "✔ NGINX config generated → nginx/default.conf"

# Check for Docker
if ! command -v docker &> /dev/null; then
  echo "Docker is not installed."

  read -p "Install latest Docker now? (y/N): " install_docker
  if [[ "$install_docker" =~ ^[Yy]$ ]]; then
    curl -fsSL https://get.docker.com | sh
  else
    echo "Aborting: Docker is required."
    exit 1
  fi
fi

# Check for docker-compose
if ! command -v docker-compose &> /dev/null; then
  echo "docker-compose is not installed."

  read -p "Install docker-compose (v2 plugin)? (y/N): " install_compose
  if [[ "$install_compose" =~ ^[Yy]$ ]]; then
    DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)"
    mkdir -p ~/.docker/cli-plugins
    curl -SL $DOCKER_COMPOSE_URL -o ~/.docker/cli-plugins/docker-compose
    chmod +x ~/.docker/cli-plugins/docker-compose
    echo 'export PATH="$HOME/.docker/cli-plugins:$PATH"' >> ~/.bashrc
    export PATH="$HOME/.docker/cli-plugins:$PATH"
  else
    echo "Aborting: docker-compose is required."
    exit 1
  fi
fi

# Build and run
echo "Building Docker image..."
docker-compose build || { echo "❌ Build failed"; exit 1; }

echo "Starting containers..."
docker-compose up -d || { echo "❌ Failed to start containers"; exit 1; }

echo "✅ Deployed successfully at → http://$DOMAIN"
