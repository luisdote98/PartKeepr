#!/bin/bash

# Script: rebuild.sh
# Description: Rebuild PartKeepr inside Docker Compose
# Author: Code Copilot

set -e  # Exit on first error
set -o pipefail

echo "🏗️  Step 1: Generating sprites..."
docker-compose exec partkeepr php app/console nfq:sprite:generate

echo "🏗️  Step 2: Generating ExtJS Entities..."
docker-compose exec partkeepr php app/console generate:extjs:entities

echo "🏗️  Step 3: Dumping Assetic assets..."
docker-compose exec partkeepr php app/console assetic:dump

echo "🚫 Step 4: Stopping Docker containers..."
docker-compose down

echo "🚀 Step 5: Starting Docker containers in background..."
docker-compose up -d

echo "✅ All tasks completed successfully!"
