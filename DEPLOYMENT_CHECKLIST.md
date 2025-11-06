# ✅ Deployment Checklist

Use this checklist to deploy your bookshelf for the first time!

---

## 📋 Pre-Deployment Setup

### **1. Install Prerequisites**

- [ ] Ruby installed and working (`ruby --version`)
- [ ] Rclone installed (`rclone version`)
- [ ] ImageMagick installed (`magick --version`) - optional but recommended
- [ ] Git installed (`git --version`)
- [ ] GitHub account created

### **2. Google Drive Setup**

- [ ] Google Drive account ready
- [ ] Folder structure created (see `GOOGLE_DRIVE_STRUCTURE.md`)
  - [ ] `Bookshelf/`
  - [ ] `Bookshelf/books/`
  - [ ] `Bookshelf/covers/`
- [ ] Google Drive API credentials obtained (optional)
- [ ] Rclone configured (`rclone lsd bookshelf-drive:`)

### **3. Local Setup**

- [ ] Calibre library accessible
- [ ] Books have metadata (titles, authors)
- [ ] Cover images exist
- [ ] Test local bookshelf works (`.\run_my_bookshelf.ps1`)

---

## 🚀 First Deployment Steps

### **Step 1: Test Metadata Generation**

```powershell
ruby generate-metadata.rb "D:\BIBLIO_\calibre"
```

- [ ] Script runs without errors
- [ ] `public/books.json` created
- [ ] JSON file looks correct (check with text editor)

### **Step 2: Test Sync (Dry Run)**

```powershell
.\sync-to-drive.ps1 -DryRun
```

- [ ] Script runs without errors
- [ ] Shows what would be uploaded
- [ ] No error messages about missing files

### **Step 3: Actual Sync to Drive**

```powershell
.\sync-to-drive.ps1
```

- [ ] Covers uploaded successfully
- [ ] Books uploaded successfully
- [ ] File IDs retrieved
- [ ] `public/books.json` updated with Drive URLs

**Verify in Google Drive:**
- [ ] Open drive.google.com
- [ ] Navigate to Bookshelf folder
- [ ] See books/ and covers/ with files
- [ ] File count matches your library

### **Step 4: Initialize Git Repository**

```powershell
git init
```

- [ ] Git initialized (`.git` folder created)

### **Step 5: Create .gitignore**

Already created! Verify it includes:
- [ ] `*.pdf`
- [ ] `*.epub`
- [ ] `metadata.db`
- [ ] `google-drive-credentials.json`

### **Step 6: First Commit**

```powershell
git add .
git commit -m "Initial commit: Bookshelf with Google Drive"
```

- [ ] Files staged
- [ ] Commit successful
- [ ] Check what was committed: `git log`

### **Step 7: Create GitHub Repository**

1. Go to github.com
2. Click "New repository"
3. Name: `bookshelf` or `my-library`
4. Keep it private (if books are copyrighted)
5. Don't initialize with README (already have files)
6. Click "Create repository"

- [ ] Repository created
- [ ] Got repository URL

### **Step 8: Push to GitHub**

```powershell
git remote add origin https://github.com/YOUR_USERNAME/bookshelf.git
git branch -M main
git push -u origin main
```

- [ ] Remote added
- [ ] Pushed successfully
- [ ] Can see files on GitHub

### **Step 9: Deploy to Vercel**

1. Go to vercel.com
2. Sign up with GitHub
3. Click "New Project"
4. Import your bookshelf repository
5. Configure:
   - Framework: Other
   - Build Command: (leave empty)
   - Output Directory: `.`
   - Install Command: `bundle install`
6. Add environment variable (if needed):
   - Name: `BUNDLE_WITHOUT`
   - Value: `development:test`
7. Click "Deploy"

- [ ] Project imported
- [ ] Build started
- [ ] Build completed successfully
- [ ] Got deployment URL

### **Step 10: Test Deployed Site**

Visit your Vercel URL (e.g., `https://bookshelf-xyz.vercel.app`)

- [ ] Site loads
- [ ] Can see books
- [ ] Cover images load
- [ ] Can click books to flip
- [ ] Theme toggle works
- [ ] "View" button opens Drive file

