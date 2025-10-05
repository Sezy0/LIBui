-- ============================================
-- NextJS Mobile Compact UI Library
-- Optimized for Mobile + Desktop Compatible
-- ============================================

local NextUI = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Detect device type based on viewport
local Camera = workspace.CurrentCamera
local ViewportSize = Camera.ViewportSize
local isMobile = ViewportSize.X < 1000 -- Mobile if width < 1000px (more aggressive)
local isSmallMobile = ViewportSize.X < 600 -- Extra small mobile


-- Theme Colors (Monochrome Grayscale)
local Theme = {
    Background = Color3.fromRGB(10, 10, 10),
    Surface = Color3.fromRGB(18, 18, 18),
    SurfaceHover = Color3.fromRGB(25, 25, 25),
    Border = Color3.fromRGB(40, 40, 40),
    Text = Color3.fromRGB(245, 245, 245),
    TextSecondary = Color3.fromRGB(160, 160, 160),
    TextTertiary = Color3.fromRGB(100, 100, 100),
    Accent = Color3.fromRGB(255, 255, 255),
    AccentDim = Color3.fromRGB(200, 200, 200),
    Success = Color3.fromRGB(80, 200, 120),
    Warning = Color3.fromRGB(255, 200, 80),
    Error = Color3.fromRGB(255, 80, 80),
    Shadow = Color3.fromRGB(0, 0, 0),
}

-- Responsive sizes based on device (SQUARE FOR MOBILE!)
local Sizes = {
    -- Window sizes (SQUARE on mobile - width = height!)
    -- Desktop: 580x475 (Sidebar 72px + Content 508px) - Rayfield-inspired
    -- Mobile: 300x300 (Sidebar 80px + Content 220px) - PERFECT SQUARE!
    -- Small Mobile: 280x280 (Sidebar 70px + Content 210px) - MINI SQUARE
    WindowWidth = isSmallMobile and 280 or (isMobile and 300 or 580),
    WindowHeight = isSmallMobile and 280 or (isMobile and 300 or 475),
    
    -- Sidebar (BIGGER for better visibility!)
    SidebarWidth = isSmallMobile and 70 or (isMobile and 80 or 72),
    
    -- Topbar height (smaller!)
    TopbarHeight = isSmallMobile and 32 or (isMobile and 34 or 45),
    
    -- Fonts (MUCH smaller for mobile!)
    TitleFont = isSmallMobile and 10 or (isMobile and 11 or 14),
    SectionFont = isSmallMobile and 9 or (isMobile and 10 or 13),
    TabFont = isSmallMobile and 7 or (isMobile and 8 or 11),
    ButtonFont = isSmallMobile and 9 or (isMobile and 10 or 12),
    LabelFont = isSmallMobile and 8 or (isMobile and 9 or 11),
    
    -- Spacing (ULTRA compact for mobile!)
    Padding = isSmallMobile and 5 or (isMobile and 6 or 10),
    ButtonHeight = isSmallMobile and 24 or (isMobile and 26 or 32),
    SectionSpacing = isSmallMobile and 5 or (isMobile and 6 or 12),
    ElementSpacing = isSmallMobile and 3 or (isMobile and 4 or 6),
}


-- Utility: Make draggable
local function MakeDraggable(frame, dragArea)
    local dragging = false
    local dragInput, dragStart, startPos

    dragArea = dragArea or frame

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Utility: Smooth tween
local function Tween(object, properties, duration)
    duration = duration or 0.2
    TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    ):Play()
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NextUIMobile"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local success = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)

if not success then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- Authentication System
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local authenticated = false
local authKey = ""

function NextUI:ValidateKey(inputKey, keyUrl)
    if keyUrl == nil then
        authenticated = true
        authKey = "bypass"
        return true
    end

    local validKey = ""
    local success, response = pcall(function()
        return tostring(game:HttpGet(keyUrl):gsub("[\n\r]", " "))
    end)

    if not success then
        warn("[NextUI Mobile] Failed to fetch key")
        return false
    end

    validKey = string.gsub(response, " ", "")

    if inputKey == validKey then
        authenticated = true
        authKey = inputKey
        return true
    end

    return false
end

function NextUI:IsAuthenticated()
    return authenticated
end

