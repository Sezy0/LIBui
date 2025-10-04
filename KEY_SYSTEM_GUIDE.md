# NextUI Key System Guide

## Overview
NextUI menggunakan **Rayfield-style key validation** untuk authentication system yang robust dan reliable.

---

## ⚙️ How It Works

### Key Fetching & Validation
1. Library fetch key dari URL menggunakan `game:HttpGet()`
2. Remove semua **newlines** (`\n`, `\r`) dan **spaces**
3. Compare **strictly** (exact match) dengan user input

### Key Processing Pipeline
```lua
-- Step 1: Fetch dari URL
raw_key = game:HttpGet("https://raw.githubusercontent.com/yourrepo/key.txt")
-- Output: "hai\n" atau "hai \n"

-- Step 2: Replace newlines dengan space
processed = raw_key:gsub("[\n\r]", " ")
-- Output: "hai " atau "hai  "

-- Step 3: Remove semua spaces
final_key = processed:gsub(" ", "")
-- Output: "hai"

-- Step 4: Strict comparison
if user_input == final_key then
    -- Authenticated!
end
```

---

## 📝 Usage Examples

### Basic Usage (dengan Key System)
```lua
local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

NextUI:Auth({
    UseKeySystem = true,
    KeyUrl = "https://raw.githubusercontent.com/Sezy0/LIBui/main/key.txt",
    LogoId = "133508780883906",
    DiscordLink = "https://discord.gg/your-server",
    OnSuccess = function()
        -- This runs after successful authentication
        local Window = NextUI:Window({
            Title = "My Hub",
            Size = UDim2.new(0, 600, 0, 450)
        })
        
        local Tab = Window:Tab({Name = "Home"})
        local Section = Tab:Section("Welcome")
        Section:Label("You're authenticated!")
    end
})
```

### Without Key System (Bypass)
```lua
local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

NextUI:Auth({
    UseKeySystem = false,  -- Disable key system
    OnSuccess = function()
        -- Create your UI directly
        local Window = NextUI:Window({Title = "My Hub"})
        -- ... rest of your code
    end
})
```

---

## 🔑 Key Format Requirements

### ✅ Valid Key Format
Your key file should contain **ONLY the key string**, no extra whitespace:

**Example `key.txt`:**
```
hai
```

or

```
mySecretKey123
```

### ❌ Invalid Formats
```
hai 

```
(extra newlines at end - will still work but not recommended)

```
key: hai
```
(prefixes will break validation)

---

## 🛠️ Testing Your Key System

### Step 1: Enable HTTP Requests
**In Roblox Studio:**
1. Go to **Game Settings** (Home → Game Settings)
2. Navigate to **Security** tab
3. Enable **"Allow HTTP Requests"** ✅

### Step 2: Create Your Key File
1. Create a text file with your key (e.g., `hai`)
2. Upload to GitHub/Pastebin as **RAW text**
3. Get the raw URL (e.g., `https://raw.githubusercontent.com/user/repo/main/key.txt`)

### Step 3: Test Authentication
```lua
-- Test with correct key
KeyUrl = "https://raw.githubusercontent.com/Sezy0/LIBui/main/key.txt"
-- User should enter: hai

-- Test with wrong key
-- User enters: wrong123
-- Result: "Invalid key! Please try again"
```

---

## 🐛 Common Issues & Solutions

### Issue: "HttpService.HttpEnabled = false"
**Solution:**
```
Game Settings → Security → Allow HTTP Requests = ON
```

### Issue: "Failed to fetch key from URL"
**Possible causes:**
1. URL is blocked by firewall/network
2. GitHub/hosting service is down
3. URL typo or incorrect raw URL format

**Solution:**
- Test URL in browser first
- Use raw URLs (not HTML pages)
- Check executor's HTTP capabilities

### Issue: "Key verified but nothing happens"
**Solution:**
Make sure your `OnSuccess` callback is defined:
```lua
NextUI:Auth({
    UseKeySystem = true,
    KeyUrl = "...",
    OnSuccess = function()
        -- ADD YOUR CODE HERE
        print("Authenticated!")
    end
})
```

---

## 🔒 Security Best Practices

### 1. Use Dynamic Keys
```lua
-- Fetch key from your server at runtime
KeyUrl = "https://yourserver.com/api/getkey?hwid=" .. game:GetService("RbxAnalyticsService"):GetClientId()
```

### 2. Implement Key Expiration
```lua
-- key.txt format: "mykey|2025-12-31"
-- Parse and validate expiration date server-side
```

### 3. Rate Limiting
Consider implementing rate limiting on your key server to prevent brute force attacks.

---

## 📚 API Reference

### NextUI:Auth(config)
Creates authentication UI and validates key.

**Parameters:**
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `UseKeySystem` | boolean | No | true | Enable/disable key authentication |
| `KeyUrl` | string | Yes* | "" | URL to fetch valid key from |
| `LogoId` | string | No | "133508780883906" | Roblox asset ID for logo |
| `DiscordLink` | string | No | "https://discord.gg/your-invite" | Discord invite link |
| `OnSuccess` | function | No | function() end | Callback after successful auth |

*Required if `UseKeySystem = true`

**Example:**
```lua
NextUI:Auth({
    UseKeySystem = true,
    KeyUrl = "https://raw.githubusercontent.com/user/repo/main/key.txt",
    LogoId = "18858617508",
    DiscordLink = "https://discord.gg/ABC123",
    OnSuccess = function()
        print("User authenticated!")
    end
})
```

### NextUI:ValidateKey(inputKey, keyUrl)
Manually validate a key (advanced usage).

**Parameters:**
- `inputKey` (string): User's input key
- `keyUrl` (string): URL to fetch valid key from (use `nil` for bypass)

**Returns:**
- `boolean`: `true` if key is valid, `false` otherwise

**Example:**
```lua
local isValid = NextUI:ValidateKey("hai", "https://raw.githubusercontent.com/Sezy0/LIBui/main/key.txt")
if isValid then
    print("Key is valid!")
else
    print("Invalid key!")
end
```

---

## 🎯 Migration from Old System

If you're updating from the old NextUI key system:

### Old Code:
```lua
-- This still works but uses old validation
NextUI:Auth({
    UseKeySystem = true,
    KeyUrl = "...",
    OnSuccess = function() end
})
```

### Changes:
- ✅ **No code changes needed!**
- ✅ API remains the same
- ✅ Internal validation now uses Rayfield approach
- ✅ More reliable with `game:HttpGet()`
- ✅ Better whitespace/newline handling

---

## 📞 Support

- **Discord:** Your server invite
- **Documentation:** https://github.com/Sezy0/LIBui
- **Issues:** https://github.com/Sezy0/LIBui/issues
