# 🚀 START HERE - Quick Setup for Windows

Welcome! Let's get your 3D bookshelf running with your ebook collection.

## ⚡ Quick Overview

This application creates a beautiful 3D bookshelf web interface for your ebooks using your Calibre library.

## 📋 What You Need to Do (30 minutes total)

### ✅ Step 1: Install Prerequisites (20 minutes)

Install these three programs in order:

1. **Ruby+Devkit 3.3.x (x64)**
   - Download: https://rubyinstaller.org/downloads/
   - ⚠️ During install: Select option **3** when prompted
   - ⚠️ Check "Add Ruby executables to PATH"

2. **ImageMagick (DLL version)**
   - Download: https://imagemagick.org/script/download.php#windows
   - Look for: `ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe`
   - ⚠️ Check "Install legacy utilities"
   - ⚠️ Check "Add to system path"

3. **Calibre** (if you don't have it)
   - Download: https://calibre-ebook.com/download_windows
   - Note the library location it creates

**After installing, restart PowerShell!**

### ✅ Step 2: Verify Installation (2 minutes)

Open PowerShell in this folder and run:

```powershell
.\check_prerequisites.ps1
```

All items should show ✓ (green checkmarks).

### ✅ Step 3: Install App Dependencies (3 minutes)

In PowerShell:

```powershell
gem install bundler
bundle install
```

### ✅ Step 4: Add Your Books to Calibre (5 minutes)

1. Open Calibre
2. Drag and drop your ebook files (EPUB, PDF, MOBI, etc.)
3. Remember the library path (shown in Calibre preferences)

### ✅ Step 5: Run the Bookshelf!

**Easy way:**
```powershell
.\run_bookshelf.ps1
```

**Direct way:**
```powershell
ruby app.rb "C:\Users\YourName\Documents\Calibre Library"
```
(Replace with your actual Calibre library path)

### ✅ Step 6: Open in Browser

Go to: **http://localhost:4567**

🎉 **You should see your 3D bookshelf!**

## 📚 Detailed Guides

- **WINDOWS_SETUP.md** - Complete Windows installation guide
- **SETUP_GUIDE.md** - Comprehensive setup documentation
- **QUICK_START.md** - Quick reference guide

## 🆘 Having Issues?

1. Run `.\check_prerequisites.ps1` to check what's missing
2. See **WINDOWS_SETUP.md** for troubleshooting
3. Make sure you restarted PowerShell after installing software

## 💡 Tips

- Books with good covers look best
- Add series information in Calibre for better organization
- Add descriptions - they appear on the back of books
- EPUB format is preferred

---

**Need help?** See WINDOWS_SETUP.md for detailed troubleshooting and step-by-step instructions.

