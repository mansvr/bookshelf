# Rclone Google Drive Quick Setup

## ✅ Rclone is already installed!

Location: `O:\CURSOR2\BOOKSHELF\rclone.exe`

---

## 🚀 Step-by-Step Configuration

### Step 1: Open Windows Terminal (PowerShell)

```powershell
cd O:\CURSOR2\BOOKSHELF
```

### Step 2: Run Rclone Config

```powershell
.\rclone.exe config
```

### Step 3: Follow These Prompts

```
e/n/d/r/c/s/q> n
(Type 'n' for new remote)

name> bookshelf-drive
(Choose any name you like)

Storage> drive
(Type 'drive' for Google Drive)

client_id> 
(Just press Enter - leave blank)

client_secret>
(Just press Enter - leave blank)

scope> 1
(Type '1' for full access)

root_folder_id>
(Just press Enter)

service_account_file>
(Just press Enter)

Edit advanced config? (y/n)> n
(Type 'n')

Use auto config? (y/n)> y
(Type 'y' - a browser will open)
```

### Step 4: Browser Authorization

1. **A browser window will open automatically**
2. **Sign in to your Google account**
3. **Click "Allow"** to grant Rclone access
4. **You'll see "Success!"** in the browser
5. **Return to your terminal**

### Step 5: Finish Configuration

```
Configure this as a team drive? (y/n)> n
(Type 'n')

y/e/d> y
(Type 'y' to confirm)

e/n/d/r/c/s/q> q
(Type 'q' to quit)
```

---

## ✅ Step 6: Test It Works

```powershell
.\rclone.exe lsd bookshelf-drive:
```

You should see your Google Drive folders listed!

---

## 📁 Step 7: Create Bookshelf Folders

```powershell
.\rclone.exe mkdir bookshelf-drive:Bookshelf
.\rclone.exe mkdir bookshelf-drive:Bookshelf/books
.\rclone.exe mkdir bookshelf-drive:Bookshelf/covers
```

---

## ⚙️ Step 8: Update sync-to-drive.ps1

Open `sync-to-drive.ps1` and change line 9:

```powershell
$RcloneRemote = "bookshelf-drive"  # Change this to match your remote name
```

---

## 🎉 You're Ready!

### Test the sync:

```powershell
.\sync-to-drive.ps1
```

This will:
1. Extract metadata from your Calibre library
2. Copy book covers to Google Drive
3. Copy book files to Google Drive
4. Generate `books.json` with Drive URLs
5. Ready for deployment!

---

## 🆘 Troubleshooting

### "Remote not found"
- Make sure you typed the remote name correctly
- Run `.\rclone.exe listremotes` to see all configured remotes

### "Access denied"
- Go back through Step 4 and make sure you clicked "Allow"
- Try running `.\rclone.exe config reconnect bookshelf-drive:`

### "Browser didn't open"
- Run `.\rclone.exe config` again
- When asked "Use auto config?" type `y` again
- Manually open the URL it shows if browser doesn't open

---

## 📖 Full Documentation

For more details, see `RCLONE_SETUP.md`

