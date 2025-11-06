# 3D Bookshelf Setup Guide

## What This Application Does

This is a beautiful 3D animated bookshelf web application that:
- Reads your ebook collection from a Calibre library
- Displays books with realistic 3D effects based on actual cover art
- Book height is determined by cover aspect ratio
- Book thickness is based on page count (if available)
- Shows book descriptions on the back cover
- Allows browsing by author and series
- Provides download links for your ebooks

## Prerequisites Installation

### 1. Install Ruby (Required)

Since you're on Windows, follow these steps:

1. **Download RubyInstaller:**
   - Go to: https://rubyinstaller.org/downloads/
   - Download **Ruby+Devkit 3.3.x (x64)** - the latest stable version
   - File will be named something like `rubyinstaller-devkit-3.3.x-x-x64.exe`

2. **Run the installer:**
   - Run the downloaded installer
   - ✅ Check "Add Ruby executables to PATH"
   - ✅ Use default installation path (C:\Ruby33-x64)
   - Complete the installation

3. **Install MSYS2 Devkit:**
   - At the end of Ruby installation, a command window will open
   - Select option **3** (MSYS2 and MINGW development toolchain)
   - Press Enter and wait for installation to complete
   - Close the window when done

4. **Verify Ruby installation:**
   ```powershell
   ruby --version
   gem --version
   ```
   You should see version numbers for both commands.

### 2. Install ImageMagick (Required)

ImageMagick is needed to analyze book cover images for colors and dimensions:

1. **Download ImageMagick:**
   - Go to: https://imagemagick.org/script/download.php#windows
   - Download **ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe** (DLL version is important!)
   - Look for the link that says "Win64 dynamic at 16 bits-per-pixel component with high dynamic-range imaging"

2. **Install ImageMagick:**
   - Run the installer
   - ✅ Check **"Install legacy utilities (e.g. convert)"** - IMPORTANT!
   - ✅ Check **"Add application directory to your system path"**
   - Complete the installation

3. **Verify ImageMagick installation:**
   ```powershell
   magick --version
   ```

### 3. Install and Set Up Calibre

Calibre is a free ebook management application that organizes your book collection:

1. **Download Calibre:**
   - Go to: https://calibre-ebook.com/download_windows
   - Download the 64-bit Windows installer
   - Run the installer

2. **Launch Calibre** after installation

3. **Create Your Library:**
   - On first launch, Calibre will ask where to create your library
   - Choose a location (e.g., `C:\Users\YourName\Documents\Calibre Library`)
   - Remember this path - you'll need it later!

4. **Add Your Books to Calibre:**
   
   There are several ways to add books:

   **Option A: Drag and Drop**
   - Simply drag your ebook files (EPUB, MOBI, PDF, etc.) into the Calibre window
   - Calibre will automatically import them and fetch metadata

   **Option B: Use the "Add books" button**
   - Click "Add books" in the toolbar
   - Select your ebook files
   - Click Open

   **Option C: Bulk Import from a Folder**
   - Click "Add books" → "Add books from a single directory"
   - Select the folder containing your ebooks
   - Calibre will import all supported formats

5. **Edit Book Metadata (Optional but Recommended):**
   - Select a book in Calibre
   - Click "Edit metadata" button
   - Fill in: Title, Author(s), Series (if applicable), Description
   - Click "Download metadata" to automatically fetch book information
   - Add/update the cover image if needed
   - Save changes

6. **Find Your Calibre Library Path:**
   - In Calibre, click: **Calibre Preferences** → **Welcome wizard/change library**
   - Note the library path shown (e.g., `C:\Users\YourName\Documents\Calibre Library`)
   - You'll need this exact path to run the bookshelf app

## Setting Up the Bookshelf Application

Once you have Ruby, ImageMagick, and Calibre set up:

1. **Open PowerShell in the bookshelf directory:**
   ```powershell
   cd O:\CURSOR2\BOOKSHELF
   ```

2. **Install Ruby dependencies:**
   ```powershell
   bundle install
   ```

3. **Run the application:**
   ```powershell
   ruby app.rb "C:\Users\YourName\Documents\Calibre Library"
   ```
   Replace the path with your actual Calibre library path (use quotes if it contains spaces)

4. **Open your browser:**
   - Go to: http://localhost:4567
   - You should see your 3D bookshelf!

## Optional: Page Count Plugin

For better book thickness visualization:

1. **Download the Count Pages plugin:**
   - Visit: https://github.com/kiwidude68/calibre_plugins/tree/main/count_pages
   - Or install from Calibre: Preferences → Plugins → Get new plugins → Search "Count Pages"

2. **Configure the plugin:**
   - In Calibre: Preferences → Plugins → "Count Pages" → Customize plugin
   - Create a custom column named `pagecount`
   - The bookshelf app will automatically use this data

## Troubleshooting

### "The term 'ruby' is not recognized"
- Ruby is not in your PATH. Restart PowerShell or restart your computer after Ruby installation.

### "The term 'bundle' is not recognized"
- Run: `gem install bundler`

### ImageMagick errors
- Make sure you installed the **DLL version** with **legacy utilities**
- Restart your computer after installation

### "Please specify a Calibre library directory"
- You must provide the full path to your Calibre library folder
- Use quotes around the path: `ruby app.rb "C:\Path\To\Calibre Library"`

### No books showing up
- Make sure you've added books to Calibre
- Verify the path you're using points to a folder containing `metadata.db`
- Check that your books have covers in Calibre

### Books missing covers
- In Calibre, right-click a book → Edit metadata → Download cover
- Or manually add cover images in Calibre

## Tips for Best Results

1. **Add quality covers:** Books with good cover images look much better in 3D
2. **Fill in series information:** The shelf organizes books by author and series
3. **Add descriptions:** These show up on the back cover when you flip books
4. **Prefer EPUB format:** The app prefers EPUB files for downloads
5. **Use consistent metadata:** Clean, consistent metadata makes browsing easier

## How the App Works

The application:
- Reads `metadata.db` from your Calibre library (SQLite database)
- Extracts book metadata (title, author, series, description)
- Analyzes cover images to determine:
  - Book height (based on cover aspect ratio)
  - Spine color (sampled from cover edge)
  - Text contrast color (light/dark based on spine brightness)
- Displays books in a responsive 3D CSS interface
- Serves book files through download links

## Project Structure

```
O:\CURSOR2\BOOKSHELF\
├── app.rb              # Main Sinatra web application
├── calibre.rb          # Calibre database interface
├── logos.rb            # Logo/branding utilities
├── Gemfile             # Ruby dependencies
├── views/
│   └── index.erb       # Main HTML template
└── public/
    ├── css/
    │   ├── style.css   # Main styles
    │   └── anim.css    # 3D animations
    └── fonts/          # Custom fonts
```

## Next Steps

Once everything is running:
- Browse your collection in the 3D interface
- Click books to flip them and see descriptions
- Use search functionality to filter by author or series
- Click download links to get your ebook files

Enjoy your beautiful 3D bookshelf! 📚✨

