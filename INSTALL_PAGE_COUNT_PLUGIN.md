# 📊 Installing Page Count Plugin for Calibre

## What This Does

The Page Count plugin makes books have **realistic thickness** based on actual page counts!

**Before:** All books roughly the same thickness  
**After:** 
- Thin books (100 pages) = thin spines
- Normal books (300 pages) = medium spines  
- Thick books (800+ pages) = fat spines

**Result:** More realistic bookshelf appearance! 📚

---

## 🚀 Installation Steps

### Step 1: Open Calibre

1. Launch Calibre on your computer
2. Make sure you're viewing your library at `D:\BIBLIO_\calibre`

### Step 2: Access Plugin Manager

**Option A: Via Preferences**
1. Click **Preferences** (gear icon) in toolbar
2. Click **Plugins** under "Advanced"

**Option B: Via Menu**
1. Click **Preferences** menu
2. Select **Get plugins to enhance Calibre**

### Step 3: Get New Plugins

1. In the Plugins window, click **Get new plugins** button (bottom right)
2. Wait for the plugin list to load (may take a few seconds)

### Step 4: Find Count Pages Plugin

1. In the search box, type: **count pages**
2. Look for plugin named: **"Count Pages"**
   - Author: kiwidude
   - Category: Metadata plugins

3. Click on **Count Pages** to select it
4. Click **Install** button
5. Click **Yes** to confirm installation
6. Click **OK** when installation completes

### Step 5: Restart Calibre

**IMPORTANT:** Calibre will ask you to restart. Click **Yes** to restart now.

---

## ⚙️ Configuration Steps

### Step 6: Create Custom Column

**After Calibre restarts:**

1. Go to **Preferences** → **Add your own columns**
   - Or: **Preferences** → **Interface** → **Add your own columns**

2. Click **Add custom column** button (green +)

3. Fill in the fields:

   **Lookup name:** `pagecount`  
   ⚠️ **MUST be exactly "pagecount"** (no spaces, lowercase)
   
   **Column heading:** `Page Count` (or whatever you want to display)
   
   **Column type:** Select **"Integers"** or **"Whole numbers"**
   
   **Format for numbers:** Leave default
   
   **Description:** (optional) "Estimated page count"

4. Click **OK**

5. Click **Apply** then **Close**

### Step 7: Configure Count Pages Plugin

1. Go to **Preferences** → **Plugins**

2. Find **Count Pages** in the list
   - Look under "Metadata plugins" category

3. **Double-click** on Count Pages (or select it and click **Customize plugin**)

4. In the configuration dialog:

   **Store page count in column:** Select `#pagecount` from dropdown
   - The # symbol is automatically added by Calibre
   
   **Words per page:** Leave default (around 390-450)
   
   **Algorithm:** Leave default (usually "Words per page")

5. Click **OK**

6. Click **Apply** then **Close**

---

## 📚 Using the Plugin

### Step 8: Count Pages for Your Books

**For All Books:**
1. Select all books in your library (Ctrl+A)
2. Right-click on the selected books
3. Choose **Edit metadata** → **Download metadata**
4. Or look for **Count Pages** option in right-click menu

**Alternative Method:**
1. Select books
2. Click toolbar: Look for **Count Pages** button (if added to toolbar)
3. Or: Right-click → **Count Pages**

**Individual Book:**
1. Select a book
2. Right-click → **Edit metadata**
3. Right-click → **Count Pages** (in metadata editor)

### Step 9: Verify It Worked

1. Select a book
2. Look at the book details panel (usually on the right)
3. You should see **"Page Count: XXX"** field
4. If you see page counts, it's working! ✅

---

## 🔄 Making Calibre Update Automatically

**Optional: Auto-count on import**

1. Go to **Preferences** → **Plugins** → **Count Pages**
2. Check option: **"Count pages automatically when adding books"**
3. Click **OK**

Now all new books will automatically get page counts!

---

## 📊 Seeing Results in Bookshelf

### Step 10: Restart Bookshelf App

1. Stop your bookshelf server (Ctrl+C in PowerShell)
2. Start it again: `.\run_my_bookshelf.ps1`
3. Refresh your browser: http://localhost:4567

### What You Should See

**Books should now have varied thickness:**

- **Thin books** (100-200 pages) - narrow spines
- **Medium books** (250-400 pages) - normal spines
- **Thick books** (500+ pages) - wide spines
- **Epic tomes** (800+ pages) - very thick spines!

**The app uses this formula:**
```ruby
thickness = [0.85 * (page_count ** 0.6), 8].max
```

So a 300-page book ≈ 26px thick  
And a 800-page book ≈ 45px thick

---

## 🔍 Troubleshooting

### Plugin Not Showing Up

**Solution:**
1. Make sure Calibre fully restarted after installation
2. Check under **Preferences** → **Plugins** → **Metadata plugins**
3. Search for "Count Pages" in the plugin list

### Can't Find "Add Custom Column"

**Solution:**
1. **Preferences** (gear icon)
2. Look for **"Add your own columns"** or **"Interface"** section
3. Should be under "Advanced" category

### Page Counts Not Appearing

**Check:**
1. Custom column is named exactly `pagecount` (no space, lowercase)
2. Column type is "Integer" or "Whole numbers"
3. Plugin is configured to use `#pagecount` column
4. You've actually run "Count Pages" on your books