-- Authentication UI
function NextUI:Auth(config)
    config = config or {}
    local useKeySystem = config.UseKeySystem ~= false
    local keyUrl = config.KeyUrl or ""
    local logoId = config.LogoId or "133508780883906"
    local discordLink = config.DiscordLink or "https://discord.gg/your-invite"
    local onSuccess = config.OnSuccess or function() end

    if not useKeySystem then
        NextUI:ValidateKey("bypass", nil)
        onSuccess()
        return
    end

    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "NextUIMobileKeyAuth"
    KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeyGui.ResetOnSpawn = false
    KeyGui.Parent = PlayerGui

    -- Auth frame size (compact for mobile)
    local authWidth = isMobile and math.floor(ViewportSize.X * 0.70) or 450
    local authHeight = isMobile and math.floor(ViewportSize.Y * 0.45) or 280

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = KeyGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, authWidth, 0, authHeight)
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

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = MainFrame
    CloseButton.AnchorPoint = Vector2.new(1, 0)
    CloseButton.Position = UDim2.new(1, -8, 0, 8)
    CloseButton.Size = UDim2.new(0, isMobile and 28 or 30, 0, isMobile and 28 or 30)
    CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    CloseButton.BorderSizePixel = 0
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseButton.TextSize = isMobile and 16 or 18
    CloseButton.ZIndex = 10

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton

    CloseButton.MouseButton1Click:Connect(function()
        KeyGui:Destroy()
    end)

    -- Content (center everything on mobile)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.Position = UDim2.new(0, Sizes.Padding * 2, 0, Sizes.Padding * 3)
    ContentFrame.Size = UDim2.new(1, -Sizes.Padding * 4, 1, -Sizes.Padding * 6)
    ContentFrame.BackgroundTransparency = 1

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Parent = ContentFrame
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Enter Your Key"
    Title.TextColor3 = Theme.Text
    Title.TextSize = Sizes.TitleFont
    Title.TextXAlignment = Enum.TextXAlignment.Center

    -- Key Input
    local KeyInput = Instance.new("TextBox")
    KeyInput.Parent = ContentFrame
    KeyInput.Position = UDim2.new(0, 0, 0, isMobile and 40 or 45)
    KeyInput.Size = UDim2.new(1, 0, 0, isMobile and 38 or 42)
    KeyInput.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    KeyInput.BorderSizePixel = 0
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderText = "Enter key"
    KeyInput.PlaceholderColor3 = Theme.TextTertiary
    KeyInput.Text = ""
    KeyInput.TextColor3 = Theme.Text
    KeyInput.TextSize = Sizes.ButtonFont
    KeyInput.ClearTextOnFocus = false

    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 8)
    KeyInputCorner.Parent = KeyInput

    -- Verify Button
    local VerifyButton = Instance.new("TextButton")
    VerifyButton.Parent = ContentFrame
    VerifyButton.Position = UDim2.new(0, 0, 0, isMobile and 92 or 102)
    VerifyButton.Size = UDim2.new(1, 0, 0, isMobile and 36 or 38)
    VerifyButton.BackgroundColor3 = Theme.Success
    VerifyButton.BorderSizePixel = 0
    VerifyButton.Font = Enum.Font.GothamBold
    VerifyButton.Text = "Verify"
    VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    VerifyButton.TextSize = Sizes.ButtonFont

    local VerifyCorner = Instance.new("UICorner")
    VerifyCorner.CornerRadius = UDim.new(0, 8)
    VerifyCorner.Parent = VerifyButton

    -- Get Key Button
    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Parent = ContentFrame
    GetKeyButton.Position = UDim2.new(0, 0, 1, isMobile and -40 or -42)
    GetKeyButton.Size = UDim2.new(1, 0, 0, isMobile and 36 or 38)
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    GetKeyButton.BorderSizePixel = 0
    GetKeyButton.Font = Enum.Font.GothamBold
    GetKeyButton.Text = "Get Key"
    GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton.TextSize = Sizes.ButtonFont

    local GetKeyCorner = Instance.new("UICorner")
    GetKeyCorner.CornerRadius = UDim.new(0, 8)
    GetKeyCorner.Parent = GetKeyButton

    -- Status Label
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Parent = ContentFrame
    StatusLabel.Position = UDim2.new(0, 0, 0, isMobile and 140 or 150)
    StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Theme.TextSecondary
    StatusLabel.TextSize = Sizes.LabelFont
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- Get Key Click
    GetKeyButton.MouseButton1Click:Connect(function()
        setclipboard(discordLink)
        StatusLabel.Text = "Link copied!"
        StatusLabel.TextColor3 = Theme.Success
        task.wait(2)
        StatusLabel.Text = ""
    end)

    -- Verify Click
    local verifying = false
    VerifyButton.MouseButton1Click:Connect(function()
        if verifying then return end
        
        local inputKey = KeyInput.Text
        if inputKey == "" then
            StatusLabel.Text = "Please enter a key"
            StatusLabel.TextColor3 = Theme.Error
            return
        end
        
        verifying = true
        VerifyButton.Text = "Verifying..."
        StatusLabel.Text = "Verifying..."
        StatusLabel.TextColor3 = Theme.Warning
        
        task.wait(0.5)
        
        local success = NextUI:ValidateKey(inputKey, keyUrl)
        
        if success then
            StatusLabel.Text = "Success! Loading..."
            StatusLabel.TextColor3 = Theme.Success
            VerifyButton.Text = "Success!"
            
            task.wait(1)
            KeyGui:Destroy()
            onSuccess()
        else
            StatusLabel.Text = "Invalid key!"
            StatusLabel.TextColor3 = Theme.Error
            VerifyButton.Text = "Verify"
            KeyInput.Text = ""
        end
        
        verifying = false
    end)
