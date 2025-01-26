local UI_Library = {}

-- Window Class
UI_Library.Window = {}
UI_Library.Window.__index = UI_Library.Window

function UI_Library.Window:CreateWindow(windowName, windowSize, windowPosition)
    local self = setmetatable({}, UI_Library.Window)

    -- Create the ScreenGui
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = windowName
    self.screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create the Main Frame (Window)
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Size = windowSize
    self.mainFrame.Position = windowPosition
    self.mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)  -- White border
    self.mainFrame.BorderSizePixel = 2
    self.mainFrame.Parent = self.screenGui

    -- Add Rounded Corners
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = self.mainFrame

    return self
end

-- Tab System
function UI_Library.Window:CreateTab(tabName, tabSize, tabPosition)
    -- Create a tab bar and buttons for switching
    self.tabBar = Instance.new("Frame")
    self.tabBar.Size = UDim2.new(0, 500, 0, 40)
    self.tabBar.Position = UDim2.new(0, 0, 0, 40)
    self.tabBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    self.tabBar.BorderColor3 = Color3.fromRGB(255, 255, 255)  -- White border
    self.tabBar.BorderSizePixel = 2
    self.tabBar.Parent = self.mainFrame

    -- Create the Tab Buttons
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 250, 0, 40)
    tabButton.Position = UDim2.new(0, 0, 0, 0)
    tabButton.Text = tabName
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.TextSize = 18
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabButton.BorderColor3 = Color3.fromRGB(255, 255, 255)  -- White border
    tabButton.BorderSizePixel = 2
    tabButton.Parent = self.tabBar

    -- Create the Tab Content Frame
    self.tabFrame = Instance.new("Frame")
    self.tabFrame.Size = tabSize
    self.tabFrame.Position = tabPosition
    self.tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.tabFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)  -- White border
    self.tabFrame.BorderSizePixel = 2
    self.tabFrame.Visible = false  -- Initially hidden
    self.tabFrame.Parent = self.mainFrame

    return self
end

-- Add Button to a Tab
function UI_Library.Window:AddButton(tab, buttonName, buttonSize, buttonPosition, callback)
    local button = Instance.new("TextButton")
    button.Size = buttonSize
    button.Position = buttonPosition
    button.Text = buttonName
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.BorderColor3 = Color3.fromRGB(255, 255, 255)  -- White border
    button.BorderSizePixel = 2
    button.Parent = tab.tabFrame

    -- Button click action
    button.MouseButton1Click:Connect(callback)

    return self
end

-- Show the Tab
function UI_Library.Window:ShowTab(tab)
    -- Hide all other tabs
    for _, frame in ipairs(self.mainFrame:GetChildren()) do
        if frame:IsA("Frame") and frame.Name ~= "tabBar" then
            frame.Visible = false
        end
    end
    tab.tabFrame.Visible = true
end

-- Return the UI Library for use
return UI_Library
