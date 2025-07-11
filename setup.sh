#!/bin/bash

# Setup script for Digital Ocean App Platform deployment

echo "🚀 Setting up Telethon Store for Digital Ocean App Platform"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[INFO]${NC} Checking prerequisites..."

# Check if git is configured
if ! git config --get user.name > /dev/null; then
    echo -e "${RED}[ERROR]${NC} Git user.name not configured. Please run:"
    echo "git config --global user.name 'Your Name'"
    exit 1
fi

if ! git config --get user.email > /dev/null; then
    echo -e "${RED}[ERROR]${NC} Git user.email not configured. Please run:"
    echo "git config --global user.email 'your.email@example.com'"
    exit 1
fi

echo -e "${GREEN}[INFO]${NC} Git is configured"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${YELLOW}[INFO]${NC} Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit - Telethon Store setup"
else
    echo -e "${GREEN}[INFO]${NC} Git repository already exists"
fi

# Check if remote is configured
if ! git remote get-url origin > /dev/null 2>&1; then
    echo -e "${YELLOW}[WARNING]${NC} No git remote configured."
    echo "Please add your GitHub repository as remote:"
    echo "git remote add origin https://github.com/your-username/telethon-store-dev.git"
    echo "git branch -M main"
    echo "git push -u origin main"
else
    echo -e "${GREEN}[INFO]${NC} Git remote is configured"
fi

echo -e "${GREEN}[INFO]${NC} Checking project structure..."

# Check if required files exist
if [ ! -f ".do/app.yaml" ]; then
    echo -e "${RED}[ERROR]${NC} .do/app.yaml not found!"
    exit 1
fi

if [ ! -f "telethon-store/src/api/health/route.ts" ]; then
    echo -e "${RED}[ERROR]${NC} Backend health check not found!"
    exit 1
fi

if [ ! -f "telethon-store-storefront/src/app/health/route.ts" ]; then
    echo -e "${RED}[ERROR]${NC} Frontend health check not found!"
    exit 1
fi

echo -e "${GREEN}[INFO]${NC} All required files are present"

echo -e "${GREEN}[SUCCESS]${NC} Setup complete!"
echo ""
echo -e "${YELLOW}[NEXT STEPS]${NC}"
echo "1. Update .do/app.yaml with your GitHub username"
echo "2. Generate secure JWT and Cookie secrets"
echo "3. Push your code to GitHub"
echo "4. Create app on Digital Ocean App Platform"
echo "5. Update CORS URLs after deployment"
echo ""
echo "📖 See DEPLOYMENT.md for detailed instructions"
