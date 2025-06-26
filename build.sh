#!/bin/bash

# --- FUNCTIONS ---

# Install Docker CE (official way)
install_docker() {
  echo "Installing Docker..."
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg lsb-release

  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# --- MAIN ---

# 1. Check domain argument
if [ -z "$1" ]; then
  echo "Usage: ./build.sh <your-domain.com>"
  exit 1
fi

DOMAIN="$1"
echo "🔧 Configuring for domain: $DOMAIN"

# 2. Check template exists
if [ ! -f nginx/default.conf.template ]; then
  echo "ERROR: nginx/default.conf.template not found."
  exit 1
fi

# 3. Generate NGINX config
sed "s/{{DOMAIN_NAME}}/$DOMAIN/g" nginx/default.conf.template > nginx/default.conf
echo "✔ NGINX config generated at nginx/default.conf"

# 4. Check Docker
if ! command -v docker &> /dev/null; then
  echo "Docker is not installed."
  read -p "Install Docker now using the official Docker installer? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    install_docker
  else
    echo "Aborting: Docker is required."
    exit 1
  fi
fi

# 5. Check Docker Compose plugin
if ! docker compose version &> /dev/null; then
  echo "Docker Compose plugin not found (docker compose)."
  echo "You may need to log out and log in again, or add ~/.docker/cli-plugins to PATH."
  exit 1
fi

# 6. Build and run
echo "🐳 Building Docker image..."
docker compose build || { echo "❌ Build failed"; exit 1; }

echo "🚀 Starting containers..."
docker compose up -d || { echo "❌ Failed to start containers"; exit 1; }

echo "✅ Deployed successfully at: http://$DOMAIN"
