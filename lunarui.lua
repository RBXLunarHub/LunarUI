local function CreateWindow()
    local Window = Instance.new("ScreenGui")
    Window.Name = "Window"
    Window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Window
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Function to create tabs
    local function CreateTab(tabName)
        local Tab = Instance.new("Frame")
        Tab.Name = tabName
        Tab.Parent = MainFrame
        Tab.Size = UDim2.new(0, 600, 0, 400)
        Tab.BackgroundTransparency = 1
        Tab.Visible = false
        
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Parent = Tab
        tabLabel.Size = UDim2.new(1, 0, 0, 40)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = tabName
        tabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabLabel.Font = Enum.Font.GothamSemibold
        tabLabel.TextSize = 20
        tabLabel.TextAlign = Enum.TextXAlignment.Center
        tabLabel.Position = UDim2.new(0, 0, 0, 10)
        
        return Tab
    end

    -- Function to create buttons
    local function CreateButton(parent, text, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 200, 0, 50)
        Button.Position = UDim2.new(0, 50, 0, 50)
        Button.Text = text
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.GothamSemibold
        Button.TextSize = 18
        Button.Parent = parent

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = Button

        Button.MouseButton1Click:Connect(function()
            callback()
        end)
    end

    -- Function to create sliders
    local function CreateSlider(parent, min, max, defaultValue, callback)
        local Slider = Instance.new("Frame")
        Slider.Size = UDim2.new(0, 500, 0, 50)
        Slider.Position = UDim2.new(0, 50, 0, 150)
        Slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Slider.Parent = parent

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = Slider

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 448, 0, 5)
        bar.Position = UDim2.new(0, 25, 0, 20)
        bar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        bar.Parent = Slider

        local sliderButton = Instance.new("Frame")
        sliderButton.Size = UDim2.new(0, 10, 0, 10)
        sliderButton.Position = UDim2.new(0, defaultValue / max * 448, 0, -2)
        sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sliderButton.Parent = bar

        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(0, 60, 0, 20)
        TextBox.Position = UDim2.new(1, 10, 0, 10)
        TextBox.Text = tostring(defaultValue)
        TextBox.Parent = Slider
        TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TextBox.TextColor3 = Color3.fromRGB(225, 225, 225)
        TextBox.Font = Enum.Font.GothamSemibold
        TextBox.TextSize = 12

        local function updateSliderPosition(newValue)
            sliderButton.Position = UDim2.new(0, newValue / max * 448, 0, -2)
            TextBox.Text = tostring(newValue)
            callback(newValue)
        end

        sliderButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local mouse = game.Players.LocalPlayer:GetMouse()
                local startPos = mouse.X - bar.AbsolutePosition.X
                local connection
                connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        local xPosition = math.clamp(mouse.X - bar.AbsolutePosition.X, 0, 448)
                        updateSliderPosition(math.floor((xPosition / 448) * max))
                    end
                end)
                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                    end
                end)
            end
        end)
    end

    -- Function to create textboxes
    local function CreateTextbox(parent, defaultValue, callback)
        local Textbox = Instance.new("Frame")
        Textbox.Size = UDim2.new(0, 400, 0, 40)
        Textbox.Position = UDim2.new(0, 50, 0, 250)
        Textbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Textbox.Parent = parent

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = Textbox

        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(1, -20, 0, 30)
        TextBox.Position = UDim2.new(0, 10, 0, 5)
        TextBox.Text = defaultValue
        TextBox.Parent = Textbox
        TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TextBox.TextColor3 = Color3.fromRGB(225, 225, 225)
        TextBox.Font = Enum.Font.GothamSemibold
        TextBox.TextSize = 16

        TextBox.FocusLost:Connect(function()
            callback(TextBox.Text)
        end)
    end

    -- Creating tabs
    local tab1 = CreateTab("Tab 1")
    tab1.Visible = true

    -- Adding buttons, sliders, and textboxes
    CreateButton(tab1, "Button", function()
        print("Button clicked!")
    end)

    CreateSlider(tab1, 0, 100, 50, function(value)
        print("Slider value:", value)
    end)

    CreateTextbox(tab1, "Default Text", function(value)
        print("Textbox input:", value)
    end)

    return Window
end

-- Call the function to create the window

