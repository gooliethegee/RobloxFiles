-- Pet & Weather GUI Script (Fully Functional)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "PetWeatherGUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== TOGGLE BUTTON =====
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 140, 0, 40)
toggleButton.Position = UDim2.new(0.5, -70, 0, 20) -- Top center, visible
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Text = "Toggle GUI"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.Parent = gui

-- ===== MAIN FRAME =====
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.3, 50) -- Start below toggle button
frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Toggle visibility
local guiVisible = true
toggleButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    frame.Visible = guiVisible
end)

-- ===== DRAGGING LOGIC =====
local dragging, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
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

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ===== HELPER =====
local function createLabel(text, y)
    local lbl = Instance.new("TextLabel")
    lbl.Text = text
    lbl.Size = UDim2.new(1, -20, 0, 30)
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = lbl
    return lbl
end

-- ===== PET GIVER =====
createLabel("Pet Giver", 10)

local petBox = Instance.new("TextBox")
petBox.PlaceholderText = "Pet Name"
petBox.Size = UDim2.new(1, -20, 0, 35)
petBox.Position = UDim2.new(0, 10, 0, 50)
petBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
petBox.TextColor3 = Color3.fromRGB(255,255,255)
petBox.ClearTextOnFocus = false
petBox.Parent = frame
local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(0,8)
corner1.Parent = petBox

local weightBox = Instance.new("TextBox")
weightBox.PlaceholderText = "Weight"
weightBox.Size = UDim2.new(1, -20, 0, 35)
weightBox.Position = UDim2.new(0, 10, 0, 95)
weightBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
weightBox.TextColor3 = Color3.fromRGB(255,255,255)
weightBox.ClearTextOnFocus = false
weightBox.Parent = frame
local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0,8)
corner2.Parent = weightBox

local petButton = Instance.new("TextButton")
petButton.Text = "Give Pet"
petButton.Size = UDim2.new(1, -20, 0, 40)
petButton.Position = UDim2.new(0, 10, 0, 140)
petButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
petButton.TextColor3 = Color3.fromRGB(255,255,255)
petButton.Font = Enum.Font.GothamBold
petButton.TextSize = 16
local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0,10)
corner3.Parent = petButton
petButton.Parent = frame

petButton.MouseButton1Click:Connect(function()
    local petName = petBox.Text:match("^%s*(.-)%s*$")
    local weight = tonumber(weightBox.Text)
    if petName ~= "" and weight and weight > 0 then
        ReplicatedStorage:WaitForChild("GivePetRE"):FireServer(petName, weight)
        petButton.Text = "Pet Given!"
        task.wait(1)
        petButton.Text = "Give Pet"
    else
        petButton.Text = "Invalid Input!"
        task.wait(1)
        petButton.Text = "Give Pet"
    end
end)

-- ===== WEATHER SPAWNER =====
createLabel("Weather Spawner", 200)

local weatherBox = Instance.new("TextBox")
weatherBox.PlaceholderText = "Weather Name"
weatherBox.Size = UDim2.new(1, -20, 0, 35)
weatherBox.Position = UDim2.new(0, 10, 0, 240)
weatherBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
weatherBox.TextColor3 = Color3.fromRGB(255,255,255)
weatherBox.ClearTextOnFocus = false
weatherBox.Parent = frame
local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0,8)
corner4.Parent = weatherBox

local weatherButton = Instance.new("TextButton")
weatherButton.Text = "Start Weather"
weatherButton.Size = UDim2.new(1, -20, 0, 40)
weatherButton.Position = UDim2.new(0, 10, 0, 285)
weatherButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
weatherButton.TextColor3 = Color3.fromRGB(255,255,255)
weatherButton.Font = Enum.Font.GothamBold
weatherButton.TextSize = 16
local corner5 = Instance.new("UICorner")
corner5.CornerRadius = UDim.new(0,10)
corner5.Parent = weatherButton
weatherButton.Parent = frame

weatherButton.MouseButton1Click:Connect(function()
    local weatherName = weatherBox.Text:match("^%s*(.-)%s*$")
    if weatherName ~= "" then
        ReplicatedStorage:WaitForChild("StartWeatherEvent"):FireServer(weatherName)
        weatherButton.Text = "Weather Started!"
        task.wait(1)
        weatherButton.Text = "Start Weather"
    else
        weatherButton.Text = "Invalid Input!"
        task.wait(1)
        weatherButton.Text = "Start Weather"
    end
end)
