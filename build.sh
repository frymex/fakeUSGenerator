#!/bin/bash

# Usage: ./build.sh faker.cazqev.pro

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
  echo "❌ Please provide domain as argument (e.g. ./build.sh faker.example.com)"
  exit 1
fi

# Replace domain in template and write to actual config
echo "🔧 Configuring nginx with domain: $DOMAIN"
sed "s/{{DOMAIN_NAME}}/$DOMAIN/g" nginx/default.conf.template > nginx/default.conf

# Build and run
echo "🐳 Building Docker image..."
docker-compose build

echo "🚀 Starting containers..."
docker-compose up -d

echo "✅ Deployed at http://$DOMAIN"
