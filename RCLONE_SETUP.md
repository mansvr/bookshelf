# 🔧 Rclone Setup - Complete Guide

## 📖 What is Rclone?

Rclone is a command-line program to sync files and directories to/from cloud storage. Think of it as "rsync for the cloud"!

**Why Rclone?**
- ✅ **FREE and open source**
- ✅ **Works with 40+ cloud providers**
- ✅ **Fast and efficient** (only uploads changes)
- ✅ **Powerful** (can do almost anything)
- ✅ **Reliable** (used by millions)

---

## 📥 Installation

### **Windows (Recommended Methods)**

**Option 1: Chocolatey (Easiest)**
```powershell
# Install Chocolatey first if you don't have it
# Then:
choco install rclone

# Verify
rclone version
```

**Option 2: Scoop**
```powershell
scoop install rclone

# Verify
rclone version
```

**Option 3: Manual Download**
1. Go to https://rclone.org/downloads/
2. Download Windows ZIP
3. Extract to `C:\Program Files\rclone\`
4. Add to PATH:
   ```powershell
   $env:PATH += ";C:\Program Files\rclone"
   # Make permanent:
   [Environment]::SetEnvironmentVariable("Path", $env:PATH, "Machine")
   ```

---

## 🔐 Configuration

### **Step 1: Get Google Drive API Credentials (Optional but Recommended)**

Using your own API credentials is more secure and has higher limits.

1. **Go to Google Cloud Console**
   - https://console.cloud.google.com

2. **Create New Project**
   - Click "Select a project" → "New Project"
   - Name: "Bookshelf"
   - Click "Create"

3. **Enable Google Drive API**
   - Click "APIs & Services" → "Enable APIs and Services"
   - Search for "Google Drive API"
   - Click "Enable"

4. **Create OAuth Credentials**
   - Go to "Credentials" tab
   - Click "Create Credentials" → "OAuth client ID"
   - If prompted, configure consent screen:
     - User Type: External
     - App name: "My Bookshelf"
     - User support email: your email
     - Developer contact: your email
     - Save and continue (skip scopes)
     - Add yourself as test user
     - Save
   - Now create OAuth client ID:
     - Application type: **Desktop app**
     - Name: "Bookshelf Desktop"
     - Click "Create"
   
5. **Download Credentials**
   - Click download icon (⬇️) next to your new OAuth client
   - Save as `google-drive-credentials.json`
   - Keep this file safe!

### **Step 2: Configure Rclone**

```powershell
# Start interactive configuration
rclone config
```

#### **Follow These Steps:**

```
Current remotes:
(probably empty)

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config

Choose: n
```

**1. Name the remote:**
```
name> bookshelf-drive
```

**2. Choose storage type:**
```
Storage> drive
# Or type: 18 (if drive is option 18)
```

**3. Google Application Client Id (optional):**
```
client_id> (paste from credentials.json OR leave blank)
# If you downloaded credentials, open the JSON file
# Copy the "client_id" value
# If you don't have credentials, just press Enter (uses Rclone's default)
```

**4. OAuth Client Secret (optional):**
```
client_secret> (paste from credentials.json OR leave blank)
# Same as above - copy from JSON or press Enter
```

**5. Scope:**
```
scope> 1
# 1 = Full access to all files
```

**6. Root folder ID:**
```
root_folder_id> (leave blank)
# Press Enter
```

**7. Service Account File:**
```
service_account_file> (leave blank)
# Press Enter
```

**8. Advanced config:**
```
Edit advanced config? (y/n)
y/n> n
```

**9. Auto config:**
```
Use auto config?
 * Say Y if not sure
 * Say N if you are working on a remote or headless machine

y/n> Y
```

**10. Browser Authentication**
- Browser window opens automatically
- Sign in to your Google account
- Click "Allow" when asked for permissions
- Close browser when it says "Success"

**11. Shared Drive:**
```
Configure this as a Shared Drive (Team Drive)?
y/n> n
```

**12. Confirm:**
```
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote

y/e/d> y
```

**13. Quit:**
```
q) Quit config
q
```

---

## ✅ Test Your Configuration

### **1. List Drive Contents**
```powershell
rclone lsd bookshelf-drive:
```

Should show your Google Drive folders!

### **2. Check Drive Space**
```powershell
rclone about bookshelf-drive:
```

Shows how much space you have.

### **3. List Files in Bookshelf Folder**
```powershell
rclone ls bookshelf-drive:Bookshelf/
```

Should show empty (or your folder structure if you created it).

---

## 📁 Create Folder Structure in Drive

### **Option 1: Via Web (drive.google.com)**
1. Go to drive.google.com
2. Create folders manually:
   - Bookshelf/
   - Bookshelf/books/
   - Bookshelf/covers/

### **Option 2: Via Rclone**
```powershell
# Create folders
rclone mkdir bookshelf-drive:Bookshelf
rclone mkdir bookshelf-drive:Bookshelf/books
rclone mkdir bookshelf-drive:Bookshelf/covers

# Verify
rclone lsd bookshelf-drive:Bookshelf/
```

---

## 🔄 Common Rclone Commands

### **Upload Files**
```powershell
# Copy a file
rclone copy "local-file.pdf" bookshelf-drive:Bookshelf/books/

