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

## 📊 Size Comparison (Rayfield-Inspired)

| Device Type | Window Size | Sidebar Width | Content Width | Font Sizes |
|-------------|-------------|---------------|---------------|------------|
| **Small Mobile** (<600px) | 340 x 500 | 50px | 290px | 8-11px |
| **Mobile** (<1000px) | 380 x 520 | 55px | 325px | 9-12px |
| **Desktop** (≥1000px) | 580 x 475 | 72px | 508px | 11-14px |

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
- ✅ Smaller sidebar (50-72px vs 150px)
- ✅ Reduced font sizes for mobile (8-14px)
- ✅ Ultra-tight spacing (4-6px between elements)
- ✅ Compact buttons (26-32px height vs 38-44px)
- ✅ Minimal padding (6-10px vs 12-16px)
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
isMobile = ViewportSize.X < 1000  -- More aggressive mobile detection
isSmallMobile = ViewportSize.X < 600  -- Extra small screens
```

### Responsive Sizing (Rayfield-Inspired)
```lua
-- Small Mobile (<600px - e.g., 393x851 Android):
WindowWidth = 340px
WindowHeight = 500px
SidebarWidth = 50px
Content = 290px
Topbar = 36px
Fonts = 8-11px

-- Mobile (600-999px - e.g., tablets, landscape phones):
WindowWidth = 380px
WindowHeight = 520px (taller for portrait)
SidebarWidth = 55px
Content = 325px
Topbar = 40px
Fonts = 9-12px

-- Desktop (≥1000px - e.g., 1920x1080):
WindowWidth = 580px (Rayfield 500px + sidebar)
WindowHeight = 475px (same as Rayfield)
SidebarWidth = 72px
Content = 508px (~Rayfield 500px)
Topbar = 45px (same as Rayfield)
Fonts = 11-14px
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
