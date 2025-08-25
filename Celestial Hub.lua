--// CELESTIAL HUB FINAL SCRIPT \\--

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Celestial Hub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Main Frame (hidden until key is entered)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌌 Celestial Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

-- Pet Name Box
local petBox = Instance.new("TextBox")
petBox.Size = UDim2.new(0.8, 0, 0, 35)
petBox.Position = UDim2.new(0.1, 0, 0.2, 0)
petBox.PlaceholderText = "Enter Pet Name"
petBox.Text = ""
petBox.Parent = mainFrame

-- Pet Weight Box
local weightBox = Instance.new("TextBox")
weightBox.Size = UDim2.new(0.8, 0, 0, 35)
weightBox.Position = UDim2.new(0.1, 0, 0.35, 0)
weightBox.PlaceholderText = "Enter Pet Weight"
weightBox.Text = ""
weightBox.Parent = mainFrame

-- Pet Spawn Button
local petButton = Instance.new("TextButton")
petButton.Size = UDim2.new(0.8, 0, 0, 35)
petButton.Position = UDim2.new(0.1, 0, 0.5, 0)
petButton.Text = "Spawn Pet"
petButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
petButton.TextColor3 = Color3.fromRGB(255, 255, 255)
petButton.Font = Enum.Font.GothamBold
petButton.TextSize = 16
petButton.Parent = mainFrame
Instance.new("UICorner", petButton).CornerRadius = UDim.new(0, 8)

-- Weather Name Box
local weatherBox = Instance.new("TextBox")
weatherBox.Size = UDim2.new(0.8, 0, 0, 35)
weatherBox.Position = UDim2.new(0.1, 0, 0.65, 0)
weatherBox.PlaceholderText = "Enter Weather Name"
weatherBox.Text = ""
weatherBox.Parent = mainFrame

-- Weather Button
local weatherButton = Instance.new("TextButton")
weatherButton.Size = UDim2.new(0.8, 0, 0, 35)
weatherButton.Position = UDim2.new(0.1, 0, 0.8, 0)
weatherButton.Text = "Start Weather"
weatherButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
weatherButton.TextColor3 = Color3.fromRGB(255, 255, 255)
weatherButton.Font = Enum.Font.GothamBold
weatherButton.TextSize = 16
weatherButton.Parent = mainFrame
Instance.new("UICorner", weatherButton).CornerRadius = UDim.new(0, 8)

-- Pet Spawn Function
petButton.MouseButton1Click:Connect(function()
    local petName = petBox.Text
    local petWeight = tonumber(weightBox.Text)
    if petName ~= "" and petWeight then
        local args = {
            [1] = petName,
            [2] = petWeight
        }
        ReplicatedStorage.GivePetRE:FireServer(unpack(args))
    end
end)

-- Weather Function
weatherButton.MouseButton1Click:Connect(function()
    local weatherName = weatherBox.Text
    if weatherName ~= "" then
        local args = {
            [1] = weatherName
        }
        ReplicatedStorage.StartWeatherEvent:FireServer(unpack(args))
    end
end)

---------------------------------------------------------
--// TOGGLE BUTTON \\--
---------------------------------------------------------

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0.5, -25)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://96627062315770" -- your custom icon
toggleButton.Parent = screenGui
toggleButton.Active = true
toggleButton.Draggable = true

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

---------------------------------------------------------
--// KEY SYSTEM \\--
---------------------------------------------------------

local KEY_URL = "https://raw.githubusercontent.com/gooliethegee/RobloxFiles/main/key.txt"

-- Frame
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 250, 0, 150)
keyFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = screenGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.25, 0)
keyBox.PlaceholderText = "Enter Key"
keyBox.Text = ""
keyBox.Parent = keyFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 35)
submitBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
submitBtn.Text = "Unlock"
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Parent = keyFrame
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 8)

-- Fetch Key
local function getKeyFromRepo()
    local success, result = pcall(function()
        return game:HttpGet(KEY_URL)
    end)
    if success then
        return result:match("%S+")
    else
        warn("Failed to fetch key:", result)
        return nil
    end
end

local REAL_KEY = getKeyFromRepo()

-- Key Logic
submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == REAL_KEY then
        keyFrame:Destroy()
        mainFrame.Visible = true
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "❌ Invalid Key"
        keyBox.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
    end
end)frame.Visible = false
frame.Parent = gui

-- Rounded corners
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Drop shadow
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.new(0,0,0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.Parent = frame

-- Title bar
local title = Instance.new("TextLabel")
title.Text = "🐾 Pet Giver"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.new(1,1,1)
title.BorderSizePixel = 0
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- Draggable support (PC + Mobile)
local dragging, dragInput, dragStart, startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
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

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Pet Name Box
local petBox = Instance.new("TextBox")
petBox.PlaceholderText = "Pet Name"
petBox.Font = Enum.Font.Gotham
petBox.TextSize = 14
petBox.Text = ""
petBox.Size = UDim2.new(1, -40, 0, 30)
petBox.Position = UDim2.new(0, 20, 0, 50)
petBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
petBox.TextColor3 = Color3.new(1,1,1)
petBox.BorderSizePixel = 0
petBox.Parent = frame
Instance.new("UICorner", petBox).CornerRadius = UDim.new(0, 6)

-- Weight Box
local weightBox = petBox:Clone()
weightBox.PlaceholderText = "Weight"
weightBox.Position = UDim2.new(0, 20, 0, 90)
weightBox.Text = ""
weightBox.Parent = frame

-- Button
local button = Instance.new("TextButton")
button.Text = "Give Pet"
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.Size = UDim2.new(1, -40, 0, 35)
button.Position = UDim2.new(0, 20, 0, 135)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.TextColor3 = Color3.new(1,1,1)
button.BorderSizePixel = 0
button.Parent = frame
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

-- Button Click Logic
button.MouseButton1Click:Connect(function()
    local petName = petBox.Text
    local weight = tonumber(weightBox.Text)

    if petName ~= "" and weight then
        local args = {[1] = petName, [2] = weight}
        ReplicatedStorage.GivePetRE:FireServer(unpack(args))
        button.Text = "✅ Sent!"
        task.wait(1)
        button.Text = "Give Pet"
    else
        button.Text = "⚠️ Invalid!"
        task.wait(1)
        button.Text = "Give Pet"
    end
end)

-- Toggle Open/Close
toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)
