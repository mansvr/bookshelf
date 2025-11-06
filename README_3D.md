# 🎮 3D Interactive Bookshelf

Transform your Calibre library into an immersive 3D experience!

![3D Bookshelf](https://img.shields.io/badge/3D-React%20Three%20Fiber-blue)
![Camera](https://img.shields.io/badge/FOV-21%C2%B0%20Dramatic-red)
![Status](https://img.shields.io/badge/Status-Ready-green)

---

## 🚀 Quick Start

### **Option 1: Easy Start (Recommended)**
```powershell
.\start_3d_bookshelf.ps1
```
Then open **http://localhost:3000** in your browser!

### **Option 2: Manual Start**
```powershell
# Terminal 1 - Ruby Backend
.\run_my_bookshelf.ps1

# Terminal 2 - React Frontend
npm install  # First time only
npm run dev
```

---

## ✨ Features

### 🎥 **Cinematic Camera**
- **21° Field of View** - Dramatic telephoto lens effect
- **Orbit Controls** - Navigate in full 3D
- **Smooth Damping** - Professional camera feel

### 📚 **3D Books**
- **Circular Arrangement** - Books displayed in perfect circle
- **Real Colors** - Extracted from your Calibre library
- **Interactive** - Click to open, hover to preview
- **Dynamic Sizing** - Based on page count and aspect ratio

### 🎨 **Visual Effects**
- **Advanced Lighting** - Directional, spot, and ambient
- **Real-time Shadows** - Dynamic shadow casting
- **Fog** - Atmospheric depth
- **Contact Shadows** - Ground grounding
- **PBR Materials** - Physically based rendering

### 🖱️ **Controls**
- **Drag** - Rotate camera around bookshelf
- **Scroll** - Zoom in and out
- **Click** - Select and view book details
- **Theme Toggle** - Light/dark mode

---

## 📁 What You Have

### **2D Bookshelf (Original)**
- Location: http://localhost:4567
- Classic shelf view
- Flip animations
- Runs: `.\run_my_bookshelf.ps1`

### **3D Bookshelf (New!)**
- Location: http://localhost:3000
- Immersive 3D navigation
- Cinematic camera
- Runs: `.\start_3d_bookshelf.ps1`

**Both work! Choose your style!** 🎨

---

## 🎯 Controls

| Action | Desktop | Mobile |
|--------|---------|--------|
| Rotate View | Click + Drag | One Finger Drag |
| Zoom | Scroll Wheel | Pinch |
| Select Book | Click | Tap |
| View Book | Click "View Book" | Tap "View Book" |
| Toggle Theme | Click Sun/Moon | Tap Sun/Moon |

---

## 🏗️ Technology Stack

- **Frontend:** React 18 + Vite
- **3D Engine:** Three.js + React Three Fiber
- **3D Helpers:** @react-three/drei
- **State:** Zustand
- **Backend:** Ruby + Sinatra
- **Database:** SQLite (Calibre)

---

## 📸 Camera Specifications

```javascript
{
  fov: 21,           // Dramatic narrow field of view
  position: [0, 2, 15],  // Elevated, pulled back
  near: 0.1,
  far: 1000
}
```

**Why 21°?**
- Professional cinematography lens
- Creates compressed, dramatic perspective
- Focuses attention on books
- Similar to high-end product photography

---

## 🎨 Customization

### Change FOV
Edit `src/App.jsx`:
```javascript
fov: 21  // Try 15-35
```

### Change Book Count
Edit `app.rb`:
```ruby
books = CalibreBook.some_books(50)  # 1-100
```

### Change Arrangement
Edit `src/components/Book.jsx`:
```javascript
const radius = 5  // Circle size
```

### Change Colors
Edit `src/components/Bookshelf.jsx`:
```javascript
color="#3d2817"  // Shelf color
```

---

## 📂 Project Structure

```
O:\CURSOR2\BOOKSHELF\
├── src/                      # React 3D frontend
│   ├── components/
│   │   ├── Scene.jsx        # Main 3D scene
│   │   ├── Book.jsx         # 3D book component
│   │   ├── Bookshelf.jsx    # Shelf model
│   │   ├── UI.jsx           # 2D overlay
│   │   └── LoadingScreen.jsx
│   ├── store/
│   │   └── bookStore.js     # State management
│   ├── App.jsx
│   └── main.jsx
├── views/                    # Original 2D frontend
│   └── index.erb
├── public/                   # Static assets
├── app.rb                    # Ruby backend + API
├── calibre.rb               # Database logic
├── package.json             # Node dependencies
├── vite.config.js          # Build config
└── start_3d_bookshelf.ps1  # Easy startup
```

---

## 🔧 Requirements

- ✅ **Ruby 3.3+** (already installed)
- ✅ **ImageMagick** (already configured)
- ✅ **Calibre Library** (already configured)
- ⭐ **Node.js 18+** (install from https://nodejs.org/)

---

## 🐛 Troubleshooting

### White Screen
1. Check both servers are running
2. Open browser console (F12)
3. Look for error messages

### No Books
1. Visit http://localhost:4567/books.json
2. Should see JSON array of books
3. Check Ruby server logs

### Slow Performance
1. Update graphics drivers
2. Try Chrome (best WebGL support)
3. Reduce book count in `app.rb`
4. Close other tabs/applications

### Can't Install Dependencies
```powershell
# Clear cache and reinstall
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json
npm install
```

---

## 📚 Documentation

- **3D_BOOKSHELF_GUIDE.md** - Comprehensive guide
- **RESPONSIVE_DESIGN.md** - Original 2D responsive design
- **THEME_SWITCHER.md** - Theme system docs
- **IMAGEMAGICK_WORKING.md** - Color extraction setup

---

## 🎊 What's Different?

### Original 2D Bookshelf:
- ✅ Side-scrolling shelf
- ✅ Flip animation to see back
- ✅ Classic library feel
- ✅ Simple, fast

### New 3D Bookshelf:
- ⭐ Navigate in 3D space
- ⭐ Cinematic 21° camera
- ⭐ Circular book arrangement
- ⭐ Immersive experience
- ⭐ Modern aesthetic

**Both are awesome! Use whichever you prefer!** 🎨

---

## 🚀 Next Steps

1. **Install Node.js** if not already installed
2. Run `.\start_3d_bookshelf.ps1`
3. Open http://localhost:3000
4. Drag to rotate, scroll to zoom, click books!

---

## 💡 Pro Tips

- **Zoom in close** to see book details
- **Drag slowly** for smooth cinematic movement
- **Click the theme button** to try dark mode
- **Scroll stats** in bottom-right show FPS
- **Use 2D version** for quick browsing
- **Use 3D version** for immersive experience

---

## 📞 Support

Having issues? Check:
1. `3D_BOOKSHELF_GUIDE.md` - Full documentation
2. Browser console (F12) - Error messages
3. Server logs - Backend issues

---

## 🎬 Enjoy Your 3D Library!

Your Calibre collection has been transformed into an immersive 3D experience with a dramatic 21° FOV camera. Navigate, explore, and enjoy! 🚀📚

**Made with React Three Fiber, Three.js, and ❤️**

