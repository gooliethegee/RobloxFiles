--[[
   🌟 Fancy Pet Giver GUI 🌟
   Works in modded Grow a Garden games with unprotected remotes
   Features:
   - Draggable main window (PC & Mobile)
   - Toggle button (icon) to open/close
   - Styled UI
]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "FancyPetGiver"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Toggle Button (icon)
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
toggleBtn.Image = "rbxassetid://3926307971" -- UI icon sprite sheet
toggleBtn.ImageRectOffset = Vector2.new(84, 204) -- paw icon
toggleBtn.ImageRectSize = Vector2.new(36, 36)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Parent = gui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 180)
frame.Position = UDim2.new(0.5, -140, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = false
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
