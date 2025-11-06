# 📊 Page Count Plugin - Quick Guide

## 🎯 What You Get

**Variable book thickness** based on real page counts!
- Thin books = narrow spines
- Thick books = wide spines
- Just like a real bookshelf!

---

## ⚡ 5-Minute Setup

### 1. Install Plugin in Calibre

```
Calibre → Preferences → Plugins → Get new plugins
→ Search "Count Pages"
→ Install
→ Restart Calibre
```

### 2. Create Custom Column

```
Preferences → Add your own columns → Add custom column

Lookup name: pagecount  ⚠️ EXACTLY this, lowercase, no space
Column heading: Page Count
Column type: Integer/Whole numbers
→ OK → Apply
```

### 3. Configure Plugin

```
Preferences → Plugins → Count Pages → Customize plugin

Store page count in column: #pagecount
→ OK → Apply
```

### 4. Count Your Books

```
Select all books (Ctrl+A)
Right-click → Count Pages
Wait for processing...
```

### 5. Restart Bookshelf

```powershell
# Stop server (Ctrl+C)
.\run_my_bookshelf.ps1
# Refresh browser: http://localhost:4567
```

---

## ✅ Verify It Works

### In Calibre:
- Select a book
- Look for "Page Count: XXX" in book details

### In Bookshelf:
- Books have different spine widths
- Big books noticeably thicker than small books

---

## 🔍 Troubleshooting

| Problem | Solution |
|---------|----------|
| Plugin not showing | Restart Calibre completely |
| No page counts | Run Count Pages on selected books |
| Custom column missing | Name must be exactly `pagecount` |
| Same thickness still | Restart bookshelf server |
| Column type wrong | Must be Integer/Whole numbers |

---

## 📏 Example Results

**Before:**
```
All books: ≈ 26px thick (default)
```

**After with page counts:**
```
50 pages   → ~15px (pamphlet)
200 pages  → ~23px (thin)
300 pages  → ~26px (normal)
500 pages  → ~35px (thick)
800 pages  → ~45px (tome!)
```

---

## 💡 Key Points

1. **Column name MUST be** `pagecount` (exact, lowercase, no space)
2. **Column type MUST be** Integer or Whole numbers
3. **Must run** Count Pages on your books (doesn't happen automatically unless configured)
4. **Must restart** bookshelf server to see changes
5. Works with EPUB best, PDF estimates, all formats supported

---

## 🎨 Visual Difference

**Without Page Counts:**
```
| Book | Book | Book | Book | Book |
  ║      ║      ║      ║      ║
Same   Same   Same   Same   Same
```

**With Page Counts:**
```
| Book | Book | Book | Book | Book |
  ║       ║║      ║       ║║║     ║
Thin  Normal  Thin   Thick  Normal
```

Much more realistic and professional! 📚✨

---

## 🚀 Quick Test

**Test on ONE book first:**

1. In Calibre, select one book
2. Right-click → Count Pages
3. Check if "Page Count" field appears
4. If yes, continue with all books
5. If no, check column name and plugin config

---

## ⏱️ Time Investment

- **Setup:** 5 minutes
- **Count 100 books:** 2-5 minutes
- **Count 1000 books:** 10-20 minutes
- **Result:** Lifetime of realistic bookshelf! 📚

---

## 📖 Full Documentation

See **INSTALL_PAGE_COUNT_PLUGIN.md** for complete step-by-step instructions with screenshots descriptions and advanced configuration.

---

## ✨ Bottom Line

This small plugin makes a **BIG visual difference**!

Your bookshelf will look much more authentic with varied book thickness based on actual page counts.

**Totally worth the 5 minutes to set up!** 🎉

