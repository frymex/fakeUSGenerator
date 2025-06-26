#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # no color

# Check domain argument
if [ -z "$1" ]; then
  echo -e "${RED}❌ Usage: ./build.sh <your-domain.com>${NC}"
  exit 1
fi

DOMAIN="$1"
echo -e "${CYAN}🔧 Configuring nginx with domain: $DOMAIN${NC}"

# Check template exists
if [ ! -f nginx/default.conf.template ]; then
  echo -e "${RED}❌ Template nginx/default.conf.template not found.${NC}"
  exit 1
fi

# Generate nginx config
sed "s/{{DOMAIN_NAME}}/$DOMAIN/g" nginx/default.conf.template > nginx/default.conf
echo -e "${GREEN}✔ NGINX config generated → nginx/default.conf${NC}"

# Check for docker
if ! command -v docker &> /dev/null; then
  echo -e "${RED}❌ Docker is not installed. Please install Docker first.${NC}"
  exit 1
fi

# Check for docker-compose (or suggest alternative)
if ! command -v docker-compose &> /dev/null; then
  echo -e "${RED}❌ docker-compose not found.${NC}"
  echo -e "${CYAN}👉 Try installing it with:${NC} ${GREEN}apt install docker-compose${NC}"
  exit 1
fi

# Build and run
echo -e "${CYAN}🐳 Building Docker image...${NC}"
docker-compose build || { echo -e "${RED}❌ Build failed${NC}"; exit 1; }

echo -e "${CYAN}🚀 Starting containers...${NC}"
docker-compose up -d || { echo -e "${RED}❌ Failed to start containers${NC}"; exit 1; }

# Success
echo -e "${GREEN}✅ Deployed successfully at → http://$DOMAIN${NC}"
