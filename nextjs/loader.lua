-- ============================================
-- NextUI Simple Loader
-- ============================================

local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

-- ===== Configuration =====
local Config = {
    UseKeySystem = true,  -- true or false
    KeyUrl = "https://pastebin.com/raw/v2BNczLY",  -- Raw URL to key
    LogoId = "133508780883906",  -- Your logo asset ID
    DiscordLink = "https://discord.gg/your-invite"  -- Discord invite link
}
-- ========================

-- Start authentication
NextUI:Auth({
    UseKeySystem = Config.UseKeySystem,
    KeyUrl = Config.KeyUrl,
    LogoId = Config.LogoId,
    DiscordLink = Config.DiscordLink,
    OnSuccess = function()
        -- This runs after successful authentication
        
        -- Create your UI here
        local Window = NextUI:Window({
            Title = "NextUI Library",
            Size = UDim2.new(0, 600, 0, 450)
        })

        local Tab1 = Window:Tab({
            Name = "🏠 Home",
            Icon = nil
        })

        local Section1 = Tab1:Section("Welcome")

        Section1:Label("Welcome to NextUI!")
        Section1:Label("✨ Created by FoxZy")

        Section1:Button({
            Text = "Test Button",
            Callback = function()
                NextUI:Notification("Success", "Button clicked!", 2)
            end
        })

        local Tab2 = Window:Tab({
            Name = "⚙️ Settings",
            Icon = nil
        })

        local Section2 = Tab2:Section("Configuration")

        Section2:Toggle({
            Text = "Example Toggle",
            Default = false,
            Callback = function(value)
                print("Toggle:", value)
            end
        })

        Section2:Slider({
            Text = "Example Slider",
            Min = 0,
            Max = 100,
            Default = 50,
            Callback = function(value)
                print("Slider:", value)
            end
        })
    end
})
