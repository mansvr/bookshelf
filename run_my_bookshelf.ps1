# 3D Bookshelf Launcher - Configured for your system

Write-Host ""
Write-Host "=== Starting 3D Bookshelf ===" -ForegroundColor Cyan
Write-Host ""

# Your paths
$rubyPath = "C:\Ruby33-x64\bin"
$imageMagickPath = "C:\Program Files\ImageMagick-7.1.2-Q16"
$calibreLibrary = "D:\BIBLIO_\calibre"

# Add Ruby and ImageMagick to PATH
$env:PATH = "$rubyPath;$imageMagickPath;$env:PATH"

Write-Host "Checking prerequisites..." -ForegroundColor Yellow

if (Test-Path (Join-Path $rubyPath "ruby.exe")) {
    Write-Host "  OK Ruby found" -ForegroundColor Green
} else {
    Write-Host "  ERROR Ruby not found" -ForegroundColor Red
    exit 1
}

if (Test-Path (Join-Path $calibreLibrary "metadata.db")) {
    Write-Host "  OK Calibre library found" -ForegroundColor Green
} else {
    Write-Host "  ERROR Calibre library not found" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Starting server..." -ForegroundColor Green
Write-Host "Calibre Library: $calibreLibrary" -ForegroundColor Gray
Write-Host ""
Write-Host "Once started, open your browser to:" -ForegroundColor Green
Write-Host "  http://localhost:4567" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Gray
Write-Host ("-" * 60) -ForegroundColor Gray
Write-Host ""

Set-Location "O:\CURSOR2\BOOKSHELF"

& bundle exec ruby app.rb $calibreLibrary