end

-- Main Window Function
function NextUI:Window(config)
    if not authenticated then
        error("[NextUI Mobile] Authentication required!")
        return nil
    end

    config = config or {}
    local windowTitle = config.Title or "NextUI Mobile"

    -- Main Container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, Sizes.WindowWidth, 0, Sizes.WindowHeight)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = MainFrame

    local BorderGlow = Instance.new("UIStroke")
    BorderGlow.Parent = MainFrame
    BorderGlow.Color = Theme.Border
    BorderGlow.Thickness = 1
    BorderGlow.Transparency = 0.7

    -- Header
    local headerHeight = isMobile and 40 or 45
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.Size = UDim2.new(1, 0, 0, headerHeight)
    Header.BackgroundColor3 = Theme.Surface
    Header.BorderSizePixel = 0

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 10)
    HeaderCorner.Parent = Header

    local HeaderCover = Instance.new("Frame")
    HeaderCover.Parent = Header
    HeaderCover.Position = UDim2.new(0, 0, 0.5, 0)
    HeaderCover.Size = UDim2.new(1, 0, 0.5, 0)
    HeaderCover.BackgroundColor3 = Theme.Surface
    HeaderCover.BorderSizePixel = 0

    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Parent = Header
    TitleLabel.Position = UDim2.new(0, Sizes.Padding, 0, 0)
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = windowTitle
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = Sizes.TitleFont
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Minimize Button
    local closeBtnSize = isMobile and 24 or 28
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = Header
    MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
    MinimizeButton.Position = UDim2.new(1, -Sizes.Padding - closeBtnSize - 6, 0.5, 0)
    MinimizeButton.Size = UDim2.new(0, closeBtnSize, 0, closeBtnSize)
    MinimizeButton.BackgroundColor3 = Theme.SurfaceHover
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "─"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextColor3 = Theme.TextSecondary
    MinimizeButton.TextSize = Sizes.TitleFont

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 6)
    MinimizeCorner.Parent = MinimizeButton

    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Theme.Border})
        Tween(MinimizeButton, {TextColor3 = Theme.Accent})
    end)

    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Theme.SurfaceHover})
        Tween(MinimizeButton, {TextColor3 = Theme.TextSecondary})
    end)

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Header
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.Position = UDim2.new(1, -Sizes.Padding, 0.5, 0)
    CloseButton.Size = UDim2.new(0, closeBtnSize, 0, closeBtnSize)
    CloseButton.BackgroundColor3 = Theme.SurfaceHover
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextColor3 = Theme.TextSecondary
    CloseButton.TextSize = Sizes.TitleFont + 2

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton

    CloseButton.MouseEnter:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Theme.Error})
        Tween(CloseButton, {TextColor3 = Theme.Accent})
    end)

    CloseButton.MouseLeave:Connect(function()
        Tween(CloseButton, {BackgroundColor3 = Theme.SurfaceHover})
        Tween(CloseButton, {TextColor3 = Theme.TextSecondary})
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Floating Restore Button (hidden by default)
    local RestoreButton = Instance.new("ImageButton")
    RestoreButton.Name = "RestoreButton"
    RestoreButton.Parent = ScreenGui
    RestoreButton.AnchorPoint = Vector2.new(0.5, 0.5)  -- Center anchor like MainFrame
    RestoreButton.Position = UDim2.new(0.5, 0, 0.5, 0)  -- Initial position (will be set on minimize)
    RestoreButton.Size = UDim2.new(0, isMobile and 50 or 55, 0, isMobile and 50 or 55)
    RestoreButton.BackgroundColor3 = Theme.Surface
    RestoreButton.BorderSizePixel = 0
    RestoreButton.Image = "rbxassetid://133508780883906"  -- Logo image
    RestoreButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
    RestoreButton.ScaleType = Enum.ScaleType.Fit
    RestoreButton.Visible = false
    RestoreButton.ZIndex = 100

    local RestoreCorner = Instance.new("UICorner")
    RestoreCorner.CornerRadius = UDim.new(1, 0)
    RestoreCorner.Parent = RestoreButton

    local RestoreStroke = Instance.new("UIStroke")
    RestoreStroke.Parent = RestoreButton
    RestoreStroke.Color = Theme.Border
    RestoreStroke.Thickness = 2
    
    -- Padding for logo inside button
    local RestorePadding = Instance.new("UIPadding")
    RestorePadding.Parent = RestoreButton
    RestorePadding.PaddingTop = UDim.new(0, 8)
    RestorePadding.PaddingBottom = UDim.new(0, 8)
    RestorePadding.PaddingLeft = UDim.new(0, 8)
    RestorePadding.PaddingRight = UDim.new(0, 8)

    -- Drag detection for restore button (FIXED LOGIC)
    local restoreDragging = false
    local restoreDragStart = nil
    local restoreStartPos = nil
    local restoreMouseDown = false
    local restoreConnection = nil
    local lastMainFramePosition = MainFrame.Position  -- Track last position
    
    RestoreButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            restoreMouseDown = true
            restoreDragging = false
            restoreDragStart = input.Position
            restoreStartPos = RestoreButton.Position
        end
    end)
    
    RestoreButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if restoreMouseDown and restoreDragStart then
                local delta = input.Position - restoreDragStart
                -- If moved more than 10 pixels, it's a drag
                if math.abs(delta.X) > 10 or math.abs(delta.Y) > 10 then
                    restoreDragging = true
                    
                    -- Move button
                    RestoreButton.Position = UDim2.new(
                        restoreStartPos.X.Scale,
                        restoreStartPos.X.Offset + delta.X,
                        restoreStartPos.Y.Scale,
                        restoreStartPos.Y.Offset + delta.Y
                    )
                end
            end
        end
    end)
    
    RestoreButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if restoreMouseDown then
                restoreMouseDown = false
                
                -- Only restore if it was NOT a drag
                if not restoreDragging then
                    -- Restore window from logo position
                    local logoPos = RestoreButton.Position
                    local buttonSize = isMobile and 50 or 55
                    
                    -- Calculate MainFrame center position from logo (reverse of minimize calculation)
                    local halfWidth = Sizes.WindowWidth / 2
                    local halfHeight = Sizes.WindowHeight / 2
                    local padding = buttonSize / 2 + 15
                    
                    -- Logo is at top-left corner, so add back half width/height to get center
                    local mainFrameX = logoPos.X.Offset + halfWidth - padding
                    local mainFrameY = logoPos.Y.Offset + halfHeight - padding
                    
                    local finalPosition = UDim2.new(
                        logoPos.X.Scale,
                        mainFrameX,
                        logoPos.Y.Scale,
                        mainFrameY
                    )
                    
                    -- Start at logo position with small size
                    MainFrame.Position = logoPos
                    MainFrame.Size = UDim2.new(0, 0, 0, 0)
                    MainFrame.Visible = true
                    RestoreButton.Visible = false
                    
                    -- Animate to final position and size
                    local targetSize = UDim2.new(0, Sizes.WindowWidth, 0, Sizes.WindowHeight)
                    TweenService:Create(
                        MainFrame,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = targetSize, Position = finalPosition}
                    ):Play()
                end
                
                -- Reset states
                restoreDragging = false
                restoreDragStart = nil
            end
        end
    end)

    -- Minimize functionality
    local isMinimized = false
    
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = true
        
        -- Save current MainFrame position before hiding
        lastMainFramePosition = MainFrame.Position
        
        -- Calculate logo position at top-left of MainFrame
        -- MainFrame has AnchorPoint 0.5,0.5 so position is at center
        -- Need to subtract half width/height to get top-left corner
        local buttonSize = isMobile and 50 or 55
        local halfWidth = Sizes.WindowWidth / 2
        local halfHeight = Sizes.WindowHeight / 2
        local padding = buttonSize / 2 + 15  -- Half button size + 15px from edge
        
        -- Calculate logo position at top-left corner of MainFrame
        local newX = MainFrame.Position.X.Offset - halfWidth + padding
        local newY = MainFrame.Position.Y.Offset - halfHeight + padding
        
        RestoreButton.Position = UDim2.new(
            MainFrame.Position.X.Scale,
            newX,
            MainFrame.Position.Y.Scale,
            newY
        )
        
        MainFrame.Visible = false
        RestoreButton.Visible = true
        
        -- Animate restore button
        RestoreButton.Size = UDim2.new(0, 0, 0, 0)
        Tween(RestoreButton, {
            Size = UDim2.new(0, buttonSize, 0, buttonSize)
        }, 0.3)
    end)

    RestoreButton.MouseEnter:Connect(function()
        Tween(RestoreButton, {BackgroundColor3 = Theme.SurfaceHover})
        Tween(RestoreButton, {ImageColor3 = Theme.Accent})
        Tween(RestoreButton, {Size = UDim2.new(0, (isMobile and 50 or 55) + 5, 0, (isMobile and 50 or 55) + 5)})
    end)

    RestoreButton.MouseLeave:Connect(function()
        Tween(RestoreButton, {BackgroundColor3 = Theme.Surface})
        Tween(RestoreButton, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
        Tween(RestoreButton, {Size = UDim2.new(0, isMobile and 50 or 55, 0, isMobile and 50 or 55)})
    end)

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.Position = UDim2.new(0, 0, 0, headerHeight)
    Sidebar.Size = UDim2.new(0, Sizes.SidebarWidth, 1, -headerHeight)
    Sidebar.BackgroundColor3 = Theme.Surface
    Sidebar.BorderSizePixel = 0

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 10)
    SidebarCorner.Parent = Sidebar

    local SidebarCover = Instance.new("Frame")
    SidebarCover.Parent = Sidebar
    SidebarCover.Position = UDim2.new(0.5, 0, 0, 0)
    SidebarCover.Size = UDim2.new(0.5, 0, 1, 0)
    SidebarCover.BackgroundColor3 = Theme.Surface
    SidebarCover.BorderSizePixel = 0

    -- Sidebar divider
    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Parent = Sidebar
    SidebarDivider.Position = UDim2.new(1, -1, 0, 0)
    SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
    SidebarDivider.BackgroundColor3 = Theme.Border
    SidebarDivider.BorderSizePixel = 0

    -- Tabs Container
    local TabsContainer = Instance.new("ScrollingFrame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = Sidebar
    TabsContainer.Position = UDim2.new(0, Sizes.Padding / 2, 0, Sizes.Padding)
    TabsContainer.Size = UDim2.new(1, -Sizes.Padding, 1, -Sizes.Padding * 2)
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.BorderSizePixel = 0
    TabsContainer.ScrollBarThickness = isMobile and 2 or 3
    TabsContainer.ScrollBarImageColor3 = Theme.Border
    TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Parent = TabsContainer
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding = UDim.new(0, 4)

    TabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabsContainer.CanvasSize = UDim2.new(0, 0, 0, TabsLayout.AbsoluteContentSize.Y + Sizes.Padding)
    end)

    -- Content Container
    local contentPadding = Sizes.Padding
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.Position = UDim2.new(0, Sizes.SidebarWidth + contentPadding, 0, headerHeight + contentPadding)
    ContentFrame.Size = UDim2.new(1, -Sizes.SidebarWidth - contentPadding * 2, 1, -headerHeight - contentPadding * 2)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = isMobile and 2 or 4
    ContentFrame.ScrollBarImageColor3 = Theme.Border
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentFrame
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, Sizes.SectionSpacing)

    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + Sizes.SectionSpacing)
    end)

    -- iPhone-style Home Bar (DI LUAR UI, seperti nextjs)
    local HomeBarContainer = Instance.new("Frame")
    HomeBarContainer.Name = "HomeBarContainer"
    HomeBarContainer.Parent = ScreenGui  -- Parent ke ScreenGui, bukan MainFrame
    HomeBarContainer.AnchorPoint = Vector2.new(0.5, 0)
    HomeBarContainer.Position = UDim2.new(0.5, 0, 0.5, Sizes.WindowHeight/2 + 5)  -- 5px below MainFrame
    HomeBarContainer.Size = UDim2.new(0, Sizes.WindowWidth, 0, 25)
    HomeBarContainer.BackgroundTransparency = 1
    HomeBarContainer.BorderSizePixel = 0
    HomeBarContainer.ZIndex = 100
    
    -- Home Bar Indicator (garis iPhone style)
    local HomeBarIndicator = Instance.new("Frame")
    HomeBarIndicator.Name = "Indicator"
    HomeBarIndicator.Parent = HomeBarContainer
    HomeBarIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
    HomeBarIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
    HomeBarIndicator.Size = UDim2.new(0, isMobile and 70 or 90, 0, isMobile and 4 or 5)
    HomeBarIndicator.BackgroundColor3 = Color3.fromRGB(120, 120, 120)  -- Gray
    HomeBarIndicator.BorderSizePixel = 0
    HomeBarIndicator.ZIndex = 101
    
    local HomeBarCorner = Instance.new("UICorner")
    HomeBarCorner.CornerRadius = UDim.new(1, 0)
    HomeBarCorner.Parent = HomeBarIndicator
    
    -- Update HomeBar position when MainFrame moves
    local function updateHomeBarPosition()
        HomeBarContainer.Position = UDim2.new(
            MainFrame.Position.X.Scale,
            MainFrame.Position.X.Offset,
            MainFrame.Position.Y.Scale,
            MainFrame.Position.Y.Offset + Sizes.WindowHeight/2 + 5
        )
    end
    
    -- Initial position
    updateHomeBarPosition()
    
    -- Update on MainFrame position change (drag)
    MainFrame:GetPropertyChangedSignal("Position"):Connect(updateHomeBarPosition)

    -- Make draggable from Header AND HomeBar
    MakeDraggable(MainFrame, Header)
    MakeDraggable(MainFrame, HomeBarContainer)

    -- Tab management
    local tabs = {}
    local currentTab = nil

    -- Window API
    local WindowAPI = {}

    function WindowAPI:Tab(tabName, tabIcon)
        -- Tab container
        local TabContainer = Instance.new("Frame")
        TabContainer.Name = tabName
        TabContainer.Parent = ContentFrame
        TabContainer.Size = UDim2.new(1, 0, 0, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Visible = false
        TabContainer.AutomaticSize = Enum.AutomaticSize.Y

        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Parent = TabContainer
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, Sizes.SectionSpacing)

        -- Tab button
        local tabBtnHeight = isMobile and 28 or 32
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Button"
        TabButton.Parent = TabsContainer
        TabButton.Size = UDim2.new(1, 0, 0, tabBtnHeight)
        TabButton.BackgroundColor3 = Theme.SurfaceHover
        TabButton.BorderSizePixel = 0
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = tabName
        TabButton.TextColor3 = Theme.TextSecondary
        TabButton.TextSize = Sizes.TabFont
        TabButton.TextXAlignment = Enum.TextXAlignment.Center
        TabButton.AutoButtonColor = false

        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 6)
        TabButtonCorner.Parent = TabButton

        local function selectTab()
            for _, tab in pairs(tabs) do
                tab.container.Visible = false
                tab.button.BackgroundColor3 = Theme.SurfaceHover
                tab.button.TextColor3 = Theme.TextSecondary
            end

            TabContainer.Visible = true
            TabButton.BackgroundColor3 = Theme.Border
            TabButton.TextColor3 = Theme.Text
            currentTab = tabName
        end

        TabButton.MouseButton1Click:Connect(selectTab)

        TabButton.MouseEnter:Connect(function()
            if currentTab ~= tabName then
                TabButton.BackgroundColor3 = Theme.Border
            end
        end)

        TabButton.MouseLeave:Connect(function()
            if currentTab ~= tabName then
                TabButton.BackgroundColor3 = Theme.SurfaceHover
            end
        end)

        tabs[tabName] = {
            container = TabContainer,
            button = TabButton,
            select = selectTab
        }

        if not currentTab then
            selectTab()
        end

        -- Tab API
        local TabAPI = {}

        function TabAPI:Section(sectionTitle)
            return WindowAPI:Section(sectionTitle, TabContainer)
        end

        return TabAPI
    end

    function WindowAPI:Section(sectionTitle, parent)
        parent = parent or ContentFrame
        
        local Section = Instance.new("Frame")
        Section.Name = "Section"
        Section.Parent = parent
        Section.Size = UDim2.new(1, 0, 0, 0)
        Section.BackgroundColor3 = Theme.Surface
        Section.BorderSizePixel = 0
        Section.AutomaticSize = Enum.AutomaticSize.Y

        local SectionCorner = Instance.new("UICorner")
        SectionCorner.CornerRadius = UDim.new(0, 8)
        SectionCorner.Parent = Section

        local InnerShadow = Instance.new("UIStroke")
        InnerShadow.Parent = Section
        InnerShadow.Color = Theme.Border
        InnerShadow.Thickness = 1
        InnerShadow.Transparency = 0.8

        -- Section Title (more compact)
        local titleHeight = isSmallMobile and 16 or (isMobile and 18 or 20)
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Name = "SectionTitle"
        SectionTitle.Parent = Section
        SectionTitle.Position = UDim2.new(0, Sizes.Padding, 0, Sizes.Padding)
        SectionTitle.Size = UDim2.new(1, -Sizes.Padding * 2, 0, titleHeight)
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Font = Enum.Font.GothamBold
        SectionTitle.Text = sectionTitle
        SectionTitle.TextColor3 = Theme.Text
        SectionTitle.TextSize = Sizes.SectionFont
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

        -- Section Content (adjust offset for smaller title)
        local contentOffset = titleHeight + Sizes.Padding + (isMobile and 3 or 5)
        local SectionContent = Instance.new("Frame")
        SectionContent.Name = "SectionContent"
        SectionContent.Parent = Section
        SectionContent.Position = UDim2.new(0, Sizes.Padding, 0, contentOffset)
        SectionContent.Size = UDim2.new(1, -Sizes.Padding * 2, 0, 0)
        SectionContent.BackgroundTransparency = 1
        SectionContent.AutomaticSize = Enum.AutomaticSize.Y

        local SectionLayout = Instance.new("UIListLayout")
        SectionLayout.Parent = SectionContent
        SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectionLayout.Padding = UDim.new(0, Sizes.ElementSpacing)

        local SectionPadding = Instance.new("UIPadding")
        SectionPadding.Parent = Section
        SectionPadding.PaddingBottom = UDim.new(0, Sizes.Padding)

        -- Section API
        local SectionAPI = {}

        function SectionAPI:Button(buttonText, callback)
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = SectionContent
            Button.Size = UDim2.new(1, 0, 0, Sizes.ButtonHeight)
            Button.BackgroundColor3 = Theme.SurfaceHover
            Button.BorderSizePixel = 0
            Button.Font = Enum.Font.Gotham
            Button.Text = buttonText
            Button.TextColor3 = Theme.Text
            Button.TextSize = Sizes.ButtonFont
            Button.AutoButtonColor = false

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button

            local ButtonStroke = Instance.new("UIStroke")
            ButtonStroke.Parent = Button
            ButtonStroke.Color = Theme.Border
            ButtonStroke.Thickness = 1
            ButtonStroke.Transparency = 0.9

            Button.MouseEnter:Connect(function()
                Tween(Button, {BackgroundColor3 = Theme.Border})
            end)

            Button.MouseLeave:Connect(function()
                Tween(Button, {BackgroundColor3 = Theme.SurfaceHover})
            end)

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)

            return Button
        end

        function SectionAPI:Toggle(toggleText, default, callback)
            local toggled = default or false

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "Toggle"
            ToggleFrame.Parent = SectionContent
            ToggleFrame.Size = UDim2.new(1, 0, 0, Sizes.ButtonHeight)
            ToggleFrame.BackgroundColor3 = Theme.SurfaceHover
            ToggleFrame.BorderSizePixel = 0

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = ToggleFrame

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.Position = UDim2.new(0, Sizes.Padding, 0, 0)
            ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Text = toggleText
            ToggleLabel.TextColor3 = Theme.Text
            ToggleLabel.TextSize = Sizes.ButtonFont
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.TextTruncate = Enum.TextTruncate.AtEnd

            local toggleBtnWidth = isMobile and 38 or 42
            local toggleBtnHeight = isMobile and 18 or 20
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = ToggleFrame
            ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
            ToggleButton.Position = UDim2.new(1, -Sizes.Padding, 0.5, 0)
            ToggleButton.Size = UDim2.new(0, toggleBtnWidth, 0, toggleBtnHeight)
            ToggleButton.BackgroundColor3 = toggled and Theme.Accent or Theme.Border
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""

            local ToggleBtnCorner = Instance.new("UICorner")
            ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
            ToggleBtnCorner.Parent = ToggleButton

            local circleSize = isMobile and 14 or 16
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Parent = ToggleButton
            ToggleCircle.Size = UDim2.new(0, circleSize, 0, circleSize)
            ToggleCircle.Position = toggled and UDim2.new(1, -circleSize - 2, 0.5, -circleSize/2) or UDim2.new(0, 2, 0.5, -circleSize/2)
            ToggleCircle.BackgroundColor3 = Theme.Background
            ToggleCircle.BorderSizePixel = 0

            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = ToggleCircle

            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                Tween(ToggleButton, {BackgroundColor3 = toggled and Theme.Accent or Theme.Border})
                Tween(ToggleCircle, {Position = toggled and UDim2.new(1, -circleSize - 2, 0.5, -circleSize/2) or UDim2.new(0, 2, 0.5, -circleSize/2)})
                
                pcall(callback, toggled)
            end)

            return ToggleFrame
        end

        function SectionAPI:Label(labelText)
            local labelMinHeight = isSmallMobile and 16 or (isMobile and 18 or 20)
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = SectionContent
            Label.Size = UDim2.new(1, 0, 0, labelMinHeight)
            Label.BackgroundTransparency = 1
            Label.Font = Enum.Font.Gotham
            Label.Text = labelText
            Label.TextColor3 = Theme.TextSecondary
            Label.TextSize = Sizes.LabelFont
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true
            Label.AutomaticSize = Enum.AutomaticSize.Y

            return Label
        end

        return SectionAPI
    end

    return WindowAPI