---

## 🔄 Future Updates

When you add new books to Calibre:

### **Quick Update (Recommended)**

```powershell
.\deploy-workflow.ps1
```

This does everything:
- [ ] Syncs to Drive
- [ ] Updates metadata
- [ ] Commits to Git
- [ ] Pushes to GitHub
- [ ] Triggers Vercel deploy

### **Manual Update**

```powershell
# 1. Sync
.\sync-to-drive.ps1

# 2. Commit
git add public/books.json
git commit -m "Added new books"
git push

# 3. Vercel auto-deploys!
```

- [ ] New books appear on site in ~2 minutes

---

## 🐛 Troubleshooting

### **Metadata Generation Failed**

```powershell
# Check Calibre path
Test-Path "D:\BIBLIO_\calibre\metadata.db"

# Try with explicit path
ruby generate-metadata.rb "D:\BIBLIO_\calibre"
```

### **Rclone Upload Failed**

```powershell
# Test connection
rclone lsd bookshelf-drive:

# Check space
rclone about bookshelf-drive:

# Reconnect if needed
rclone config reconnect bookshelf-drive:
```

### **Drive URLs Not Working**

- Check file permissions in Drive (should be "Anyone with link")
- Verify file IDs in metadata.json look correct
- Test URL in browser directly

### **Vercel Build Failed**

Common issues:
- Missing `Gemfile` - create one with `gem "sinatra", "~> 4.0"`
- Wrong Ruby version - add `.ruby-version` file
- Missing `vercel.json` - check it exists

### **Books Not Showing**

- Check `public/books.json` exists
- Verify JSON is valid (use jsonlint.com)
- Check browser console for errors (F12)
- Verify Drive URLs are public

---

## ✅ Success Criteria

Your deployment is successful when:

- [ ] ✅ Can access site via Vercel URL
- [ ] ✅ All books visible on homepage
- [ ] ✅ Cover images load correctly
- [ ] ✅ Can click books to see details
- [ ] ✅ "View" button downloads book from Drive
- [ ] ✅ Theme toggle works
- [ ] ✅ Site is responsive on mobile
- [ ] ✅ Adding new books takes <5 minutes

---

## 📊 Maintenance Schedule

### **Weekly:**
- [ ] Check Vercel deployment status
- [ ] Verify Drive links still work

### **Monthly:**
- [ ] Check Drive storage usage
- [ ] Clean up unused book versions
- [ ] Update dependencies if needed

### **When Adding Books:**
- [ ] Add to Calibre
- [ ] Run `.\deploy-workflow.ps1`
- [ ] Wait 2 minutes
- [ ] Verify on site

---

## 🎯 Performance Metrics

Track these to ensure good performance:

- [ ] **Site Load Time:** <3 seconds
- [ ] **Cover Load Time:** <1 second each
- [ ] **JSON Size:** <100KB (for good performance)
- [ ] **Drive Usage:** Within your quota
- [ ] **Deploy Time:** 1-2 minutes
- [ ] **Update Frequency:** Works smoothly

---

## 🎉 Congratulations!

When all checkboxes are ticked, your bookshelf is:

- ✅ **Online** and accessible
- ✅ **Backed up** to Google Drive
- ✅ **Version controlled** with Git
- ✅ **Automatically deployed** via Vercel
- ✅ **Easy to update** (one command!)

Share your bookshelf URL with friends! 📚✨

---

## 📞 Quick Reference

```powershell
# Full deployment (recommended)
.\deploy-workflow.ps1

# Just sync to Drive
.\sync-to-drive.ps1

# Dry run (test without changes)
.\deploy-workflow.ps1 -DryRun

# Check status
git status
rclone lsd bookshelf-drive:Bookshelf/

# View your site
start https://your-project.vercel.app
```

---

**Need help?** Check:
- `DEPLOY_TO_VERCEL.md` - Full deployment guide
- `RCLONE_SETUP.md` - Rclone configuration
- `GOOGLE_DRIVE_STRUCTURE.md` - Drive folder setup

