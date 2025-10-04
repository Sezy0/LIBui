-- ============================================
-- NextUI Example with Key Authentication
-- ============================================

local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

-- ===== Configuration =====
local USE_KEY_SYSTEM = true  -- Set to false to disable key authentication
local KEY_URL = "https://pastebin.com/raw/v2BNczLY"  -- Your key URL (only used if USE_KEY_SYSTEM is true)
local LOGO_ID = "18858617508"  -- Your logo image asset ID
local DISCORD_LINK = "https://discord.gg/your-invite"  -- Your Discord server invite link
-- ========================

-- If key system is disabled, directly create UI
if not USE_KEY_SYSTEM then
    -- Bypass authentication
    NextUI:ValidateKey("bypass", nil)
    
    -- Create Main UI directly
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
    Section1:Label("Key System: Disabled")

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

    return -- Exit script
end

-- Create Key Input GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NextUIKeyAuth"
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.ResetOnSpawn = false
KeyGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Parent = KeyGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 280)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(40, 40, 40)
MainStroke.Thickness = 1
MainStroke.Transparency = 0.7

-- Logo Section (Left Side)
local LogoFrame = Instance.new("Frame")
LogoFrame.Parent = MainFrame
LogoFrame.Position = UDim2.new(0, 20, 0, 20)
LogoFrame.Size = UDim2.new(0, 150, 1, -40)
LogoFrame.BackgroundTransparency = 1

local LogoImage = Instance.new("ImageLabel")
LogoImage.Parent = LogoFrame
LogoImage.AnchorPoint = Vector2.new(0.5, 0.5)
LogoImage.Position = UDim2.new(0.5, 0, 0.35, 0)
LogoImage.Size = UDim2.new(0, 120, 0, 120)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = "rbxassetid://" .. LOGO_ID
LogoImage.ScaleType = Enum.ScaleType.Fit

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 12)
LogoCorner.Parent = LogoImage

local PoweredBy = Instance.new("TextLabel")
PoweredBy.Parent = LogoFrame
PoweredBy.Position = UDim2.new(0, 0, 1, -35)
PoweredBy.Size = UDim2.new(1, 0, 0, 30)
PoweredBy.BackgroundTransparency = 1
PoweredBy.Font = Enum.Font.Gotham
PoweredBy.Text = "Powered by FoxZy"
PoweredBy.TextColor3 = Color3.fromRGB(100, 100, 100)
PoweredBy.TextSize = 11
PoweredBy.TextXAlignment = Enum.TextXAlignment.Center

-- Right Content Section
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 190, 0, 20)
ContentFrame.Size = UDim2.new(0, 290, 1, -40)
ContentFrame.BackgroundTransparency = 1

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = ContentFrame
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "Please enter your key"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Key Input Box
local KeyInput = Instance.new("TextBox")
KeyInput.Parent = ContentFrame
KeyInput.Position = UDim2.new(0, 0, 0, 50)
KeyInput.Size = UDim2.new(1, 0, 0, 45)
KeyInput.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyInput.BorderSizePixel = 0
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter key"
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(245, 245, 245)
KeyInput.TextSize = 14
KeyInput.ClearTextOnFocus = false

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local KeyInputStroke = Instance.new("UIStroke")
KeyInputStroke.Parent = KeyInput
KeyInputStroke.Color = Color3.fromRGB(40, 40, 40)
KeyInputStroke.Thickness = 1
KeyInputStroke.Transparency = 0.5

-- Get Key Button
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Parent = ContentFrame
GetKeyButton.Position = UDim2.new(0, 0, 1, -50)
GetKeyButton.Size = UDim2.new(1, 0, 0, 40)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
GetKeyButton.BorderSizePixel = 0
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.Text = "Get Key"
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.TextSize = 13

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyButton

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Parent = GetKeyButton
GetKeyStroke.Color = Color3.fromRGB(60, 60, 60)
GetKeyStroke.Thickness = 1
GetKeyStroke.Transparency = 0.5

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = ContentFrame
StatusLabel.Position = UDim2.new(0, 0, 0, 105)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Button Hover Effect
GetKeyButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(GetKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
end)

GetKeyButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(GetKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
end)

-- Get Key Button Click (Open Discord)
GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard(DISCORD_LINK)
    StatusLabel.Text = "Discord link copied to clipboard!"
    StatusLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
    wait(2)
    StatusLabel.Text = ""
end)

-- Auto-verify on text change
local verifying = false
KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local inputKey = KeyInput.Text
    if inputKey == "" or verifying then return end
    
    -- Auto-verify when key length is reasonable (e.g., 3+ characters)
    if #inputKey >= 3 then
        verifying = true
        StatusLabel.Text = "Verifying..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
        
        task.wait(0.3)
        
        local success = NextUI:ValidateKey(inputKey, KEY_URL)
        
        if success then
            StatusLabel.Text = "Key verified! Loading..."
            StatusLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
            
            task.wait(1)
            KeyGui:Destroy()
            
            -- Create Main UI
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
        else
            StatusLabel.Text = "Invalid key"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            KeyInput.Text = ""
        end
        
        verifying = false
    end
end)