end

-- Notification system
function NextUI:Notification(title, message, duration)
    duration = duration or 3

    local NotifFrame = Instance.new("Frame")
    NotifFrame.Parent = ScreenGui
    NotifFrame.AnchorPoint = Vector2.new(1, 0)
    NotifFrame.Position = UDim2.new(1, 300, 0, 10)
    NotifFrame.Size = UDim2.new(0, isMobile and 250 or 280, 0, isMobile and 55 or 65)
    NotifFrame.BackgroundColor3 = Theme.Background
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 100

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 8)
    NotifCorner.Parent = NotifFrame

    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Parent = NotifFrame
    NotifStroke.Color = Theme.Border
    NotifStroke.Thickness = 1
    NotifStroke.Transparency = 0.5

    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Parent = NotifFrame
    NotifTitle.Position = UDim2.new(0, Sizes.Padding, 0, 6)
    NotifTitle.Size = UDim2.new(1, -Sizes.Padding * 2, 0, 14)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Theme.Text
    NotifTitle.TextSize = Sizes.SectionFont - 1
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left

    local NotifMessage = Instance.new("TextLabel")
    NotifMessage.Parent = NotifFrame
    NotifMessage.Position = UDim2.new(0, Sizes.Padding, 0, 22)
    NotifMessage.Size = UDim2.new(1, -Sizes.Padding * 2, 0, 30)
    NotifMessage.BackgroundTransparency = 1
    NotifMessage.Font = Enum.Font.Gotham
    NotifMessage.Text = message
    NotifMessage.TextColor3 = Theme.TextSecondary
    NotifMessage.TextSize = Sizes.LabelFont
    NotifMessage.TextWrapped = true
    NotifMessage.TextXAlignment = Enum.TextXAlignment.Left
    NotifMessage.TextYAlignment = Enum.TextYAlignment.Top

    TweenService:Create(
        NotifFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -10, 0, 10)}
    ):Play()

    task.wait(duration)
    local fadeOut = TweenService:Create(
        NotifFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = UDim2.new(1, 300, 0, 10)}
    )
    fadeOut:Play()
    fadeOut.Completed:Wait()
    NotifFrame:Destroy()
end

return NextUI
