-- Simple test to check if script executes
print("========================================")
print("[TEST] Script is executing!")
print("[TEST] Player:", game.Players.LocalPlayer.Name)
print("========================================")

-- Try to create a simple UI
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

print("[TEST] Creating ScreenGui...")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TestUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

print("[TEST] ScreenGui created!")

-- Create a simple frame
local Frame = Instance.new("Frame")
Frame.Name = "TestFrame"
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

print("[TEST] Frame created!")

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Frame

-- Add text
local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "✅ UI WORKS!\n\nIf you see this,\nthe executor is working!"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 16

print("[TEST] TextLabel created!")

-- Add close button
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Frame
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Position = UDim2.new(1, -10, 0, 10)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[TEST] UI closed!")
end)

print("[TEST] Close button created!")
print("========================================")
print("[TEST] ✅ ALL DONE! UI should be visible!")
print("========================================")
