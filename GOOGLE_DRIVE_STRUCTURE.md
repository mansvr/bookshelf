# 📁 Google Drive Folder Structure

## 🏗️ Overview

Your Google Drive will be organized like this for optimal performance and easy management:

```
My Drive/
└── Bookshelf/                    (Main folder)
    ├── books/                    (All book files)
    │   ├── 1.pdf
    │   ├── 2.epub
    │   ├── 3.pdf
    │   └── ...
    ├── covers/                   (Optimized cover images)
    │   ├── 1.jpg
    │   ├── 2.jpg
    │   ├── 3.jpg
    │   └── ...
    └── metadata.json             (Book information)
```

---

## 📚 books/ Folder

### **What Goes Here:**
- PDF files
- EPUB files
- MOBI files (if you have them)

### **Naming Convention:**
```
{book_id}.{extension}

Examples:
1.pdf
2.epub
3.pdf
12.pdf
```

### **Why This Structure?**
- ✅ Simple ID-based names (no special characters)
- ✅ Works with all systems (Windows, Mac, Linux)
- ✅ Easy to reference in code
- ✅ No issues with long file names

### **Access:**
- **Keep these files PRIVATE** if they're copyrighted
- Use Google Drive API to generate temporary download links
- Or make public if they're public domain books

---

## 🖼️ covers/ Folder

### **What Goes Here:**
- Optimized cover images (JPG format)
- Smaller file sizes for faster loading

### **Naming Convention:**
```
{book_id}.jpg

Examples:
1.jpg
2.jpg
3.jpg
```

### **Optimization:**
Our sync script will automatically:
- Convert covers to JPG (if needed)
- Resize to max 400px width (perfect for web)
- Compress to ~100KB each
- Maintains aspect ratio

### **Access:**
- These should be **PUBLIC** (safe to share)
- Makes website faster (no authentication needed)
- Users can see cover without downloading book

---

## 📄 metadata.json

### **What Is This:**
A single JSON file containing ALL book information.

### **Structure:**
```json
[
  {
    "id": 1,
    "title": "Architecture Inspired by Nature",
    "author": "Various Editors",
    "description": "Explores biomimetic architecture...",
    "cover_url": "https://drive.google.com/uc?id=ABC123",
    "book_url": "https://drive.google.com/uc?id=XYZ789",
    "cover_color": "#8B4513",
    "cover_contrast": "#ffffff",
    "page_count": 320,
    "aspect_ratio": 0.67,
    "series": null,
    "series_index": null
  },
  {
    "id": 2,
    "title": "Another Book",
    ...
  }
]
```

### **Why JSON?**
- ✅ Fast to load (one file vs database)
- ✅ Easy to edit manually if needed
- ✅ Works perfectly with Vercel
- ✅ Can be cached by CDN
- ✅ Git-friendly (see changes in commits)

### **Access:**
- **PUBLIC** (safe, no private data)
- Your website reads this to display books

---

## 🔗 File Links and URLs

### **For Covers (Public):**

**Web-viewable format:**
```
https://drive.google.com/uc?export=view&id=FILE_ID
```

**Thumbnail (faster, recommended):**
```
https://drive.google.com/thumbnail?id=FILE_ID&sz=w400
```

**Direct download:**
```
https://drive.google.com/uc?export=download&id=FILE_ID
```

### **For Books (Can be private):**

**Via API (temporary URLs):**
```ruby
# Generate temporary download URL via Drive API
# Valid for ~1 hour
# Requires authentication
```

**Or Public (if you want):**
```
https://drive.google.com/uc?export=download&id=FILE_ID
```

---

## 📏 Size Estimates

### **Per Book:**
- Book PDF: 5-50 MB (average 20 MB)
- Cover JPG: 100-200 KB (optimized)

### **Example Libraries:**

**Small (20 books):**
- Books: 20 × 20 MB = 400 MB
- Covers: 20 × 150 KB = 3 MB
- **Total: ~400 MB** ✅ FREE tier

**Medium (50 books):**
- Books: 50 × 20 MB = 1 GB
- Covers: 50 × 150 KB = 7.5 MB
- **Total: ~1 GB** ✅ FREE tier

**Large (200 books):**
- Books: 200 × 20 MB = 4 GB
- Covers: 200 × 150 KB = 30 MB
- **Total: ~4 GB** ✅ FREE tier

