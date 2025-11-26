# 🎨 UI Polish - Background Images

## 📋 **Requested:**

Add `Kuwaiti.jpg` and `saudi.jpg` as backgrounds for:
- Analytics Dashboard → Use `Kuwaiti.jpg`
- Match History Page → Use `saudi.jpg`
- Page transitions → Polish white backgrounds

## 📁 **Images Location:**
- ✅ `assets/images/Kuwaiti.jpg` - Available
- ✅ `assets/images/saudi.jpg` - Available

## 🔧 **Implementation:**

The backgrounds should be added as:
```dart
Stack(
  children: [
    // Background image
    Positioned.fill(
      child: Opacity(
        opacity: 0.08-0.1,
        child: Image.asset(
          'assets/images/Kuwaiti.jpg',
          fit: BoxFit.cover,
        ),
      ),
    ),
    // Main content
    Scaffold(
      backgroundColor: Colors.transparent,
      // ... rest of screen
    ),
  ],
)
```

## ⏳ **Status:**
**Not implemented yet** - Ran into syntax nesting issues

**Can be added later** once Arabic translation is fixed

## ✅ **Priority:**
Low - Visual enhancement, not functional requirement

---

**Note:** App works perfectly without these backgrounds. This is pure polish.

