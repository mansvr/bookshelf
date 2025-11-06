# Quick Start Guide

## TL;DR - What You Need

1. **Ruby** - Programming language to run the app
2. **ImageMagick** - Image processing for book covers
3. **Calibre** - Manages your ebook collection
4. **Your ebooks** - In any format (EPUB, PDF, MOBI, etc.)

## One-Time Setup (15-30 minutes)

### Install Software

| Software | Download Link | Notes |
|----------|---------------|-------|
| **Ruby+Devkit 3.3.x** | https://rubyinstaller.org/downloads/ | Choose x64 version with Devkit, select option 3 during setup |
| **ImageMagick (DLL)** | https://imagemagick.org/script/download.php#windows | Must be the DLL version, enable legacy utilities |
| **Calibre** | https://calibre-ebook.com/download_windows | Free ebook manager |

**After installing, restart PowerShell (or your computer if issues persist)**

### Set Up Your Library

1. **Open Calibre**
2. **Drag and drop your ebook files** into Calibre window
3. **Note the library path** (shown in Calibre window title or Preferences)
   - Example: `C:\Users\YourName\Documents\Calibre Library`

### Install App Dependencies

Open PowerShell in the bookshelf folder and run:

```powershell
cd O:\CURSOR2\BOOKSHELF
bundle install
```

## Running the App

Every time you want to use your bookshelf:

```powershell
cd O:\CURSOR2\BOOKSHELF
ruby app.rb "C:\Users\YourName\Documents\Calibre Library"
```

**Replace the path** with your actual Calibre library path!

Then open in your browser: **http://localhost:4567**

## Common Issues

**"ruby is not recognized"**
→ Restart PowerShell after installing Ruby

**"bundle is not recognized"**  
→ Run: `gem install bundler`

**"rmagick" gem fails to install**
→ Make sure ImageMagick DLL version is installed with legacy utilities

**No books showing**
→ Check the Calibre library path is correct (should contain metadata.db file)

**"Please specify a Calibre library directory"**
→ You must pass the library path as an argument (see Running the App above)

## What's Next?

- Add more books to Calibre
- Edit metadata and covers in Calibre for better display
- Browse your collection at http://localhost:4567
- Search by author: http://localhost:4567/author/AuthorName
- Search by series: http://localhost:4567/series/SeriesName

---

For detailed instructions, see **SETUP_GUIDE.md**