**Huge (1000 books):**
- Books: 1000 × 20 MB = 20 GB
- Covers: 1000 × 150 KB = 150 MB
- **Total: ~20 GB** ⚠️ Need $1.99/mo plan (100 GB)

---

## 🎯 Best Practices

### **1. Use Simple Names**
```
✅ Good:
books/1.pdf
books/2.epub

❌ Bad:
books/Architecture & Design (2024) - Author Name [Publisher].pdf
```

### **2. Keep Structure Flat**
```
✅ Good:
books/1.pdf
books/2.pdf

❌ Bad (don't organize by author):
books/Author1/Book1.pdf
books/Author2/Book2.pdf
```

**Why?** Simpler URLs, faster access, easier management.

### **3. Optimize Covers**
```
✅ Good:
- 400px width
- JPG format
- ~100KB file size

❌ Bad:
- 2000px width
- PNG format
- 2MB file size
```

**Our script does this automatically!**

### **4. Public vs Private**
```
✅ Public (safe):
- covers/
- metadata.json

⚠️ Can be public OR private:
- books/ (depends on copyright)
```

---

## 🔐 Access Permissions

### **Recommended Setup:**

**For Public Bookshelf:**
1. Right-click `Bookshelf/covers/` → Share
2. "Anyone with the link" → "Viewer"
3. Right-click `Bookshelf/books/` → Share
4. "Anyone with the link" → "Viewer"

**For Private Bookshelf:**
1. Keep everything private
2. Use Google Drive API for downloads
3. Requires authentication (more complex)

**Our scripts support both!**

---

## 📊 Monitoring Space Usage

### **Check via Rclone:**
```powershell
# See total space used
rclone about bookshelf-drive:

# See size of books folder
rclone size bookshelf-drive:Bookshelf/books/

# See size of covers folder
rclone size bookshelf-drive:Bookshelf/covers/
```

### **Check via Web:**
1. Go to drive.google.com
2. Click ⚙️ (Settings) → "Storage"
3. See total used space

---

## 🧹 Maintenance

### **Regular Tasks:**

**Monthly:**
- Check Drive space usage
- Delete unused book versions
- Verify links still work

**After Major Updates:**
- Run `sync-to-drive.ps1`
- Commit new metadata.json
- Push to Git → Vercel deploys

**When Removing Books:**
1. Delete from Calibre
2. Run `sync-to-drive.ps1` with `--delete` flag
3. Manually delete from Drive (or use sync --delete-excluded)

---

## 🎨 Example: Real Structure

After syncing 10 books, your Drive looks like:

```
Bookshelf/
├── books/
│   ├── 1.pdf          (20.1 MB)
│   ├── 2.epub         (3.2 MB)
│   ├── 3.pdf          (15.8 MB)
│   ├── 4.pdf          (28.4 MB)
│   ├── 5.epub         (2.1 MB)
│   ├── 6.pdf          (12.5 MB)
│   ├── 7.pdf          (35.2 MB)
│   ├── 8.pdf          (18.9 MB)
│   ├── 9.pdf          (22.3 MB)
│   └── 10.pdf         (41.2 MB)
│
├── covers/
│   ├── 1.jpg          (145 KB)
│   ├── 2.jpg          (128 KB)
│   ├── 3.jpg          (156 KB)
│   ├── 4.jpg          (112 KB)
│   ├── 5.jpg          (134 KB)
│   ├── 6.jpg          (98 KB)
│   ├── 7.jpg          (167 KB)
│   ├── 8.jpg          (142 KB)
│   ├── 9.jpg          (103 KB)
│   └── 10.jpg         (121 KB)
│
└── metadata.json      (8 KB)

Total: ~200 MB
```

---

## ✅ Verification Checklist

Before syncing, verify:

- [ ] `Bookshelf/` folder exists
- [ ] `books/` subfolder exists
- [ ] `covers/` subfolder exists
- [ ] You have space available
- [ ] Access permissions set correctly
- [ ] Rclone can access the folders

Test with:
```powershell
rclone ls bookshelf-drive:Bookshelf/
```

---

## 🎉 You're Ready to Sync!

Your Google Drive is properly structured for the bookshelf deployment.

**Next:** Run `sync-to-drive.ps1` to upload your books!

📚✨

