# 🎨 NextJS Theme - UI Library for Roblox

Modern UI library inspired by Next.js and Vercel design system.

## 🚀 Features

- Clean minimalist design
- Smooth animations
- Responsive components
- Modern color palette
- Production-ready

## 📦 Installation

```lua
-- Load NextJS Theme
local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()
```

## 📖 Usage

```lua
-- Create window
local Window = NextUI:Window({
    Title = "My Script",
    Theme = "dark" -- or "light"
})

-- Create section
local Section = Window:Section("Main")

-- Add button
Section:Button("Click Me", function()
    print("Button clicked!")
end)

-- Add toggle
Section:Toggle("Feature", false, function(value)
    print("Toggle:", value)
end)

-- Add slider
Section:Slider("Speed", {
    Min = 0,
    Max = 100,
    Default = 50
}, function(value)
    print("Slider:", value)
end)
```

## 🎨 Components

- ✅ Window
- ✅ Section
- ✅ Button
- ✅ Toggle
- ✅ Slider
- ✅ Dropdown
- ✅ Input
- ✅ Keybind
- ✅ ColorPicker

## 📄 License

MIT License - Free to use

---

Made with ❤️ by Sezy0
