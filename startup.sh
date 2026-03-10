#!/bin/sh
set -eu

echo "Starting Infralith on Azure App Service..."

PORT=${PORT:-3000}
HOSTNAME=${HOSTNAME:-0.0.0.0}

if [ -f ".next/standalone/server.js" ]; then
  echo "Setting up standalone Next.js server..."
  
  mkdir -p ".next/standalone/.next"
  
  if [ -d ".next/static" ]; then
    rm -rf ".next/standalone/.next/static"
    cp -r ".next/static" ".next/standalone/.next/static"
    echo "Copied static assets"
  fi

  if [ -d "public" ]; then
    rm -rf ".next/standalone/public"
    cp -r "public" ".next/standalone/public"
    echo "Copied public assets"
  fi

  cd ".next/standalone"
  echo "Starting server on $HOSTNAME:$PORT"
  exec node server.js
fi

echo "ERROR: Standalone build not found"
exit 1
