# ⚡ Quick Start - Deploy Your Bookshelf Online

## 🎯 Goal
Get your bookshelf online in **~30 minutes** using Google Drive + Vercel!

---

## 📝 What You'll Need

- ✅ Your Calibre library (`D:\BIBLIO_\calibre`)
- ✅ Google account (for Google Drive)
- ✅ GitHub account (for Git)
- ✅ 30 minutes of time

**Cost:** $0-2/month (depending on library size)

---

## 🚀 Five-Minute Overview

```
Your Workflow:
1. Install Rclone (5 min)
2. Configure Google Drive (10 min)
3. Run sync script (5 min)
4. Push to GitHub (5 min)
5. Deploy to Vercel (5 min)

Then: Add books → Run script → Auto-deploys! ✨
```

---

## 📖 Step-by-Step

### **Part 1: Install Rclone (5 minutes)**

```powershell
# Option A: Chocolatey (easiest)
choco install rclone

# Option B: Scoop
scoop install rclone

# Option C: Download from rclone.org and add to PATH
```

**Verify:**
```powershell
rclone version
# Should show version info
```

✅ **Checkpoint:** Rclone command works

---

### **Part 2: Configure Rclone for Google Drive (10 minutes)**

```powershell
# Start configuration
rclone config

# Follow prompts:
# n) New remote
# name> bookshelf-drive
# Storage> drive (or 18)
# Leave client_id/secret blank (or use your own)
# scope> 1 (full access)
# Use auto config? Y
# Browser opens → Sign in → Allow
# q) Quit config
```

**Test:**
```powershell
rclone lsd bookshelf-drive:
# Should list your Google Drive folders
```

**Create folders:**
```powershell
rclone mkdir bookshelf-drive:Bookshelf
rclone mkdir bookshelf-drive:Bookshelf/books
rclone mkdir bookshelf-drive:Bookshelf/covers
```

✅ **Checkpoint:** Can list Drive contents

**📚 Detailed Guide:** See `RCLONE_SETUP.md`

---

### **Part 3: Sync Your Library to Drive (5 minutes)**

```powershell
# Run the sync script
.\sync-to-drive.ps1
```

**What it does:**
- ✅ Reads Calibre database
- ✅ Extracts book colors and metadata
- ✅ Optimizes cover images
- ✅ Uploads to Google Drive
- ✅ Generates `public/books.json`

**Expected output:**
```
Step 1: Generating metadata... ✓
Step 2: Preparing files... ✓
Step 3: Optimizing covers... ✓
Step 4: Preparing books... ✓
Step 5: Uploading to Drive... ✓
Step 6: Getting file IDs... ✓
🎉 Sync Complete!
```

✅ **Checkpoint:** Files visible in drive.google.com/drive/Bookshelf/

---

### **Part 4: Push to GitHub (5 minutes)**

**Create repository on GitHub:**
1. Go to github.com
2. Click "New repository"
3. Name: `bookshelf`
4. Privacy: Your choice
5. Don't initialize with anything
6. Click "Create"

**Push your code:**
```powershell
# Initialize Git (if not already done)
git init

# Add files
git add .

# Commit
git commit -m "Initial bookshelf deployment"

# Add GitHub remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/bookshelf.git

# Push
git branch -M main
git push -u origin main
```

✅ **Checkpoint:** Code visible on GitHub

---

### **Part 5: Deploy to Vercel (5 minutes)**

1. **Go to vercel.com**
2. **Sign up** with GitHub (free)
3. **Click "New Project"**
4. **Import** your bookshelf repository
5. **Configure:**
   - Framework Preset: **Other**
   - Build Command: (leave empty)
   - Output Directory: `.`
6. **Click "Deploy"**

Wait 1-2 minutes...

✅ **Done!** Your site is live!

**Your URL:** `https://bookshelf-xyz.vercel.app`

---

## 🎉 Success!

Visit your Vercel URL. You should see:
- ✅ Your books in a 3D shelf
- ✅ Real cover colors
- ✅ Click books to flip
- ✅ "View" button opens book from Drive
- ✅ Theme toggle (light/dark)

---

## 🔄 Adding New Books (30 seconds)

From now on, whenever you add books to Calibre:

```powershell
# One command does everything!
.\deploy-workflow.ps1
```

This will:
1. Sync new books to Drive
2. Update metadata
3. Commit to Git
4. Push to GitHub
5. Vercel auto-deploys

**Your site updates in ~2 minutes!** ✨

---

## 📁 Files Created

Here's what the setup created:

