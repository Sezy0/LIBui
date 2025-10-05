# 📱 NextUI Mobile Compact

**Optimized UI Library for Mobile + Desktop Compatible**

A lightweight, responsive version of NextUI specifically designed for mobile devices while maintaining full desktop compatibility.

## ✨ Features

- 📱 **Mobile-First Design** - Optimized for small screens
- 💻 **Desktop Compatible** - Works perfectly on Windows/Mac
- 🎯 **Smart Detection** - Auto-detects device based on viewport
- 🎨 **Compact Layout** - Efficient use of screen space
- ⚡ **Lightweight** - Smaller file size, faster loading
- 📏 **Responsive Sizing** - Adapts to any screen size
- 🖱️ **Touch Support** - Full touch and mouse support

## 📊 Size Comparison

| Device Type | Window Size | Sidebar Width | Font Sizes |
|-------------|-------------|---------------|------------|
| **Small Mobile** (<480px) | 92% x 70% | 65px | 8-11px |
| **Mobile** (<768px) | 92% x 70% | 75px | 9-12px |
| **Desktop** (≥768px) | 550x420 | 140px | 12-15px |

## 🚀 Quick Start

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs_mobile_compact/init.lua"))()
```

## 📖 Basic Usage

```lua
local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs_mobile_compact/init.lua"))()

-- Bypass auth (no key system)
NextUI:Auth({
    UseKeySystem = false,
    OnSuccess = function()
        local Window = NextUI:Window({
            Title = "My Mobile UI"
        })
        
        local Tab = Window:Tab("Main")
        local Section = Tab:Section("Features")
        
        Section:Button("Click Me", function()
            print("Button clicked!")
        end)
        
        Section:Toggle("Enable Feature", false, function(value)
            print("Toggle:", value)
        end)
        
        Section:Label("This is a label")
    end
})
```

## 🎯 Key Differences from Standard NextUI

### Compact Features:
- ✅ Smaller sidebar (65-75px vs 150px)
- ✅ Reduced font sizes for mobile
- ✅ Tighter spacing and padding
- ✅ Simplified components (no slider, dropdown, input)
- ✅ Auto viewport-based sizing
- ✅ Touch-optimized interactions

### What's Included:
- Window
- Tabs
- Sections
- Buttons
- Toggles
- Labels
- Notifications

### What's Excluded (for compactness):
- ❌ Sliders
- ❌ Dropdowns
- ❌ Input boxes
- ❌ Settings panel
- ❌ Profile section
- ❌ Home bar
- ❌ Version labels
- ❌ Icons

## 📱 Mobile Optimization

### Viewport Detection
```lua
-- Auto-detects based on screen width:
isMobile = ViewportSize.X < 768
isSmallMobile = ViewportSize.X < 480
```

### Responsive Sizing
```lua
-- Mobile (example: 393x851 Android):
WindowWidth = 361px (92% of 393)
WindowHeight = 595px (70% of 851)
SidebarWidth = 75px
Fonts = 9-12px

-- Desktop (example: 1920x1080):
WindowWidth = 550px
WindowHeight = 420px
SidebarWidth = 140px
Fonts = 12-15px
```

## 🎨 API Reference

### Window
```lua
local Window = NextUI:Window({
    Title = "Window Title"  -- Required
})
```

### Tab
```lua
local Tab = Window:Tab("Tab Name")
```

### Section
```lua
local Section = Tab:Section("Section Title")
```

### Button
```lua
Section:Button("Button Text", function()
    -- Your code here
end)
```

### Toggle
```lua
Section:Toggle("Toggle Text", false, function(value)
    print("Toggle is now:", value)
end)
```

### Label
```lua
Section:Label("Label text")
```

### Notification
```lua
NextUI:Notification("Title", "Message", 3)  -- duration in seconds
```

## 🔒 Key System

```lua
NextUI:Auth({
    UseKeySystem = true,  -- Enable key system
    KeyUrl = "https://raw.githubusercontent.com/your-repo/key.txt",
    DiscordLink = "https://discord.gg/your-invite",
    OnSuccess = function()
        -- Create UI here
    end
})
```

## 💡 Best Practices for Mobile

1. **Keep text short** - Limited screen space
2. **Use icons wisely** - Skip if not essential
3. **Limit tabs** - 3-5 tabs maximum
4. **Compact sections** - Group related items
5. **Test on device** - Always test on actual mobile

## 🐛 Troubleshooting

### UI too large on mobile?
- Library auto-detects viewport size
- Check if ViewportSize is correctly reported
- Try refreshing/rejoining the game

### Text too small?
- This is optimized for mobile readability
- Fonts are responsive based on device

### Touch not working?
- Make sure executor supports touch input
- Some executors have touch input bugs

## 📦 File Size

- **init.lua**: ~36KB (vs 71KB standard)
- **50% smaller** than full version
- Faster load times on mobile

## 🔄 Updates

This is a simplified, mobile-optimized version. For full features, use the standard NextUI version.

## 📄 License

MIT License - Free to use

---

Made with ❤️ for mobile users by Sezy0
