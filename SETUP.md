# NextUI Setup Guide

## 🔐 Key System Requirements

To use the key authentication system, **HttpService must be enabled** in your Roblox game.

### Enable HttpService (Roblox Studio):

1. Open your game in **Roblox Studio**
2. Go to **Home** → **Game Settings** (or press Alt+S)
3. Navigate to **Security** tab
4. ✅ Enable **"Allow HTTP Requests"**
5. Click **Save**

### Testing Without HttpService:

If you're testing in a game where you cannot enable HttpService, set:

```lua
UseKeySystem = false  -- Bypass authentication
```

## 📋 Configuration

```lua
local Config = {
    UseKeySystem = true,  -- Set to false to bypass auth
    KeyUrl = "https://raw.githubusercontent.com/Sezy0/LIBui/main/key.txt",
    LogoId = "133508780883906",
    DiscordLink = "https://discord.gg/your-invite"
}
```

## 🔑 Default Key

The default key is: **`hai`**

You can change this by editing `key.txt` in the repository or using your own key URL.

## ⚠️ Common Issues

### "Failed to fetch key" Error
- **Cause:** HttpService is not enabled
- **Fix:** Enable HttpService in game settings (see above)

### "HTTP requests not enabled" Error
- **Cause:** Game settings don't allow HTTP requests
- **Fix:** Enable in Security settings or set `UseKeySystem = false`

## 🚀 Quick Start

**With Key System:**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/loader.lua"))()
```

**Without Key System (Direct):**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/example.lua"))()
```

## 📞 Support

Need help? Join our Discord: [Your Discord Link]
