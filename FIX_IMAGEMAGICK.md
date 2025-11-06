# 🔧 ImageMagick Architecture Mismatch - FIX NEEDED

## ❌ The Problem

You have:
- **Ruby**: 64-bit (`C:\Ruby33-x64`)
- **ImageMagick**: 32-bit (`C:\Program Files (x86)\ImageMagick-7.1.2-Q16-HDRI`)

The `rmagick` gem won't compile because of this architecture mismatch!

## ✅ The Solution

You need to install the **64-bit version** of ImageMagick.

### Step 1: Uninstall Current ImageMagick

1. Press `Windows key` + `R`
2. Type: `appwiz.cpl` and press Enter
3. Find "ImageMagick" in the list
4. Click "Uninstall"
5. Follow the prompts

### Step 2: Download 64-bit ImageMagick

1. Go to: https://imagemagick.org/script/download.php#windows
2. Scroll to "Windows Binary Release"
3. Look for a link that says **"Win64"** or **"x64"** (NOT x86!)
4. Download: **`ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe`**
   - Make sure it says:
     - ✅ **x64** (64-bit)
     - ✅ **dll** (dynamic libraries)
     - ✅ **Q16-HDRI**

### Step 3: Install 64-bit ImageMagick

1. Run the installer you just downloaded
2. **IMPORTANT checkboxes:**
   - ✅ Check "Install legacy utilities (e.g., convert)"
   - ✅ Check "Add application directory to your system path"
3. Click Install
4. Complete the installation

### Step 4: Verify Installation

Close and reopen PowerShell, then run:

```powershell
magick -version
```

You should see version info WITHOUT errors.

### Step 5: Install Ruby Gems

```powershell
cd O:\CURSOR2\BOOKSHELF
.\setup_and_install.ps1
```

This time the `rmagick` gem should compile successfully!

### Step 6: Run Your Bookshelf

```powershell
.\run_my_bookshelf.ps1
```

Then open: **http://localhost:4567**

## 🎯 Quick Commands After Fixing ImageMagick

```powershell
# 1. Navigate to project
cd O:\CURSOR2\BOOKSHELF

# 2. Install gems
.\setup_and_install.ps1

# 3. Run bookshelf
.\run_my_bookshelf.ps1
```

## 📝 What to Look For When Downloading

On the ImageMagick download page, you want a file name like:
- ✅ `ImageMagick-7.1.2-1-Q16-HDRI-x64-dll.exe` (CORRECT - x64!)
- ❌ `ImageMagick-7.1.2-1-Q16-HDRI-x86-dll.exe` (WRONG - x86 is 32-bit)

The key differences:
- **x64** = 64-bit (what you need!)
- **x86** = 32-bit (what you currently have)

## 🆘 Alternative: Direct Download Link

If you're having trouble finding it, the direct download link pattern is usually:
https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-1-Q16-HDRI-x64-dll.exe

(Replace version numbers as needed)

---

**Once you've installed 64-bit ImageMagick, run `.\setup_and_install.ps1` and everything should work!**

