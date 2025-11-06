# Google Drive Setup for Rclone
# This script will guide you through setting up Google Drive

Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Google Drive Setup for Bookshelf" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

# Check if config exists
$configPath = "$env:USERPROFILE\.config\rclone\rclone.conf"
if (Test-Path $configPath) {
    Write-Host "✓ Rclone config found at: $configPath" -ForegroundColor Green
    Write-Host ""
    Write-Host "Existing remotes:" -ForegroundColor Yellow
    .\rclone.exe listremotes
    Write-Host ""
    $overwrite = Read-Host "Do you want to add a new remote? (y/n)"
    if ($overwrite -ne 'y') {
        Write-Host "Setup canceled." -ForegroundColor Yellow
        exit 0
    }
}

Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 1: Name your remote" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "This is the name you'll use to refer to your Google Drive." -ForegroundColor Gray
Write-Host "Recommended: bookshelf-drive" -ForegroundColor Yellow
Write-Host ""
$remoteName = Read-Host "Enter remote name (or press Enter for 'bookshelf-drive')"
if ([string]::IsNullOrWhiteSpace($remoteName)) {
    $remoteName = "bookshelf-drive"
}
Write-Host "✓ Using remote name: $remoteName" -ForegroundColor Green
Write-Host ""

Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 2: Opening browser for Google authorization..." -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠ IMPORTANT:" -ForegroundColor Yellow
Write-Host "  1. A browser window will open" -ForegroundColor White
Write-Host "  2. Sign in to your Google account" -ForegroundColor White
Write-Host "  3. Click 'Allow' to grant access" -ForegroundColor White
Write-Host "  4. Wait for the success message" -ForegroundColor White
Write-Host ""
Read-Host "Press Enter when ready to continue"

# Run rclone config with answers piped
$answers = @"
n
$remoteName
drive


1



Y
n
Y
q
"@

$answers | .\rclone.exe config

Write-Host ""
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 3: Testing connection..." -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

$testResult = .\rclone.exe lsd "${remoteName}:" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Successfully connected to Google Drive!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your Google Drive folders:" -ForegroundColor Yellow
    Write-Host $testResult
    Write-Host ""
    
    Write-Host "=" * 70 -ForegroundColor Cyan
    Write-Host "Step 4: Create Bookshelf folders" -ForegroundColor Cyan
    Write-Host "=" * 70 -ForegroundColor Cyan
    Write-Host ""
    
    $createFolders = Read-Host "Create 'Bookshelf/books' and 'Bookshelf/covers' folders? (y/n)"
    if ($createFolders -eq 'y') {
        Write-Host "Creating folders..." -ForegroundColor Yellow
        .\rclone.exe mkdir "${remoteName}:Bookshelf"
        .\rclone.exe mkdir "${remoteName}:Bookshelf/books"
        .\rclone.exe mkdir "${remoteName}:Bookshelf/covers"
        Write-Host "✓ Folders created!" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "=" * 70 -ForegroundColor Green
    Write-Host "🎉 Setup Complete!" -ForegroundColor Green
    Write-Host "=" * 70 -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Edit sync-to-drive.ps1 and set:" -ForegroundColor White
    Write-Host "   RcloneRemote = $remoteName" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "2. Run the sync script:" -ForegroundColor White
    Write-Host "   .\sync-to-drive.ps1" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "❌ Failed to connect to Google Drive" -ForegroundColor Red
    Write-Host ""
    Write-Host "Error:" -ForegroundColor Yellow
    Write-Host $testResult
    Write-Host ""
    Write-Host "Please try running: .\rclone.exe config" -ForegroundColor Yellow
    Write-Host "And follow the interactive prompts manually." -ForegroundColor Gray
}

