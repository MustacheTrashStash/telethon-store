# Setup script for Digital Ocean App Platform deployment (PowerShell)

Write-Host "🚀 Setting up Telethon Store for Digital Ocean App Platform" -ForegroundColor Green

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

Write-Info "Checking prerequisites..."

# Check if git is configured
try {
    $gitUserName = git config --get user.name
    $gitUserEmail = git config --get user.email
    
    if ([string]::IsNullOrEmpty($gitUserName)) {
        Write-Error "Git user.name not configured. Please run:"
        Write-Host "git config --global user.name 'Your Name'"
        exit 1
    }
    
    if ([string]::IsNullOrEmpty($gitUserEmail)) {
        Write-Error "Git user.email not configured. Please run:"
        Write-Host "git config --global user.email 'your.email@example.com'"
        exit 1
    }
    
    Write-Info "Git is configured"
} catch {
    Write-Error "Git is not installed or not in PATH"
    exit 1
}

# Check if we're in a git repository
try {
    git rev-parse --git-dir | Out-Null
    Write-Info "Git repository already exists"
} catch {
    Write-Warning "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit - Telethon Store setup"
}

# Check if remote is configured
try {
    git remote get-url origin | Out-Null
    Write-Info "Git remote is configured"
} catch {
    Write-Warning "No git remote configured."
    Write-Host "Please add your GitHub repository as remote:"
    Write-Host "git remote add origin https://github.com/your-username/telethon-store-dev.git"
    Write-Host "git branch -M main"
    Write-Host "git push -u origin main"
}

Write-Info "Checking project structure..."

# Check if required files exist
$requiredFiles = @(
    ".do/app.yaml",
    "telethon-store/src/api/health/route.ts",
    "telethon-store-storefront/src/app/health/route.ts"
)

foreach ($file in $requiredFiles) {
    if (!(Test-Path $file)) {
        Write-Error "$file not found!"
        exit 1
    }
}

Write-Info "All required files are present"

Write-Host ""
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Warning "NEXT STEPS:"
Write-Host "1. Update .do/app.yaml with your GitHub username"
Write-Host "2. Generate secure JWT and Cookie secrets"
Write-Host "3. Push your code to GitHub"
Write-Host "4. Create app on Digital Ocean App Platform"
Write-Host "5. Update CORS URLs after deployment"
Write-Host ""
Write-Host "📖 See DEPLOYMENT.md for detailed instructions"
