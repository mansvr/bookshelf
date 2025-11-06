# 🚀 Deploy Your Bookshelf to Vercel with Google Drive

## 📋 Overview

This guide will help you deploy your bookshelf online using:
- **Google Drive** - Store books and covers ($1.99/mo for 100GB or free <15GB)
- **Vercel** - Host the website (FREE)
- **Rclone** - Sync files automatically (FREE tool)

**Total Cost: $0-2/month** 🎉

---

## 🏗️ Architecture

```
Your PC                    Google Drive              Vercel (Online)
┌─────────┐               ┌──────────────┐          ┌─────────────┐
│ Calibre │ ──sync──→     │ Books/       │    ──→   │ Bookshelf   │
│ Library │               │ Covers/      │          │ Website     │
└─────────┘               │ metadata.json│          └─────────────┘
                          └──────────────┘
```

**Workflow:**
1. Add books to Calibre (as usual)
2. Run `sync-to-drive.ps1` (one command)
3. Git commit and push
4. Vercel auto-deploys! ✨

---

## ⚙️ Part 1: Set Up Google Drive

### **Step 1: Create Drive Folder Structure**

Go to [drive.google.com](https://drive.google.com) and create:

```
My Drive/
└── Bookshelf/
    ├── books/        (will hold PDFs/EPUBs)
    ├── covers/       (will hold cover images)
    └── metadata.json (will be auto-generated)
```

### **Step 2: Get Google Drive API Credentials**

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create new project: "Bookshelf"
3. Enable **Google Drive API**
4. Create credentials:
   - Go to "Credentials"
   - Create OAuth 2.0 Client ID
   - Application type: Desktop app
   - Download JSON → save as `google-drive-credentials.json`

Keep this file safe! You'll use it with Rclone.

---

## 🛠️ Part 2: Install and Configure Rclone

### **What is Rclone?**
Rclone is like rsync for cloud storage. It makes syncing to Google Drive super easy!

### **Step 1: Install Rclone**

**Windows:**
```powershell
# Download from https://rclone.org/downloads/
# Or use chocolatey:
choco install rclone

# Or use scoop:
scoop install rclone

# Verify installation:
rclone version
```

### **Step 2: Configure Rclone**

```powershell
# Start configuration
rclone config

# Follow these steps:
# n) New remote
# name> bookshelf-drive
# Storage> 18 (Google Drive)
# client_id> (leave blank or paste from credentials.json)
# client_secret> (leave blank or paste from credentials.json)
# scope> 1 (Full access)
# root_folder_id> (leave blank)
# service_account_file> (leave blank)
# Edit advanced config? n
# Use auto config? Y (opens browser)
# Configure this as a Shared Drive? n
# y) Yes this is OK
# q) Quit
```

### **Step 3: Test Rclone**

```powershell
# List your Drive contents
rclone lsd bookshelf-drive:

# Should see your folders
# You should see: Bookshelf
```

---

## 📝 Part 3: The Sync Scripts

See `RCLONE_SETUP.md` for detailed Rclone guide.

The main script `sync-to-drive.ps1` will:
1. Read your Calibre library
2. Extract book metadata and colors
3. Upload covers to Drive (optimized JPGs)
4. Upload book files to Drive
5. Generate `metadata.json`
6. Commit to Git

**One command = Full deployment pipeline!**

---

## 🌐 Part 4: Vercel Deployment

### **Step 1: Prepare for Vercel**

We'll convert your app to work as a static site that reads from JSON:

```ruby
# Old (local): Reads from Calibre database
CalibreBook.connect("D:\\BIBLIO_\\calibre")
@books = CalibreBook.some_books(25)

# New (Vercel): Reads from JSON
@books = JSON.parse(File.read('public/books.json'))
```

### **Step 2: Push to GitHub**

```powershell
# Initialize git (if not already)
git init
git add .
git commit -m "Initial commit"

# Create GitHub repo and push
git remote add origin https://github.com/YOUR_USERNAME/bookshelf.git
git push -u origin main
```

### **Step 3: Deploy to Vercel**

1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub
3. Click "New Project"
4. Import your bookshelf repo
5. Configure:
   - Framework Preset: Other
   - Build Command: (leave empty or use `bundle install`)
   - Output Directory: `.`
6. Deploy!

Your bookshelf will be live at: `https://your-project.vercel.app`

---

## 🔄 Part 5: The Update Workflow

### **When You Add New Books:**

```powershell
# 1. Add book to Calibre (as usual)

# 2. Run sync script (uploads to Drive, updates JSON)
.\sync-to-drive.ps1

# 3. Commit and push
git add public/books.json
git commit -m "Added new books"
git push

# 4. Vercel auto-deploys (30 seconds later, your site is updated!)
```

That's it! 🎉

---

## 💰 Cost Breakdown

### **FREE Tier (First ~12 books):**
- Google Drive: 15GB FREE
- Vercel: FREE (hobby plan)
- Rclone: FREE forever
- **Total: $0/month**

### **Paid Tier (Larger library):**
- Google Drive: $1.99/month (100GB)
- Vercel: FREE (still free!)
- Rclone: FREE (still free!)
- **Total: $1.99/month**

### **What You Get:**
- ✅ Professional website online
- ✅ Share with anyone (send them the link)
- ✅ Works on all devices
- ✅ Fast global CDN (Vercel)
- ✅ Automatic updates via Git
- ✅ SSL/HTTPS included
- ✅ Custom domain support

---

## 📊 File Size Estimates

**Per Book:**
- PDF: 5-50MB
- Cover: 100-500KB (we'll optimize!)

**Example Library:**
- 50 books × 20MB = 1GB
- 50 covers × 200KB = 10MB
- **Total: ~1GB** (fits in free tier!)

**100GB = ~5,000 books** 📚

---

## 🎯 Quick Reference

### **Commands You'll Use:**

```powershell
# Sync to Google Drive
.\sync-to-drive.ps1

# Deploy to Vercel (after sync)
git add .
git commit -m "Update books"
git push
```

### **Files Created:**
- `sync-to-drive.ps1` - Main sync script
- `generate-metadata.rb` - Metadata extractor
- `public/books.json` - Book data for website
- `vercel.json` - Vercel configuration
- `.gitignore` - Git ignore rules

---

## 📚 Next Steps

1. ✅ **Read**: `RCLONE_SETUP.md` (detailed Rclone guide)
2. ✅ **Read**: `GOOGLE_DRIVE_STRUCTURE.md` (folder setup)
3. ✅ **Run**: `sync-to-drive.ps1` (first sync)
4. ✅ **Deploy**: Push to GitHub → Deploy to Vercel
5. ✅ **Share**: Your bookshelf is online!

---

## 🆘 Troubleshooting

### **"Rclone not found"**
- Install Rclone: `choco install rclone`
- Or download from https://rclone.org

### **"Permission denied on Drive"**
- Run: `rclone config reconnect bookshelf-drive:`
- Re-authenticate in browser

### **"Books not uploading"**
- Check Drive has space
- Verify Rclone config: `rclone about bookshelf-drive:`

### **"Vercel build failed"**
- Check `vercel.json` is correct
- Verify `public/books.json` exists

---

## 🎊 Success!

Once deployed, your bookshelf will be:
- 🌍 **Online** and accessible anywhere
- 📱 **Mobile-friendly** (responsive design)
- ⚡ **Fast** (Vercel CDN)
- 🔐 **Secure** (HTTPS)
- 💰 **Cheap** ($0-2/month)

**Share your library with the world!** 📚✨

