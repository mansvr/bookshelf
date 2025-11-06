# [BOOKS] Sync Calibre Library to Google Drive
# This script:
# 1. Generates metadata from Calibre
# 2. Optimizes and uploads covers to Google Drive
# 3. Uploads book files to Google Drive
# 4. Gets file IDs from Drive
# 5. Updates metadata.json with Drive URLs
# 6. Prepares for Vercel deployment

param(
    [string]$CalibrePath = "D:\BIBLIO_\calibre",
    [string]$RcloneRemote = "bookshel-drive",
    [string]$DrivePath = "Bookshelf",
    [switch]$DryRun
)

Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "[BOOKS] Syncing Bookshelf to Google Drive" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

# Check prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor Yellow
Write-Host ""

# Check Ruby
if (-not (Get-Command ruby -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Ruby not found!" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Ruby found" -ForegroundColor Green

# Check Rclone (local or system)
$rclone = ".\rclone.exe"
if (-not (Test-Path $rclone)) {
    $rclone = "rclone"
    if (-not (Get-Command rclone -ErrorAction SilentlyContinue)) {
        Write-Host "[ERROR] Rclone not found!" -ForegroundColor Red
        Write-Host "Install: choco install rclone" -ForegroundColor Yellow
        exit 1
    }
}
Write-Host "[OK] Rclone found" -ForegroundColor Green

# Check ImageMagick (for cover optimization)
$hasImageMagick = Get-Command magick -ErrorAction SilentlyContinue
if ($hasImageMagick) {
    Write-Host "[OK] ImageMagick found (covers will be optimized)" -ForegroundColor Green
} else {
    Write-Host "[WARN] ImageMagick not found (covers will be uploaded as-is)" -ForegroundColor Yellow
}

# Check Calibre path
if (-not (Test-Path $CalibrePath)) {
    Write-Host "[ERROR] Calibre library not found at: $CalibrePath" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Calibre library found" -ForegroundColor Green

# Check Rclone remote
$remoteTest = & $rclone lsd "${RcloneRemote}:" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Rclone remote '$RcloneRemote' not configured!" -ForegroundColor Red
    Write-Host "Run: .\rclone.exe config" -ForegroundColor Yellow
    exit 1
}
Write-Host "[OK] Rclone remote configured" -ForegroundColor Green
Write-Host ""

# Step 1: Generate metadata from Calibre
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 1: Generating metadata from Calibre" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

ruby generate-metadata.rb "$CalibrePath"
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to generate metadata!" -ForegroundColor Red
    exit 1
}

# Load generated metadata
$metadata = Get-Content "public/books.json" | ConvertFrom-Json
$bookCount = $metadata.Count
Write-Host "[OK] Loaded $bookCount books from metadata" -ForegroundColor Green
Write-Host ""

# Step 2: Prepare temp directories
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 2: Preparing files for upload" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

$tempDir = "temp_sync"
$coversDir = "$tempDir/covers"
$booksDir = "$tempDir/books"

if (Test-Path $tempDir) {
    Remove-Item -Recurse -Force $tempDir
}
New-Item -ItemType Directory -Force -Path $coversDir | Out-Null
New-Item -ItemType Directory -Force -Path $booksDir | Out-Null

Write-Host "Created temp directories" -ForegroundColor Green
Write-Host ""

# Step 3: Optimize and copy covers
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 3: Optimizing cover images" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

$processed = 0
foreach ($book in $metadata) {
    $processed++
    $coverSource = $book._local_cover
    $coverDest = "$coversDir/$($book.id).jpg"
    
    Write-Host "[$processed/$bookCount] $($book.title)" -ForegroundColor White
    
    if (Test-Path $coverSource) {
        if ($hasImageMagick) {
            # Optimize with ImageMagick
            & magick $coverSource -resize 400x -quality 85 $coverDest 2>$null
            if ($LASTEXITCODE -eq 0) {
                $originalSize = (Get-Item $coverSource).Length / 1KB
                $optimizedSize = (Get-Item $coverDest).Length / 1KB
                Write-Host "  [OK] Optimized: $([math]::Round($originalSize))KB â†’ $([math]::Round($optimizedSize))KB" -ForegroundColor Green
            } else {
                Copy-Item $coverSource $coverDest
                Write-Host "  [WARN] Copied without optimization" -ForegroundColor Yellow
            }
        } else {
            Copy-Item $coverSource $coverDest
            Write-Host "  [OK] Copied" -ForegroundColor Green
        }
    } else {
        Write-Host "  [WARN] Cover not found" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[OK] All covers prepared!" -ForegroundColor Green
Write-Host ""

# Step 4: Copy book files
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 4: Preparing book files" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

$processed = 0
foreach ($book in $metadata) {
    $processed++
    $bookSource = $book._local_file
    
    if (Test-Path $bookSource) {
        $ext = [System.IO.Path]::GetExtension($bookSource)
        $bookDest = "$booksDir/$($book.id)$ext"
        
        Write-Host "[$processed/$bookCount] $($book.title)" -ForegroundColor White
        Copy-Item $bookSource $bookDest
        
        $size = (Get-Item $bookDest).Length / 1MB
        $sizeRounded = [math]::Round($size, 1)
        Write-Host "  [OK] Copied ($sizeRounded MB)" -ForegroundColor Green
    } else {
        Write-Host "[$processed/$bookCount] $($book.title)" -ForegroundColor White
        Write-Host "  [WARN] File not found: $bookSource" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[OK] All books prepared!" -ForegroundColor Green
Write-Host ""

# Step 5: Upload to Google Drive
if ($DryRun) {
    Write-Host "=" * 70 -ForegroundColor Yellow
    Write-Host "ðŸ” DRY RUN MODE - Not uploading" -ForegroundColor Yellow
    Write-Host "=" * 70 -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Would upload:" -ForegroundColor Yellow
    Write-Host "  Covers: $coversDir â†’ $RcloneRemote`:$DrivePath/covers/" -ForegroundColor White
    Write-Host "  Books:  $booksDir â†’ $RcloneRemote`:$DrivePath/books/" -ForegroundColor White
} else {
    Write-Host "=" * 70 -ForegroundColor Cyan
    Write-Host "Step 5: Uploading to Google Drive" -ForegroundColor Cyan
    Write-Host "=" * 70 -ForegroundColor Cyan
    Write-Host ""
    
    # Upload covers
    Write-Host "Uploading covers..." -ForegroundColor Yellow
    & $rclone sync $coversDir "${RcloneRemote}:${DrivePath}/covers/" --progress --transfers 8
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Covers uploaded!" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Failed to upload covers!" -ForegroundColor Red
        exit 1
    }
    Write-Host ""
    
    # Upload books
    Write-Host "Uploading books..." -ForegroundColor Yellow
    & $rclone sync $booksDir "${RcloneRemote}:${DrivePath}/books/" --progress --transfers 4
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Books uploaded!" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Failed to upload books!" -ForegroundColor Red
        exit 1
    }
    Write-Host ""
}

# Step 6: Get file IDs and update metadata
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "Step 6: Getting Drive file IDs" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

Write-Host "Fetching file listings from Drive..." -ForegroundColor Yellow

# Get cover file IDs
$coversList = & $rclone lsjson "${RcloneRemote}:${DrivePath}/covers/" --files-only
$coversMap = @{}
if ($coversList) {
    ($coversList | ConvertFrom-Json) | ForEach-Object {
        $id = $_.Name -replace '\..+$', ''  # Remove extension
        $coversMap[$id] = $_.ID
    }
}

# Get book file IDs
$booksList = & $rclone lsjson "${RcloneRemote}:${DrivePath}/books/" --files-only
$booksMap = @{}
if ($booksList) {
    ($booksList | ConvertFrom-Json) | ForEach-Object {
        $id = $_.Name -replace '\..+$', ''  # Remove extension
        $booksMap[$id] = $_.ID
    }
}

Write-Host "[OK] Found $($coversMap.Count) covers and $($booksMap.Count) books on Drive" -ForegroundColor Green
Write-Host ""

# Update metadata with real Drive URLs
Write-Host "Updating metadata with Drive URLs..." -ForegroundColor Yellow
foreach ($book in $metadata) {
    $bookId = $book.id.ToString()
    
    # Update cover URL
    if ($coversMap.ContainsKey($bookId)) {
        $coverId = $coversMap[$bookId]
        $book.cover_url = "https://drive.google.com/thumbnail?id=$coverId`&sz=w400"
    }
    
    # Update book URL  
    if ($booksMap.ContainsKey($bookId)) {
        $bookFileId = $booksMap[$bookId]
        $book.book_url = "https://drive.google.com/uc?export=download`&id=$bookFileId"
    }
    
    # Remove local paths (not needed for web)
    $book.PSObject.Properties.Remove('_local_cover')
    $book.PSObject.Properties.Remove('_local_file')
}

# Save updated metadata
$metadata | ConvertTo-Json -Depth 10 | Set-Content "public/books.json"
Write-Host "[OK] Metadata updated with Drive URLs!" -ForegroundColor Green
Write-Host ""

# Step 7: Cleanup
Write-Host "Cleaning up temp files..." -ForegroundColor Yellow
Remove-Item -Recurse -Force $tempDir
Write-Host "[OK] Cleanup complete!" -ForegroundColor Green
Write-Host ""

# Final summary
Write-Host "=" * 70 -ForegroundColor Green
Write-Host "[SUCCESS] Sync Complete!" -ForegroundColor Green
Write-Host "=" * 70 -ForegroundColor Green
Write-Host ""
Write-Host "[BOOKS] Summary:" -ForegroundColor Cyan
Write-Host "  Books synced: $bookCount" -ForegroundColor White
Write-Host "  Covers uploaded: $($coversMap.Count)" -ForegroundColor White
Write-Host "  Books uploaded: $($booksMap.Count)" -ForegroundColor White
Write-Host "  Metadata: public/books.json" -ForegroundColor White
Write-Host ""
Write-Host "[NEXT] Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Review: public/books.json" -ForegroundColor White
Write-Host "  2. Commit: git add public/books.json" -ForegroundColor White
Write-Host "  3. Push: git push" -ForegroundColor White
Write-Host "  4. Vercel will auto-deploy!" -ForegroundColor White
Write-Host ""
Write-Host "[SUCCESS] Your bookshelf is ready for the web!" -ForegroundColor Green