**Re-run Count Pages:**
1. Select all books (Ctrl+A)
2. Right-click → Look for Count Pages option
3. Wait for it to process all books

### Books Still Same Thickness in Bookshelf

**Check App Code:**

The app checks if page counts exist:

```ruby
def self.has_pages?
  return !@@pagecount_column.nil?
end
```

**Verify in your app:**
1. Stop the server
2. Restart: `.\run_my_bookshelf.ps1`
3. Look for messages about page counts in terminal
4. Refresh browser

**Manual Test:**

Open PowerShell and test:

```powershell
cd D:\BIBLIO_\calibre
sqlite3 metadata.db "SELECT name, label FROM custom_columns"
```

Should show: `pagecount` column

---

## 📖 Complete Example

### Before Plugin:

**Your Calibre Library:**
```
Book 1: "Quick Start Guide" - no page count
Book 2: "Architectural Geometry" - no page count  
Book 3: "Drawing Architecture" - no page count
```

**Bookshelf Display:**
All books ~26px thick (default from formula)

### After Plugin:

**Your Calibre Library:**
```
Book 1: "Quick Start Guide" - 50 pages
Book 2: "Architectural Geometry" - 542 pages
Book 3: "Drawing Architecture" - 324 pages
```

**Bookshelf Display:**
```
Book 1: ~15px thick (thin!)
Book 2: ~40px thick (hefty)
Book 3: ~28px thick (medium)
```

Much more realistic! 📚

---

## 🎯 Quick Reference

### Installation Checklist

- [ ] Open Calibre
- [ ] Preferences → Plugins → Get new plugins
- [ ] Search for "Count Pages"
- [ ] Install plugin
- [ ] Restart Calibre
- [ ] Preferences → Add your own columns
- [ ] Create column: `pagecount`, type: Integer
- [ ] Preferences → Plugins → Count Pages → Customize
- [ ] Set column to: `#pagecount`
- [ ] Select all books
- [ ] Right-click → Count Pages
- [ ] Verify page counts appear in book details
- [ ] Restart bookshelf app
- [ ] Refresh browser and see variable thickness!

---

## 💡 Pro Tips

### 1. **Batch Processing**
Select books by format for better accuracy:
- EPUB files: Very accurate (actual word count)
- PDF files: Less accurate (estimates)
- MOBI files: Accurate

### 2. **Manual Override**
You can manually edit page counts:
1. Right-click book → Edit metadata
2. Find "Page Count" field
3. Enter actual page count from physical book
4. Save

### 3. **Words Per Page Setting**
Default ~390-450 words/page works for most books.

Adjust if needed:
- Academic books: 350 words/page (denser)
- Fiction: 250 words/page (more whitespace)
- Technical books: 400 words/page (standard)

### 4. **Visual Check**
After counting pages, look at your books in Calibre:
- Sort by Page Count column
- Verify numbers make sense
- Fix any obvious errors

---

## 🎨 Expected Results

### Small Books (< 200 pages)
- Novellas
- Short technical guides
- Poetry collections
- **Appearance:** Thin, pamphlet-like

### Medium Books (200-400 pages)
- Most novels
- Standard textbooks
- Business books
- **Appearance:** Normal book thickness

### Large Books (400-800 pages)
- Epic fantasy novels
- Comprehensive guides
- Academic tomes
- **Appearance:** Hefty, substantial

### Massive Books (800+ pages)
- Reference works
- Series compilations
- Encyclopedias
- **Appearance:** Very thick, impressive

---

## 🔗 Plugin Links

**Official Plugin:**
- GitHub: https://github.com/kiwidude68/calibre_plugins/tree/main/count_pages
- Calibre Plugin Index: Search "Count Pages" by kiwidude

**Documentation:**
- Plugin includes built-in help
- Click "Help" button in plugin configuration

---

## ✅ Verification

### How to Know It's Working

**In Calibre:**
1. Select a book
2. Look at book details panel
3. See "Page Count: XXX"

**In Your Bookshelf:**
1. Open http://localhost:4567
2. Look at book spines
3. See varied widths
4. Thick books should be visibly wider than thin books

**In Terminal:**
When server starts, you might see:
```
Found XX book(s) in library
Page count data available
```

---

## 🎊 Summary

The Page Count plugin gives your bookshelf **realistic, varied book thickness** based on actual page counts!

**Installation:** 5 minutes  
**Configuration:** 5 minutes  
**Processing books:** 2-10 minutes (depending on library size)  
**Result:** Professional, realistic bookshelf appearance! 📚✨

After setup, your 3D bookshelf will look even more authentic with books of varying thickness, just like a real bookshelf!

---

## 📞 Need Help?

**Common Issues:**

1. **Column name wrong** → Must be exactly `pagecount`
2. **Column type wrong** → Must be Integer/Whole number
3. **Plugin not configured** → Must point to `#pagecount` column
4. **Haven't run Count Pages** → Must right-click books and count
5. **Server not restarted** → Must restart to pick up new data

**Still stuck?** 
- Check Calibre forums
- Plugin has built-in documentation
- Test with just one book first

---

Enjoy your bookshelf with realistic book thickness! 📚✨

