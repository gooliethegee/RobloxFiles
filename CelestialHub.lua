--// Celestial Hub
--// Key System + GUI with Toggle + Pet & Weather Spawner

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// Get key from GitHub
local success, key = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/gooliethegee/RobloxFiles/main/key.txt")
end)

if not success then
    warn("Failed to load key file.")
    return
end

key = key:gsub("%s+", "")

--// Key Input GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.Active = true
KeyFrame.Draggable = true

local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "Enter Key"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

local TextBox = Instance.new("TextBox", KeyFrame)
TextBox.Size = UDim2.new(1, -20, 0, 30)
TextBox.Position = UDim2.new(0, 10, 0, 50)
TextBox.PlaceholderText = "Enter Key Here"
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)

local Submit = Instance.new("TextButton", KeyFrame)
Submit.Size = UDim2.new(0.5, -15, 0, 30)
Submit.Position = UDim2.new(0, 10, 0, 100)
Submit.Text = "Submit"
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)

local Close = Instance.new("TextButton", KeyFrame)
Close.Size = UDim2.new(0.5, -15, 0, 30)
Close.Position = UDim2.new(0.5, 5, 0, 100)
Close.Text = "Exit"
Close.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
Close.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Celestial Hub GUI
local function CreateHub()
    local HubGui = Instance.new("ScreenGui", game.CoreGui)
    HubGui.Name = "CelestialHub"

    local Main = Instance.new("Frame", HubGui)
    Main.Size = UDim2.new(0, 400, 0, 350)
    Main.Position = UDim2.new(0.5, -200, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.Active = true
    Main.Draggable = true
    Main.Visible = false

    local Header = Instance.new("TextLabel", Main)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Header.Text = "Celestial Hub"
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.Font = Enum.Font.SourceSansBold
    Header.TextSize = 22

    -- Pet Name Input
    local PetNameBox = Instance.new("TextBox", Main)
    PetNameBox.Size = UDim2.new(1, -20, 0, 30)
    PetNameBox.Position = UDim2.new(0, 10, 0, 60)
    PetNameBox.PlaceholderText = "Pet Name"
    PetNameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    PetNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Pet Age Input
    local PetAgeBox = Instance.new("TextBox", Main)
    PetAgeBox.Size = UDim2.new(1, -20, 0, 30)
    PetAgeBox.Position = UDim2.new(0, 10, 0, 100)
    PetAgeBox.PlaceholderText = "Pet Age"
    PetAgeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    PetAgeBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Pet Spawner Button
    local PetButton = Instance.new("TextButton", Main)
    PetButton.Size = UDim2.new(1, -20, 0, 30)
    PetButton.Position = UDim2.new(0, 10, 0, 140)
    PetButton.Text = "Spawn Pet"
    PetButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    PetButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    PetButton.MouseButton1Click:Connect(function()
        local petName = PetNameBox.Text
        local petAge = tonumber(PetAgeBox.Text) or 0
        if petName ~= "" then
            game:GetService("ReplicatedStorage").GivePetRE:FireServer(petName, petAge)
        end
    end)

    -- Weather Name Input
    local WeatherBox = Instance.new("TextBox", Main)
    WeatherBox.Size = UDim2.new(1, -20, 0, 30)
    WeatherBox.Position = UDim2.new(0, 10, 0, 190)
    WeatherBox.PlaceholderText = "Weather Event Name"
    WeatherBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    WeatherBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Weather Spawner Button
    local WeatherButton = Instance.new("TextButton", Main)
    WeatherButton.Size = UDim2.new(1, -20, 0, 30)
    WeatherButton.Position = UDim2.new(0, 10, 0, 230)
    WeatherButton.Text = "Spawn Weather"
    WeatherButton.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
    WeatherButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    WeatherButton.MouseButton1Click:Connect(function()
        local weatherName = WeatherBox.Text
        if weatherName ~= "" then
            game:GetService("ReplicatedStorage").StartWeatherEvent:FireServer(weatherName)
        end
    end)

    -- Toggle Button
    local Toggle = Instance.new("ImageButton", HubGui)
    Toggle.Size = UDim2.new(0, 50, 0, 50)
    Toggle.Position = UDim2.new(0, 20, 0.5, -25)
    Toggle.Image = "rbxassetid://96627062315770"
    Toggle.BackgroundTransparency = 0

    Toggle.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)
end

--// Button Logic
Submit.MouseButton1Click:Connect(function()
    local input = TextBox.Text:gsub("%s+", "")
    if input == key then
        KeyFrame.Visible = false
        CreateHub()
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "Invalid Key!"
    end
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
