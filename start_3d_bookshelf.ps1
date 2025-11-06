# 3D Bookshelf Startup Script

Write-Host "=== Starting 3D Bookshelf ===" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
$nodeVersion = node --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Node.js not found!" -ForegroundColor Red
    Write-Host "Please install Node.js from https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Node.js $nodeVersion found" -ForegroundColor Green

# Check if dependencies are installed
if (-not (Test-Path "node_modules")) {
    Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
    npm install
}

Write-Host ""
Write-Host "Starting servers..." -ForegroundColor Cyan
Write-Host ""

# Start Ruby backend in background
Write-Host "Starting Ruby backend (port 4567)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD'; .\run_my_bookshelf.ps1"

# Wait a bit for Ruby server to start
Start-Sleep -Seconds 3

# Start React frontend
Write-Host "Starting React frontend (port 3000)..." -ForegroundColor Yellow
Write-Host ""
Write-Host "=== 3D Bookshelf Ready! ===" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Open your browser to:" -ForegroundColor Cyan
Write-Host "   http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "🎮 Controls:" -ForegroundColor Cyan
Write-Host "   🖱️  Drag to rotate" -ForegroundColor White
Write-Host "   🔍 Scroll to zoom" -ForegroundColor White
Write-Host "   👆 Click books to view" -ForegroundColor White
Write-Host ""
Write-Host "Press Ctrl+C to stop the frontend server" -ForegroundColor Yellow
Write-Host "Close the other window to stop the backend" -ForegroundColor Yellow
Write-Host ""

npm run dev

