# Windows Setup Instructions

This guide will help you get the 3D Bookshelf running on Windows with your own ebook collection.

## 🎯 Goal

By the end of this guide, you'll have a beautiful 3D bookshelf web interface showing your personal ebook collection!

## 📦 What You're Installing

1. **Ruby** - The programming language this app is written in
2. **ImageMagick** - Processes book cover images
3. **Calibre** - Free software to organize your ebooks (if you don't already have it)
4. **Bundler & Ruby Gems** - Dependencies for the app

## 🚀 Step-by-Step Installation

### Step 1: Install Ruby (10 minutes)

1. Go to https://rubyinstaller.org/downloads/
2. Download **Ruby+Devkit 3.3.x (x64)** - the big red download button
   - Example: `rubyinstaller-devkit-3.3.6-1-x64.exe`
3. Run the installer:
   - ✅ Accept the license
   - ✅ Keep default installation path
   - ✅ Check "Add Ruby executables to your system PATH"
   - Click Install
4. At the end, a command prompt will open asking what to install:
   - Type **3** and press Enter
   - Wait for installation to complete (may take a few minutes)
   - Press Enter again to close the window

### Step 2: Install ImageMagick (5 minutes)

1. Go to https://imagemagick.org/script/download.php#windows
2. Scroll down to find the Windows Binary Release
3. Download **ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe**
   - Look for "Win64 dynamic at 16 bits-per-pixel component" 
4. Run the installer:
   - ✅ Accept the license
   - ✅ Keep default installation path
   - ✅ **IMPORTANT:** Check "Install legacy utilities (e.g. convert)"
   - ✅ **IMPORTANT:** Check "Add application directory to your system path"
   - Click Install

### Step 3: Install Calibre (5 minutes)

**If you already have Calibre, skip to Step 4!**

1. Go to https://calibre-ebook.com/download_windows
2. Download the 64-bit installer
3. Run the installer and follow the prompts
4. Launch Calibre
5. When asked, choose a location for your library:
   - Example: `C:\Users\YourName\Documents\Calibre Library`
   - **Remember this path!**

### Step 4: Verify Installation

1. **Close and reopen PowerShell** (important!)
2. Right-click on the PowerShell icon and "Run as Administrator"
3. Navigate to the bookshelf folder:
   ```powershell
   cd O:\CURSOR2\BOOKSHELF
   ```
4. Run the prerequisites check:
   ```powershell
   .\check_prerequisites.ps1
   ```

If you see any ✗ marks, install the missing software and run the check again.

### Step 5: Install Ruby Dependencies

In PowerShell (in the bookshelf directory):

```powershell
gem install bundler
bundle install
```

This will install all the required Ruby libraries. It may take a few minutes.

## 📚 Adding Your Books

### Option 1: You Already Have a Calibre Library

If you already have books in Calibre, just note the path to your library:

1. Open Calibre
2. Look at the window title or go to Preferences → Welcome wizard
3. Note the full path (e.g., `C:\Users\YourName\Documents\Calibre Library`)

### Option 2: Import Your Books into Calibre

1. Open Calibre
2. **Drag and drop** your ebook files (EPUB, MOBI, PDF, etc.) into the Calibre window
   - Or click "Add books" button and browse to your files
3. Calibre will automatically organize them
4. Optional but recommended: Right-click each book → "Edit metadata" → "Download metadata" to get covers and descriptions

### Option 3: Import from a Folder

1. In Calibre, click "Add books" → "Add books from a single directory"
2. Select the folder containing all your ebooks
3. Calibre will import everything at once

**Pro Tips:**
- Books with good cover images look much better in the 3D view
- Fill in the "Series" field for books in a series - the shelf organizes by series
- Add descriptions - they show up when you flip books over
- EPUB format is preferred for downloads

## 🎨 Running Your Bookshelf

### Method 1: Using the Launcher Script (Easiest)

In PowerShell:

```powershell
cd O:\CURSOR2\BOOKSHELF
.\run_bookshelf.ps1
```

It will ask for your Calibre library path, then start the server.

### Method 2: Direct Command

```powershell
cd O:\CURSOR2\BOOKSHELF
ruby app.rb "C:\Users\YourName\Documents\Calibre Library"
```

Replace with your actual Calibre library path!

### Open in Browser

Once the server starts, open your web browser and go to:

```
http://localhost:4567
```

You should see your 3D bookshelf! 🎉

## 🎮 Using the Bookshelf

- **Browse:** Scroll through your collection
- **Flip books:** Click on a book to see the back cover with description
- **Search by author:** http://localhost:4567/author/AuthorName
- **Search by series:** http://localhost:4567/series/SeriesName
- **Download:** Click the download link on the back of any book

## ❌ Troubleshooting

### "The term 'ruby' is not recognized"

**Solution:** 
- Close and reopen PowerShell (or Command Prompt)
- If still not working, restart your computer
- Ruby needs to be added to PATH during installation

### "The term 'bundle' is not recognized"

**Solution:** 
```powershell
gem install bundler
```

### "Failed to build gem native extension" or rmagick errors

**Solutions:**
1. Make sure you installed **ImageMagick DLL version** (not static)
2. Make sure you checked "Install legacy utilities"
3. Restart your computer
4. Try reinstalling ImageMagick
5. Make sure you installed **Ruby+Devkit** (not just Ruby)

### "Please specify a Calibre library directory"

**Solution:** You must pass your library path:
```powershell
ruby app.rb "C:\Path\To\Calibre Library"
```

### No books are showing up

**Check:**
1. Your Calibre library path is correct
2. The folder contains a `metadata.db` file
3. You've actually added books to Calibre
4. Try adding books with covers

### Books have no covers

**Solution:** 
- In Calibre, right-click the book → Edit metadata → Download cover
- Or manually add cover images in Calibre

### Server won't start / Port already in use

**Solution:**
- Something else is using port 4567
- Close any other instances of the bookshelf app
- Or edit `app.rb` and change the port number

## 📝 Helpful Files in This Project

- **SETUP_GUIDE.md** - Comprehensive detailed guide
- **QUICK_START.md** - Quick reference guide
- **check_prerequisites.ps1** - Check if everything is installed
- **run_bookshelf.ps1** - Easy launcher script
- **README.md** - Original project documentation

## 🔄 Every Time You Want to Use the Bookshelf

1. Open PowerShell
2. Navigate to: `cd O:\CURSOR2\BOOKSHELF`
3. Run: `ruby app.rb "C:\Your\Calibre\Library\Path"`
4. Open browser to: http://localhost:4567
5. Press Ctrl+C in PowerShell to stop the server when done

## 💡 Advanced: Page Count Display

Want books to have realistic thickness based on page count?

1. In Calibre: Preferences → Plugins → Get new plugins
2. Search for "Count Pages" and install it
3. In plugin settings, create a custom column named `pagecount`
4. Select books → Right-click → Count Pages
5. The bookshelf will automatically use page count for book thickness!

## 🆘 Still Having Issues?

1. Run `.\check_prerequisites.ps1` to verify everything is installed
2. Check that you're using the correct Calibre library path
3. Make sure metadata.db exists in your library folder
4. Try restarting your computer after installing prerequisites
5. Check the terminal output for specific error messages

## 🎊 Success!

Once you see your bookshelf, you can:
- Keep adding books to Calibre (they'll appear on the shelf)
- Edit metadata in Calibre to improve the display
- Share the local URL with others on your network
- Enjoy browsing your collection in beautiful 3D!

Happy reading! 📚✨

