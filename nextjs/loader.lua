-- ============================================
-- NextUI Simple Loader
-- ============================================

local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

-- ===== Configuration =====
-- IMPORTANT: Key system requires HttpService enabled!
-- Roblox Studio: Game Settings → Security → Allow HTTP Requests = ON
-- 
-- If HttpService is NOT enabled, you MUST set UseKeySystem = false

local Config = {
    UseKeySystem = true,  -- Set to FALSE if HttpService is not enabled
    KeyUrl = "https://raw.githubusercontent.com/Sezy0/LIBui/main/key.txt",
    LogoId = "133508780883906",
    DiscordLink = "https://discord.gg/your-invite"
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