```
O:\CURSOR2\BOOKSHELF\
├── sync-to-drive.ps1           ← Main sync script
├── deploy-workflow.ps1         ← One-command deployment
├── generate-metadata.rb        ← Metadata extractor
├── app-vercel.rb               ← Web app for Vercel
├── vercel.json                 ← Vercel configuration
├── .gitignore                  ← Git ignore rules
├── public/
│   └── books.json              ← Book metadata (auto-generated)
├── views/
│   └── index-vercel.erb        ← Web template
└── docs/
    ├── DEPLOY_TO_VERCEL.md
    ├── RCLONE_SETUP.md
    ├── GOOGLE_DRIVE_STRUCTURE.md
    └── DEPLOYMENT_CHECKLIST.md
```

---

## 🎯 Key Commands

```powershell
# Full deployment (recommended)
.\deploy-workflow.ps1

# Test before deploying
.\deploy-workflow.ps1 -DryRun

# Just sync to Drive
.\sync-to-drive.ps1

# Check status
git status
```

---

## 💰 Costs

### **Google Drive:**
- FREE: 15GB (good for ~750 books)
- $1.99/mo: 100GB (5,000+ books)

### **Vercel:**
- FREE: Unlimited bandwidth
- Automatic HTTPS
- Global CDN

### **Rclone:**
- FREE forever

**Total: $0-2/month** 🎉

---

## 🐛 Common Issues

### **"Rclone not found"**
```powershell
choco install rclone
# Then restart PowerShell
```

### **"Can't connect to Drive"**
```powershell
rclone config reconnect bookshelf-drive:
# Re-authenticate in browser
```

### **"Git push rejected"**
```powershell
git pull origin main --rebase
git push
```

### **"Vercel build failed"**
- Check `vercel.json` exists
- Verify `app-vercel.rb` exists
- Check build logs on Vercel dashboard

---

## 📚 Learn More

- **Full Guide:** `DEPLOY_TO_VERCEL.md`
- **Rclone Setup:** `RCLONE_SETUP.md`
- **Drive Structure:** `GOOGLE_DRIVE_STRUCTURE.md`
- **Checklist:** `DEPLOYMENT_CHECKLIST.md`

---

## ✅ Verification

Your deployment is successful when:

- [ ] Can access bookshelf at Vercel URL
- [ ] All books are visible
- [ ] Cover images load
- [ ] Can click books
- [ ] "View" opens book from Drive
- [ ] Theme toggle works
- [ ] Works on mobile
- [ ] `.\deploy-workflow.ps1` completes without errors

---

## 🎊 What's Next?

### **Optional Enhancements:**

1. **Custom Domain**
   - Buy domain from Namecheap/Google
   - Add to Vercel project
   - Point DNS to Vercel

2. **Page Count Plugin**
   - See `INSTALL_PAGE_COUNT_PLUGIN.md`
   - Makes books variable thickness

3. **3D Version**
   - Deploy React Three Fiber version
   - See `3D_BOOKSHELF_GUIDE.md`

---

## 💡 Pro Tips

1. **Use dry run first**
   ```powershell
   .\deploy-workflow.ps1 -DryRun
   ```

2. **Check Drive space regularly**
   ```powershell
   rclone about bookshelf-drive:
   ```

3. **Keep metadata.db backed up**
   ```powershell
   Copy-Item "D:\BIBLIO_\calibre\metadata.db" "D:\backups\"
   ```

4. **Monitor Vercel deployments**
   - Visit vercel.com/dashboard
   - Check build logs if issues

---

## 🚀 You're Done!

Your bookshelf is now:
- 🌍 **Online** and accessible anywhere
- 📱 **Mobile-friendly**
- 🔄 **Easy to update** (one command!)
- 💰 **Cheap** ($0-2/month)
- 🎨 **Beautiful** (responsive design, themes)
- ⚡ **Fast** (Vercel CDN)

**Share your library with the world!** 📚✨

---

## 📞 Quick Help

**Stuck?** Check these files:
- Setup issues → `RCLONE_SETUP.md`
- Drive questions → `GOOGLE_DRIVE_STRUCTURE.md`
- Deployment → `DEPLOY_TO_VERCEL.md`
- Checklist → `DEPLOYMENT_CHECKLIST.md`

**Commands cheat sheet:**
```powershell
# Deploy everything
.\deploy-workflow.ps1

# Test mode
.\deploy-workflow.ps1 -DryRun

# Just sync
.\sync-to-drive.ps1

# Check Drive
rclone lsd bookshelf-drive:Bookshelf/

# Check Git
git status
git log --oneline -5

# Open site
start https://your-project.vercel.app
```

Happy deploying! 🎉

