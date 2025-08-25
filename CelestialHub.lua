--// Celestial Hub with Key System
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- // KEY SYSTEM
local success, key = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/gooliethegee/RobloxFiles/main/key.txt")
end)

if not success or not key then
    warn("Failed to fetch key")
    return
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CelestialHub"
ScreenGui.Parent = game.CoreGui

-- Toggle Button
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 200)
ToggleButton.Image = "rbxassetid://96627062315770"
ToggleButton.BackgroundTransparency = 1
ToggleButton.Parent = ScreenGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- UICorner
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "Celestial Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Dragging
local dragging, dragInput, dragStart, startPos
Title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Buttons Holder
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(1, 0, 0, 40)
ButtonHolder.Position = UDim2.new(0, 0, 0, 50)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ButtonHolder

-- Function to create buttons
local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 18
	btn.Parent = ButtonHolder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(callback)
end

-- PET SPAWNER
createButton("Pet Spawner", function()
	local petName = game:GetService("Players").LocalPlayer.Name -- Example: replace with GUI text input
	local weight = 100
	local args = { "La Vacca Saturno Saturnita", weight }
	game:GetService("ReplicatedStorage").GivePetRE:FireServer(unpack(args))
end)

-- WEATHER SPAWNER
createButton("Weather Spawner", function()
	local args = { "MeteorStrike" }
	game:GetService("ReplicatedStorage").StartWeatherEvent:FireServer(unpack(args))
end)

-- Toggle Button Behavior
ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- // ASK FOR KEY
local inputKey = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("KeyPrompt")
if not inputKey then
	local keyPrompt = Instance.new("TextBox")
	keyPrompt.Size = UDim2.new(0, 200, 0, 40)
	keyPrompt.Position = UDim2.new(0.5, -100, 0.5, -20)
	keyPrompt.PlaceholderText = "Enter Key..."
	keyPrompt.Text = ""
	keyPrompt.TextColor3 = Color3.fromRGB(0,0,0)
	keyPrompt.BackgroundColor3 = Color3.fromRGB(255,255,255)
	keyPrompt.Parent = ScreenGui

	keyPrompt.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			if keyPrompt.Text == key then
				keyPrompt:Destroy()
				MainFrame.Visible = true
			else
				keyPrompt.Text = "Invalid Key!"
				task.wait(1.5)
				keyPrompt.Text = ""
			end
		end
	end)
end
