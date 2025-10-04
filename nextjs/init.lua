-- ============================================
-- NextJS Theme UI Library
-- Dark Mode + Neumorphism Design
-- ============================================

print("[NextUI] Loading library...")

local NextUI = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Theme Colors (Monochrome Grayscale)
local Theme = {
    Background = Color3.fromRGB(10, 10, 10),        -- Deep black
    Surface = Color3.fromRGB(18, 18, 18),           -- Card background
    SurfaceHover = Color3.fromRGB(25, 25, 25),      -- Hover state
    Border = Color3.fromRGB(40, 40, 40),            -- Borders
    Text = Color3.fromRGB(245, 245, 245),           -- Primary text
    TextSecondary = Color3.fromRGB(160, 160, 160),  -- Secondary text
    TextTertiary = Color3.fromRGB(100, 100, 100),   -- Tertiary text
    Accent = Color3.fromRGB(255, 255, 255),         -- White accent
    AccentDim = Color3.fromRGB(200, 200, 200),      -- Dimmed accent
    Success = Color3.fromRGB(80, 200, 120),         -- Success green
    Warning = Color3.fromRGB(255, 200, 80),         -- Warning yellow
    Error = Color3.fromRGB(255, 80, 80),            -- Error red
    Shadow = Color3.fromRGB(0, 0, 0),               -- Shadows
}

-- Utility: Make draggable
local function MakeDraggable(frame, dragArea)
    local dragging = false
    local dragInput, dragStart, startPos

    dragArea = dragArea or frame

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement then
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

-- Create ScreenGui with fallback support
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NextUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Try CoreGui first, fallback to PlayerGui if protected
local success = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)

if not success then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    print("[NextUI] Using PlayerGui (CoreGui protected)")
else
    print("[NextUI] Using CoreGui")
end

print("[NextUI] ScreenGui created successfully!")

