#!/bin/bash

# Azure App Service Deployment Script for Infralith

echo "=== Infralith Azure Deployment Setup ==="

# Set Node version
export NODE_ENV=production
export NODE_OPTIONS="--max-old-space-size=2048"

# Install dependencies
echo "Installing dependencies..."
npm ci --omit=dev

# Build Next.js app
echo "Building Next.js application..."
npm run build

# Ensure .next/standalone exists
if [ ! -d ".next/standalone" ]; then
  echo "ERROR: Standalone build not found!"
  exit 1
fi

# Copy static assets to standalone
echo "Copying static assets..."
mkdir -p ".next/standalone/.next"
cp -r ".next/static" ".next/standalone/.next/static" 2>/dev/null || true
cp -r "public" ".next/standalone/public" 2>/dev/null || true

# Copy config files
cp web.config ".next/standalone/" 2>/dev/null || true

echo "=== Build Complete ==="
echo "App is ready to start with: node .next/standalone/server.js"