# Copy a folder
rclone copy "D:\BIBLIO_\calibre\Author\Book\" bookshelf-drive:Bookshelf/books/Author/
```

### **Sync (Better for updates)**
```powershell
# Sync local folder to Drive (one-way)
rclone sync "D:\local-folder\" bookshelf-drive:Bookshelf/books/

# This will:
# - Upload new files
# - Update changed files
# - DELETE files on Drive that aren't local (be careful!)
```

### **Download Files**
```powershell
# Copy from Drive to local
rclone copy bookshelf-drive:Bookshelf/books/ "D:\downloads\"
```

### **List Files**
```powershell
# List directories
rclone lsd bookshelf-drive:Bookshelf/

# List all files (with sizes)
rclone ls bookshelf-drive:Bookshelf/

# List with details
rclone lsl bookshelf-drive:Bookshelf/
```

### **Check What Would Change**
```powershell
# Dry run (shows what would happen without doing it)
rclone sync "D:\local\" bookshelf-drive:Bookshelf/ --dry-run
```

---

## 🎯 Useful Flags

```powershell
# Show progress
rclone copy file.pdf bookshelf-drive:folder/ --progress

# Show detailed transfers
rclone copy file.pdf bookshelf-drive:folder/ -v

# Dry run (don't actually do anything)
rclone sync folder/ bookshelf-drive:folder/ --dry-run

# Skip existing files (faster)
rclone copy folder/ bookshelf-drive:folder/ --ignore-existing

# Update only if newer
rclone copy folder/ bookshelf-drive:folder/ --update
```

---

## 🚀 For Your Bookshelf Project

### **What Our Sync Script Will Do:**

```powershell
# 1. Upload covers (optimized)
rclone copy covers/ bookshelf-drive:Bookshelf/covers/ `
  --include "*.jpg" `
  --transfers 8 `
  --progress

# 2. Upload books
rclone copy books/ bookshelf-drive:Bookshelf/books/ `
  --include "*.{pdf,epub,mobi}" `
  --transfers 4 `
  --progress

# 3. Upload metadata
rclone copy books.json bookshelf-drive:Bookshelf/metadata.json
```

**The script does this automatically!**

---

## 🔒 Security Best Practices

### **1. Protect Your Credentials**
```powershell
# Add to .gitignore
echo "google-drive-credentials.json" >> .gitignore
echo "rclone.conf" >> .gitignore
```

### **2. Use Selective Sync**
Don't sync your entire Calibre folder! Only sync what you need.

```powershell
# Good: Sync only books/covers
rclone sync books/ bookshelf-drive:Bookshelf/books/

# Bad: Sync entire Calibre (includes private metadata.db)
rclone sync "D:\BIBLIO_\calibre\" bookshelf-drive:Bookshelf/
```

### **3. Set Access Permissions**
In Google Drive web interface:
- Right-click "Bookshelf" folder
- "Share"
- Choose who can access
- For public bookshelf: "Anyone with the link" → "Viewer"

---

## 🐛 Troubleshooting

### **"ERROR : Failed to create file system for 'bookshelf-drive:'"**
- Run: `rclone config reconnect bookshelf-drive:`
- Re-authenticate in browser

### **"403: Rate Limit Exceeded"**
- You're uploading too fast
- Add `--tpslimit 10` flag (10 transactions per second)

### **"401: Unauthorized"**
- Token expired
- Run: `rclone config reconnect bookshelf-drive:`

### **"Can't find bookshelf-drive"**
- Check config: `rclone config show`
- Make sure you named it correctly during setup

### **Files not appearing in Drive**
- Wait a few seconds (Drive indexes slowly)
- Refresh drive.google.com
- Check with: `rclone ls bookshelf-drive:Bookshelf/`

---

## 📊 Performance Tips

### **Faster Uploads**
```powershell
# Use more parallel transfers (default is 4)
rclone copy folder/ bookshelf-drive:folder/ --transfers 8

# Use higher bandwidth
rclone copy folder/ bookshelf-drive:folder/ --bwlimit off
```

### **Efficient Syncing**
```powershell
# Only check file size and modified time (faster)
rclone sync folder/ bookshelf-drive:folder/ --size-only

# Skip files that already exist
rclone copy folder/ bookshelf-drive:folder/ --ignore-existing
```

---

## ✅ Verification Checklist

Before proceeding, make sure:

- [ ] Rclone is installed (`rclone version` works)
- [ ] Configuration complete (`rclone lsd bookshelf-drive:` works)
- [ ] Can list Drive contents
- [ ] Folders created in Drive (Bookshelf/books/, Bookshelf/covers/)
- [ ] Test upload works (`rclone copy test.txt bookshelf-drive:Bookshelf/`)
- [ ] Can see uploaded file in drive.google.com

---

## 🎓 Learn More

**Official Rclone Docs:**
- https://rclone.org/docs/
- https://rclone.org/drive/

**Rclone Commands:**
- https://rclone.org/commands/

---

## 🎉 You're Ready!

Rclone is now configured and ready to sync your bookshelf to Google Drive!

**Next Steps:**
1. Read `GOOGLE_DRIVE_STRUCTURE.md`
2. Run `sync-to-drive.ps1`
3. Deploy to Vercel!

Happy syncing! 📚✨

