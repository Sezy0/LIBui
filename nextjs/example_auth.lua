-- ============================================
-- NextUI Example with Key Authentication
-- ============================================

local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

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
MainFrame.Size = UDim2.new(0, 400, 0, 250)
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

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "🔐 NextUI Authentication"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 18

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = MainFrame
Subtitle.Position = UDim2.new(0, 0, 0, 55)
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Enter your access key to continue"
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 160)
Subtitle.TextSize = 12

-- Key Input Box
local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.Position = UDim2.new(0.5, 0, 0.5, -10)
KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInput.Size = UDim2.new(0, 320, 0, 45)
KeyInput.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyInput.BorderSizePixel = 0
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter key here..."
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

-- Submit Button
local SubmitButton = Instance.new("TextButton")
SubmitButton.Parent = MainFrame
SubmitButton.Position = UDim2.new(0.5, 0, 0, 170)
SubmitButton.AnchorPoint = Vector2.new(0.5, 0)
SubmitButton.Size = UDim2.new(0, 320, 0, 45)
SubmitButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SubmitButton.BorderSizePixel = 0
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.Text = "Verify Key"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.TextSize = 14

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitButton

local SubmitStroke = Instance.new("UIStroke")
SubmitStroke.Parent = SubmitButton
SubmitStroke.Color = Color3.fromRGB(60, 60, 60)
SubmitStroke.Thickness = 1
SubmitStroke.Transparency = 0.5

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.Position = UDim2.new(0, 0, 1, -30)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
StatusLabel.TextSize = 11

-- Button Hover Effect
SubmitButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(SubmitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
end)

SubmitButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(SubmitButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
end)

-- Verify Key Function
local function verifyKey()
    local inputKey = KeyInput.Text
    if inputKey == "" then
        StatusLabel.Text = "❌ Please enter a key"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end

    StatusLabel.Text = "⏳ Verifying key..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
    SubmitButton.Text = "Verifying..."

    wait(0.5)

    local success = NextUI:ValidateKey(inputKey)
    
    if success then
        StatusLabel.Text = "✅ Key verified! Loading UI..."
        StatusLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
        SubmitButton.Text = "Success!"
        
        wait(1)
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
        StatusLabel.Text = "❌ Invalid key! Please try again"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        SubmitButton.Text = "Verify Key"
        KeyInput.Text = ""
    end
end

-- Button Click
SubmitButton.MouseButton1Click:Connect(verifyKey)

-- Enter Key Press
KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        verifyKey()
    end
end)