-- Main Window Function
function NextUI:Window(config)
    config = config or {}
    local windowTitle = config.Title or "NextUI Window"
    local windowIcon = config.Icon or nil
    local windowSize = config.Size or UDim2.new(0, 600, 0, 450)

    -- Main Container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = windowSize
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    -- Neumorphic shadow (outer)
    local OuterShadow = Instance.new("ImageLabel")
    OuterShadow.Name = "OuterShadow"
    OuterShadow.Parent = MainFrame
    OuterShadow.BackgroundTransparency = 1
    OuterShadow.Position = UDim2.new(0, -15, 0, -15)
    OuterShadow.Size = UDim2.new(1, 30, 1, 30)
    OuterShadow.Image = "rbxassetid://5554236805"
    OuterShadow.ImageColor3 = Theme.Shadow
    OuterShadow.ImageTransparency = 0.3
    OuterShadow.ScaleType = Enum.ScaleType.Slice
    OuterShadow.SliceCenter = Rect.new(23, 23, 277, 277)
    OuterShadow.ZIndex = 0

    -- Border glow
    local BorderGlow = Instance.new("UIStroke")
    BorderGlow.Parent = MainFrame
    BorderGlow.Color = Theme.Border
    BorderGlow.Thickness = 1
    BorderGlow.Transparency = 0.7

    -- Corner radius
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame

    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = Theme.Surface
    Header.BorderSizePixel = 0

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header

    -- Header bottom only (remove top corners visually)
    local HeaderCover = Instance.new("Frame")
    HeaderCover.Parent = Header
    HeaderCover.Position = UDim2.new(0, 0, 0.5, 0)
    HeaderCover.Size = UDim2.new(1, 0, 0.5, 0)
    HeaderCover.BackgroundColor3 = Theme.Surface
    HeaderCover.BorderSizePixel = 0

    -- Icon (optional)
    local titleStartX = 20
    if windowIcon then
        local IconImage = Instance.new("ImageLabel")
        IconImage.Name = "Icon"
        IconImage.Parent = Header
        IconImage.Position = UDim2.new(0, 15, 0.5, 0)
        IconImage.AnchorPoint = Vector2.new(0, 0.5)
        IconImage.Size = UDim2.new(0, 28, 0, 28)
        IconImage.BackgroundTransparency = 1
        IconImage.Image = "rbxassetid://" .. tostring(windowIcon)
        IconImage.ScaleType = Enum.ScaleType.Fit
        
        local IconCorner = Instance.new("UICorner")
        IconCorner.CornerRadius = UDim.new(0, 6)
        IconCorner.Parent = IconImage
        
        titleStartX = 50  -- Move title to the right if icon exists
    end

    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Parent = Header
    TitleLabel.Position = UDim2.new(0, titleStartX, 0, 0)
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = windowTitle
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Header
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.Position = UDim2.new(1, -15, 0.5, 0)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.BackgroundColor3 = Theme.SurfaceHover
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextColor3 = Theme.TextSecondary
    CloseButton.TextSize = 20

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
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
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = Header
    MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
    MinimizeButton.Position = UDim2.new(1, -50, 0.5, 0)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.BackgroundColor3 = Theme.SurfaceHover
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "−"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextColor3 = Theme.TextSecondary
    MinimizeButton.TextSize = 20

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 8)
    MinCorner.Parent = MinimizeButton

    local minimized = false

    MinimizeButton.MouseEnter:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Theme.Border})
    end)

    MinimizeButton.MouseLeave:Connect(function()
        Tween(MinimizeButton, {BackgroundColor3 = Theme.SurfaceHover})
    end)

    -- Minimize click handler will be set after Sidebar and ContentFrame are created

    -- Sidebar (left)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.Position = UDim2.new(0, 0, 0, 50)
    Sidebar.Size = UDim2.new(0, 150, 1, -50)
    Sidebar.BackgroundColor3 = Theme.Surface
    Sidebar.BorderSizePixel = 0

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 12)
    SidebarCorner.Parent = Sidebar

    -- Sidebar cover (hide top-right and bottom-right corners)
    local SidebarCoverTop = Instance.new("Frame")
    SidebarCoverTop.Parent = Sidebar
    SidebarCoverTop.Position = UDim2.new(0.5, 0, 0, 0)
    SidebarCoverTop.Size = UDim2.new(0.5, 0, 1, 0)
    SidebarCoverTop.BackgroundColor3 = Theme.Surface
    SidebarCoverTop.BorderSizePixel = 0

    -- Sidebar divider
    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Parent = Sidebar
    SidebarDivider.Position = UDim2.new(1, -1, 0, 0)
    SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
    SidebarDivider.BackgroundColor3 = Theme.Border
    SidebarDivider.BorderSizePixel = 0

    -- Profile section at bottom of sidebar
    local ProfileSection = Instance.new("Frame")
    ProfileSection.Name = "ProfileSection"
    ProfileSection.Parent = Sidebar
    ProfileSection.Position = UDim2.new(0, 0, 1, -55)
    ProfileSection.Size = UDim2.new(1, 0, 0, 55)
    ProfileSection.BackgroundColor3 = Theme.Background
    ProfileSection.BorderSizePixel = 0

    local ProfileCorner = Instance.new("UICorner")
    ProfileCorner.CornerRadius = UDim.new(0, 8)
    ProfileCorner.Parent = ProfileSection

    -- Top divider line
    local ProfileDivider = Instance.new("Frame")
    ProfileDivider.Parent = ProfileSection
    ProfileDivider.Position = UDim2.new(0, 8, 0, 0)
    ProfileDivider.Size = UDim2.new(1, -16, 0, 1)
    ProfileDivider.BackgroundColor3 = Theme.Border
    ProfileDivider.BorderSizePixel = 0

    -- Get player info
    local player = game.Players.LocalPlayer
    local userId = player.UserId
    local username = player.Name
    local displayName = player.DisplayName

    -- Avatar
    local Avatar = Instance.new("ImageLabel")
    Avatar.Parent = ProfileSection
    Avatar.Position = UDim2.new(0, 8, 0.5, 0)
    Avatar.AnchorPoint = Vector2.new(0, 0.5)
    Avatar.Size = UDim2.new(0, 36, 0, 36)
    Avatar.BackgroundColor3 = Theme.Surface
    Avatar.BorderSizePixel = 0
    Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=48&height=48&format=png"

    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = Avatar

    -- Username container
    local UsernameFrame = Instance.new("Frame")
    UsernameFrame.Parent = ProfileSection
    UsernameFrame.Position = UDim2.new(0, 50, 0.5, 0)
    UsernameFrame.AnchorPoint = Vector2.new(0, 0.5)
    UsernameFrame.Size = UDim2.new(0, 60, 0, 36)
    UsernameFrame.BackgroundTransparency = 1

    -- Display name
    local DisplayNameLabel = Instance.new("TextLabel")
    DisplayNameLabel.Parent = UsernameFrame
    DisplayNameLabel.Position = UDim2.new(0, 0, 0, 2)
    DisplayNameLabel.Size = UDim2.new(1, 0, 0, 16)
    DisplayNameLabel.BackgroundTransparency = 1
    DisplayNameLabel.Font = Enum.Font.GothamBold
    DisplayNameLabel.Text = displayName
    DisplayNameLabel.TextColor3 = Theme.Text
    DisplayNameLabel.TextSize = 11
    DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    DisplayNameLabel.TextTruncate = Enum.TextTruncate.AtEnd

    -- Username (@username)
    local UsernameLabel = Instance.new("TextLabel")
    UsernameLabel.Parent = UsernameFrame
    UsernameLabel.Position = UDim2.new(0, 0, 0, 18)
    UsernameLabel.Size = UDim2.new(1, 0, 0, 14)
    UsernameLabel.BackgroundTransparency = 1
    UsernameLabel.Font = Enum.Font.Gotham
    UsernameLabel.Text = "@" .. username
    UsernameLabel.TextColor3 = Theme.TextTertiary
    UsernameLabel.TextSize = 9
    UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
    UsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd

    -- Settings gear button
    local SettingsButton = Instance.new("TextButton")
    SettingsButton.Parent = ProfileSection
    SettingsButton.AnchorPoint = Vector2.new(1, 0.5)
    SettingsButton.Position = UDim2.new(1, -8, 0.5, 0)
    SettingsButton.Size = UDim2.new(0, 28, 0, 28)
    SettingsButton.BackgroundColor3 = Theme.SurfaceHover
    SettingsButton.BorderSizePixel = 0
    SettingsButton.Text = "⚙"
    SettingsButton.Font = Enum.Font.GothamBold
    SettingsButton.TextColor3 = Theme.TextSecondary
    SettingsButton.TextSize = 16
    SettingsButton.AutoButtonColor = false

    local SettingsCorner = Instance.new("UICorner")
    SettingsCorner.CornerRadius = UDim.new(0, 6)
    SettingsCorner.Parent = SettingsButton

    SettingsButton.MouseEnter:Connect(function()
        SettingsButton.BackgroundColor3 = Theme.Border
        SettingsButton.TextColor3 = Theme.Text
    end)

    SettingsButton.MouseLeave:Connect(function()
        SettingsButton.BackgroundColor3 = Theme.SurfaceHover
        SettingsButton.TextColor3 = Theme.TextSecondary
    end)

    SettingsButton.MouseButton1Click:Connect(function()
        -- You can add settings logic here
        NextUI:Notification("Settings", "Settings clicked!", 2)
    end)

    -- Sidebar tabs container (adjusted size to fit above profile)
    local TabsContainer = Instance.new("ScrollingFrame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = Sidebar
    TabsContainer.Position = UDim2.new(0, 10, 0, 10)
    TabsContainer.Size = UDim2.new(1, -20, 1, -75)  -- Reduced to make space for profile
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.BorderSizePixel = 0
    TabsContainer.ScrollBarThickness = 0
    TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Parent = TabsContainer
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding = UDim.new(0, 5)

    TabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabsContainer.CanvasSize = UDim2.new(0, 0, 0, TabsLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Content Container (right side)
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.Position = UDim2.new(0, 165, 0, 65)
    ContentFrame.Size = UDim2.new(1, -180, 1, -80)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = Theme.Border
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentFrame
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 15)

    -- Auto-resize canvas
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 15)
    end)

    -- Make draggable
    MakeDraggable(MainFrame, Header)

    -- Now set up minimize button handler (after Sidebar and ContentFrame exist)
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            -- When minimized, show full rounded corners
            Tween(MainFrame, {Size = UDim2.new(windowSize.X.Scale, windowSize.X.Offset, 0, 50)}, 0.3)
            HeaderCover.Visible = false
            Sidebar.Visible = false  -- Hide sidebar and profile
            ContentFrame.Visible = false  -- Hide content
            -- Make header background same as mainframe so it looks unified
            task.wait(0.3)
            Header.BackgroundColor3 = Theme.Background
        else
            -- When expanded, show everything again
            Tween(MainFrame, {Size = windowSize}, 0.3)
            HeaderCover.Visible = true
            Sidebar.Visible = true  -- Show sidebar and profile
            ContentFrame.Visible = true  -- Show content
            Header.BackgroundColor3 = Theme.Surface
        end
    end)

    -- Tab management
    local tabs = {}
    local currentTab = nil

    -- Window API
    local WindowAPI = {}

    function WindowAPI:Tab(tabName, tabIcon)
        -- Tab container for sections
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
        TabLayout.Padding = UDim.new(0, 15)

        -- Tab button in sidebar
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Button"
        TabButton.Parent = TabsContainer
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Theme.SurfaceHover
        TabButton.BorderSizePixel = 0
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = "  " .. tabName
        TabButton.TextColor3 = Theme.TextSecondary
        TabButton.TextSize = 13
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.AutoButtonColor = false

        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 8)
        TabButtonCorner.Parent = TabButton

        -- Tab icon (optional)
        if tabIcon then
            local TabIconLabel = Instance.new("ImageLabel")
            TabIconLabel.Parent = TabButton
            TabIconLabel.Position = UDim2.new(0, 8, 0.5, 0)
            TabIconLabel.AnchorPoint = Vector2.new(0, 0.5)
            TabIconLabel.Size = UDim2.new(0, 18, 0, 18)
            TabIconLabel.BackgroundTransparency = 1
            TabIconLabel.Image = "rbxassetid://" .. tostring(tabIcon)
            TabIconLabel.ScaleType = Enum.ScaleType.Fit
            TabButton.Text = "    " .. tabName
        end

        -- Function to switch to this tab
        local function selectTab()
            -- Hide all tabs
            for _, tab in pairs(tabs) do
                tab.container.Visible = false
                tab.button.BackgroundColor3 = Theme.SurfaceHover
                tab.button.TextColor3 = Theme.TextSecondary
            end

            -- Show this tab
            TabContainer.Visible = true
            TabButton.BackgroundColor3 = Theme.Border
            TabButton.TextColor3 = Theme.Text
            currentTab = tabName
        end

        TabButton.MouseButton1Click:Connect(selectTab)

        -- Hover effects
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

        -- Store tab
        tabs[tabName] = {
            container = TabContainer,
            button = TabButton,
            select = selectTab
        }

        -- Select first tab automatically
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
        
        -- Section Container
        local Section = Instance.new("Frame")
        Section.Name = "Section"
        Section.Parent = parent
        Section.Size = UDim2.new(1, 0, 0, 0)
        Section.BackgroundColor3 = Theme.Surface
        Section.BorderSizePixel = 0
        Section.AutomaticSize = Enum.AutomaticSize.Y

        local SectionCorner = Instance.new("UICorner")
        SectionCorner.CornerRadius = UDim.new(0, 10)
        SectionCorner.Parent = Section

        -- Neumorphic inner shadow
        local InnerShadow = Instance.new("UIStroke")
        InnerShadow.Parent = Section
        InnerShadow.Color = Theme.Border
        InnerShadow.Thickness = 1
        InnerShadow.Transparency = 0.8

        -- Section Title
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Name = "SectionTitle"
        SectionTitle.Parent = Section
        SectionTitle.Position = UDim2.new(0, 15, 0, 15)
        SectionTitle.Size = UDim2.new(1, -30, 0, 25)
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Font = Enum.Font.GothamBold
        SectionTitle.Text = sectionTitle
        SectionTitle.TextColor3 = Theme.Text
        SectionTitle.TextSize = 14
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

        -- Section Content
        local SectionContent = Instance.new("Frame")
        SectionContent.Name = "SectionContent"
        SectionContent.Parent = Section
        SectionContent.Position = UDim2.new(0, 15, 0, 45)
        SectionContent.Size = UDim2.new(1, -30, 0, 0)
        SectionContent.BackgroundTransparency = 1
        SectionContent.AutomaticSize = Enum.AutomaticSize.Y

        local SectionLayout = Instance.new("UIListLayout")
        SectionLayout.Parent = SectionContent
        SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectionLayout.Padding = UDim.new(0, 10)

        -- Padding at bottom
        local SectionPadding = Instance.new("UIPadding")
        SectionPadding.Parent = Section
        SectionPadding.PaddingBottom = UDim.new(0, 15)

        -- Section API
        local SectionAPI = {}

        function SectionAPI:Button(buttonText, callback)
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = SectionContent
            Button.Size = UDim2.new(1, 0, 0, 38)
            Button.BackgroundColor3 = Theme.SurfaceHover
            Button.BorderSizePixel = 0
            Button.Font = Enum.Font.Gotham
            Button.Text = buttonText
            Button.TextColor3 = Theme.Text
            Button.TextSize = 13
            Button.AutoButtonColor = false

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = Button

            local ButtonStroke = Instance.new("UIStroke")
            ButtonStroke.Parent = Button
            ButtonStroke.Color = Theme.Border
            ButtonStroke.Thickness = 1
            ButtonStroke.Transparency = 0.9

            Button.MouseEnter:Connect(function()
                Tween(Button, {BackgroundColor3 = Theme.Border})
                Tween(ButtonStroke, {Transparency = 0.5})
            end)

            Button.MouseLeave:Connect(function()
                Tween(Button, {BackgroundColor3 = Theme.SurfaceHover})
                Tween(ButtonStroke, {Transparency = 0.9})
            end)

            Button.MouseButton1Click:Connect(function()
                Tween(Button, {TextSize = 11}, 0.1)
                wait(0.1)
                Tween(Button, {TextSize = 13}, 0.1)
                pcall(callback)
            end)

            return Button
        end

        function SectionAPI:Toggle(toggleText, default, callback)
            local toggled = default or false

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "Toggle"
            ToggleFrame.Parent = SectionContent
            ToggleFrame.Size = UDim2.new(1, 0, 0, 38)
            ToggleFrame.BackgroundColor3 = Theme.SurfaceHover
            ToggleFrame.BorderSizePixel = 0

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Parent = ToggleFrame

            local ToggleStroke = Instance.new("UIStroke")
            ToggleStroke.Parent = ToggleFrame
            ToggleStroke.Color = Theme.Border
            ToggleStroke.Thickness = 1
            ToggleStroke.Transparency = 0.9

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Text = toggleText
            ToggleLabel.TextColor3 = Theme.Text
            ToggleLabel.TextSize = 13
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = ToggleFrame
            ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
            ToggleButton.Position = UDim2.new(1, -15, 0.5, 0)
            ToggleButton.Size = UDim2.new(0, 45, 0, 22)
            ToggleButton.BackgroundColor3 = toggled and Theme.Accent or Theme.Border
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.AutoButtonColor = false

            local ToggleBtnCorner = Instance.new("UICorner")
            ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
            ToggleBtnCorner.Parent = ToggleButton

            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Parent = ToggleButton
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
            ToggleCircle.Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
            ToggleCircle.BackgroundColor3 = Theme.Background
            ToggleCircle.BorderSizePixel = 0

            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = ToggleCircle

            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                Tween(ToggleButton, {BackgroundColor3 = toggled and Theme.Accent or Theme.Border})
                Tween(ToggleCircle, {Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)})
                
                pcall(callback, toggled)
            end)

            return ToggleFrame
        end

        function SectionAPI:Slider(sliderText, config, callback)
            config = config or {}
            local min = config.Min or 0
            local max = config.Max or 100
            local default = config.Default or min
            local currentValue = default

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = "Slider"
            SliderFrame.Parent = SectionContent
            SliderFrame.Size = UDim2.new(1, 0, 0, 55)
            SliderFrame.BackgroundColor3 = Theme.SurfaceHover
            SliderFrame.BorderSizePixel = 0

            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Parent = SliderFrame

            local SliderStroke = Instance.new("UIStroke")
            SliderStroke.Parent = SliderFrame
            SliderStroke.Color = Theme.Border
            SliderStroke.Thickness = 1
            SliderStroke.Transparency = 0.9

            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Parent = SliderFrame
            SliderLabel.Position = UDim2.new(0, 15, 0, 8)
            SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Text = sliderText
            SliderLabel.TextColor3 = Theme.Text
            SliderLabel.TextSize = 13
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

            local SliderValue = Instance.new("TextLabel")
            SliderValue.Parent = SliderFrame
            SliderValue.AnchorPoint = Vector2.new(1, 0)
            SliderValue.Position = UDim2.new(1, -15, 0, 8)
            SliderValue.Size = UDim2.new(0, 50, 0, 20)
            SliderValue.BackgroundTransparency = 1
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.Text = tostring(currentValue)
            SliderValue.TextColor3 = Theme.Accent
            SliderValue.TextSize = 13
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Parent = SliderFrame
            SliderTrack.Position = UDim2.new(0, 15, 1, -18)
            SliderTrack.Size = UDim2.new(1, -30, 0, 4)
            SliderTrack.BackgroundColor3 = Theme.Border
            SliderTrack.BorderSizePixel = 0

            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(1, 0)
            TrackCorner.Parent = SliderTrack

            local SliderFill = Instance.new("Frame")
            SliderFill.Parent = SliderTrack
            SliderFill.Size = UDim2.new((currentValue - min) / (max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Theme.Accent
            SliderFill.BorderSizePixel = 0

            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = SliderFill

            -- Slider Thumb (draggable circle) - parent to SliderTrack for proper positioning
            local SliderThumb = Instance.new("Frame")
            SliderThumb.Parent = SliderTrack
            SliderThumb.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderThumb.Position = UDim2.new((currentValue - min) / (max - min), 0, 0.5, 0)
            SliderThumb.Size = UDim2.new(0, 18, 0, 18)
            SliderThumb.BackgroundColor3 = Theme.Accent
            SliderThumb.BorderSizePixel = 0
            SliderThumb.ZIndex = 3

            local ThumbCorner = Instance.new("UICorner")
            ThumbCorner.CornerRadius = UDim.new(1, 0)
            ThumbCorner.Parent = SliderThumb

            -- Thumb shadow/border
            local ThumbStroke = Instance.new("UIStroke")
            ThumbStroke.Parent = SliderThumb
            ThumbStroke.Color = Theme.Background
            ThumbStroke.Thickness = 3

            local dragging = false
            local connection

            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                currentValue = math.floor(min + (max - min) * pos)
                
                SliderValue.Text = tostring(currentValue)
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                SliderThumb.Position = UDim2.new(pos, 0, 0.5, 0)
                
                pcall(callback, currentValue)
            end

            local function startDrag()
                dragging = true
                SliderThumb.Size = UDim2.new(0, 22, 0, 22)
                
                if connection then connection:Disconnect() end
                connection = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider(input)
                    end
                end)
            end

            local function endDrag()
                dragging = false
                SliderThumb.Size = UDim2.new(0, 18, 0, 18)
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end

            -- Thumb hover effect (no tween, instant)
            SliderThumb.MouseEnter:Connect(function()
                if not dragging then
                    SliderThumb.Size = UDim2.new(0, 20, 0, 20)
                end
            end)

            SliderThumb.MouseLeave:Connect(function()
                if not dragging then
                    SliderThumb.Size = UDim2.new(0, 18, 0, 18)
                end
            end)

            -- Click/Drag on Track
            SliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    updateSlider(input)
                    startDrag()
                end
            end)

            -- Click/Drag on Thumb
            SliderThumb.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    startDrag()
                end
            end)

            -- Release anywhere
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    endDrag()
                end
            end)

            return SliderFrame
        end

        function SectionAPI:Dropdown(dropdownText, options, callback)
            options = options or {}
            local opened = false

            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = "Dropdown"
            DropdownFrame.Parent = SectionContent
            DropdownFrame.Size = UDim2.new(1, 0, 0, 38)
            DropdownFrame.BackgroundColor3 = Theme.SurfaceHover
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.ClipsDescendants = false
            DropdownFrame.ZIndex = 10

            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 8)
            DropdownCorner.Parent = DropdownFrame

            local DropdownStroke = Instance.new("UIStroke")
            DropdownStroke.Parent = DropdownFrame
            DropdownStroke.Color = Theme.Border
            DropdownStroke.Thickness = 1
            DropdownStroke.Transparency = 0.9

            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Parent = DropdownFrame
            DropdownButton.Size = UDim2.new(1, 0, 0, 38)
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Text = dropdownText
            DropdownButton.TextColor3 = Theme.Text
            DropdownButton.TextSize = 13
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Center

            local Arrow = Instance.new("TextLabel")
            Arrow.Parent = DropdownButton
            Arrow.AnchorPoint = Vector2.new(1, 0.5)
            Arrow.Position = UDim2.new(1, -10, 0.5, 0)
            Arrow.Size = UDim2.new(0, 20, 0, 20)
            Arrow.BackgroundTransparency = 1
            Arrow.Font = Enum.Font.GothamBold
            Arrow.Text = "▼"
            Arrow.TextColor3 = Theme.TextSecondary
            Arrow.TextSize = 10

            local OptionsFrame = Instance.new("ScrollingFrame")
            OptionsFrame.Name = "Options"
            OptionsFrame.Parent = DropdownFrame
            OptionsFrame.Position = UDim2.new(0, 0, 1, 5)
            OptionsFrame.Size = UDim2.new(1, 0, 0, 0)
            OptionsFrame.BackgroundColor3 = Theme.Surface
            OptionsFrame.BorderSizePixel = 0
            OptionsFrame.Visible = false
            OptionsFrame.ZIndex = 11
            OptionsFrame.ScrollBarThickness = 4
            OptionsFrame.ScrollBarImageColor3 = Theme.Border
            OptionsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            OptionsFrame.ClipsDescendants = true

            local OptionsCorner = Instance.new("UICorner")
            OptionsCorner.CornerRadius = UDim.new(0, 8)
            OptionsCorner.Parent = OptionsFrame

            local OptionsStroke = Instance.new("UIStroke")
            OptionsStroke.Parent = OptionsFrame
            OptionsStroke.Color = Theme.Border
            OptionsStroke.Thickness = 1
            OptionsStroke.Transparency = 0.8

            local OptionsList = Instance.new("UIListLayout")
            OptionsList.Parent = OptionsFrame
            OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
            OptionsList.Padding = UDim.new(0, 2)
            
            -- Auto-resize canvas for scrolling
            OptionsList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                OptionsFrame.CanvasSize = UDim2.new(0, 0, 0, OptionsList.AbsoluteContentSize.Y + 4)
            end)

            for _, option in ipairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Parent = OptionsFrame
                OptionButton.Size = UDim2.new(1, 0, 0, 32)
                OptionButton.BackgroundColor3 = Theme.Surface
                OptionButton.BorderSizePixel = 0
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Text = option
                OptionButton.TextColor3 = Theme.TextSecondary
                OptionButton.TextSize = 12
                OptionButton.ZIndex = 11

                OptionButton.MouseEnter:Connect(function()
                    Tween(OptionButton, {BackgroundColor3 = Theme.SurfaceHover})
                    Tween(OptionButton, {TextColor3 = Theme.Text})
                end)

                OptionButton.MouseLeave:Connect(function()
                    Tween(OptionButton, {BackgroundColor3 = Theme.Surface})
                    Tween(OptionButton, {TextColor3 = Theme.TextSecondary})
                end)

                OptionButton.MouseButton1Click:Connect(function()
                    DropdownButton.Text = option
                    opened = false
                    OptionsFrame.Visible = false
                    Tween(Arrow, {Rotation = 0})
                    pcall(callback, option)
                end)
            end

            DropdownButton.MouseButton1Click:Connect(function()
                opened = not opened
                OptionsFrame.Visible = opened
                if opened then
                    local optionsHeight = math.min(#options * 34, 150)
                    OptionsFrame.Size = UDim2.new(1, 0, 0, optionsHeight)
                    Tween(Arrow, {Rotation = 180})
                else
                    Tween(Arrow, {Rotation = 0})
                end
            end)

            return DropdownFrame
        end

        function SectionAPI:Input(inputText, placeholder, callback)
            local InputFrame = Instance.new("Frame")
            InputFrame.Name = "Input"
            InputFrame.Parent = SectionContent
            InputFrame.Size = UDim2.new(1, 0, 0, 55)
            InputFrame.BackgroundColor3 = Theme.SurfaceHover
            InputFrame.BorderSizePixel = 0

            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 8)
            InputCorner.Parent = InputFrame

            local InputStroke = Instance.new("UIStroke")
            InputStroke.Parent = InputFrame
            InputStroke.Color = Theme.Border
            InputStroke.Thickness = 1
            InputStroke.Transparency = 0.9

            local InputLabel = Instance.new("TextLabel")
            InputLabel.Parent = InputFrame
            InputLabel.Position = UDim2.new(0, 15, 0, 8)
            InputLabel.Size = UDim2.new(1, -30, 0, 18)
            InputLabel.BackgroundTransparency = 1
            InputLabel.Font = Enum.Font.Gotham
            InputLabel.Text = inputText
            InputLabel.TextColor3 = Theme.Text
            InputLabel.TextSize = 13
            InputLabel.TextXAlignment = Enum.TextXAlignment.Left

            local InputBox = Instance.new("TextBox")
            InputBox.Parent = InputFrame
            InputBox.Position = UDim2.new(0, 15, 1, -30)
            InputBox.Size = UDim2.new(1, -30, 0, 25)
            InputBox.BackgroundColor3 = Theme.Background
            InputBox.BorderSizePixel = 0
            InputBox.Font = Enum.Font.Gotham
            InputBox.PlaceholderText = placeholder or "Enter text..."
            InputBox.PlaceholderColor3 = Theme.TextTertiary
            InputBox.Text = ""
            InputBox.TextColor3 = Theme.Text
            InputBox.TextSize = 12
            InputBox.TextXAlignment = Enum.TextXAlignment.Left
            InputBox.ClearTextOnFocus = false

            local InputBoxCorner = Instance.new("UICorner")
            InputBoxCorner.CornerRadius = UDim.new(0, 6)
            InputBoxCorner.Parent = InputBox

            InputBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    pcall(callback, InputBox.Text)
                end
            end)

            return InputFrame
        end

        function SectionAPI:Label(labelText)
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = SectionContent
            Label.Size = UDim2.new(1, 0, 0, 25)
            Label.BackgroundTransparency = 1
            Label.Font = Enum.Font.Gotham
            Label.Text = labelText
            Label.TextColor3 = Theme.TextSecondary
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true

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
    NotifFrame.Position = UDim2.new(1, 320, 0, 20)  -- Start off-screen to the right
    NotifFrame.Size = UDim2.new(0, 280, 0, 65)  -- Compact size
    NotifFrame.BackgroundColor3 = Theme.Background  -- Pure black background
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 100
    NotifFrame.BackgroundTransparency = 0.1  -- Slightly transparent

    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 10)
    NotifCorner.Parent = NotifFrame

    -- Subtle dark border instead of white
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Parent = NotifFrame
    NotifStroke.Color = Theme.Border  -- Dark gray border, no white
    NotifStroke.Thickness = 1
    NotifStroke.Transparency = 0.5

    -- Accent line on the left
    local AccentLine = Instance.new("Frame")
    AccentLine.Parent = NotifFrame
    AccentLine.Position = UDim2.new(0, 0, 0, 0)
    AccentLine.Size = UDim2.new(0, 3, 1, 0)
    AccentLine.BackgroundColor3 = Theme.Accent
    AccentLine.BorderSizePixel = 0

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 10)
    AccentCorner.Parent = AccentLine

    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Parent = NotifFrame
    NotifTitle.Position = UDim2.new(0, 15, 0, 8)
    NotifTitle.Size = UDim2.new(1, -30, 0, 16)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Theme.Text
    NotifTitle.TextSize = 13
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left

    local NotifMessage = Instance.new("TextLabel")
    NotifMessage.Parent = NotifFrame
    NotifMessage.Position = UDim2.new(0, 15, 0, 26)
    NotifMessage.Size = UDim2.new(1, -30, 0, 32)
    NotifMessage.BackgroundTransparency = 1
    NotifMessage.Font = Enum.Font.Gotham
    NotifMessage.Text = message
    NotifMessage.TextColor3 = Theme.TextSecondary
    NotifMessage.TextSize = 11
    NotifMessage.TextWrapped = true
    NotifMessage.TextXAlignment = Enum.TextXAlignment.Left
    NotifMessage.TextYAlignment = Enum.TextYAlignment.Top

    -- Smooth slide in animation from right
    TweenService:Create(
        NotifFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -20, 0, 20)}
    ):Play()

    -- Auto dismiss with slide out
    task.wait(duration)
    local fadeOut = TweenService:Create(
        NotifFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = UDim2.new(1, 320, 0, 20), BackgroundTransparency = 1}
    )
    fadeOut:Play()
    fadeOut.Completed:Wait()
    NotifFrame:Destroy()
end

print("[NextUI] Library loaded successfully! Ready to use.")
return NextUI
