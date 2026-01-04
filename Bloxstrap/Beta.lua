local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "FFlagsInjectorGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromScale(0.45, 0.6)
main.Position = UDim2.fromScale(0.275, 0.2)
main.BackgroundColor3 = Color3.fromRGB(28,28,28)
main.BorderSizePixel = 0
main.Parent = gui

local topBar = Instance.new("Frame")
topBar.Size = UDim2.fromScale(1,0.1)
topBar.Position = UDim2.fromScale(0,0)
topBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
topBar.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(0.7,1)
title.Position = UDim2.fromScale(0.02,0)
title.BackgroundTransparency = 1
title.Text = "Inyector FFlags"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(235,235,235)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.fromOffset(20,20)
minBtn.Position = UDim2.fromScale(0.85,0.5)
minBtn.AnchorPoint = Vector2.new(0,0.5)
minBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
minBtn.Text = ""
minBtn.BorderSizePixel = 0
minBtn.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(20,20)
closeBtn.Position = UDim2.fromScale(0.92,0.5)
closeBtn.AnchorPoint = Vector2.new(0,0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220,20,20)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = topBar

local separator = Instance.new("Frame")
separator.Size = UDim2.fromScale(1,0.01)
separator.Position = UDim2.fromScale(0,0.95)
separator.BackgroundColor3 = Color3.fromRGB(100,100,100)
separator.BorderSizePixel = 0
separator.Parent = topBar

local descLabel = Instance.new("TextLabel")
descLabel.Size = UDim2.fromScale(0.96,0.05)
descLabel.Position = UDim2.fromScale(0.02,0.12)
descLabel.BackgroundTransparency = 1
descLabel.Text = "Descripción"
descLabel.Font = Enum.Font.Gotham
descLabel.TextSize = 16
descLabel.TextColor3 = Color3.fromRGB(200,200,200)
descLabel.TextXAlignment = Enum.TextXAlignment.Left
descLabel.Parent = main

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.fromScale(0.96,0.6)
textBox.Position = UDim2.fromScale(0.02,0.18)
textBox.MultiLine = true
textBox.ClearTextOnFocus = false
textBox.Text = ""
textBox.PlaceholderText = "Pegá tus FFlags aquí "
textBox.Font = Enum.Font.Code
textBox.TextSize = 14
textBox.TextColor3 = Color3.fromRGB(230,230,230)
textBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
textBox.BorderSizePixel = 0
textBox.Parent = main

local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.fromScale(0.45,0.1)
saveBtn.Position = UDim2.fromScale(0.02,0.82)
saveBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
saveBtn.TextColor3 = Color3.fromRGB(235,235,235)
saveBtn.Font = Enum.Font.Gotham
saveBtn.TextSize = 16
saveBtn.Text = "Guardar"
saveBtn.Parent = main

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.fromScale(0.45,0.1)
rejoinBtn.Position = UDim2.fromScale(0.525,0.82)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
rejoinBtn.TextColor3 = Color3.fromRGB(235,235,235)
rejoinBtn.Font = Enum.Font.Gotham
rejoinBtn.TextSize = 16
rejoinBtn.Text = "Guardar + Rejoin"
rejoinBtn.Parent = main

local function saveFFlags()
	local ok = pcall(function()
		HttpService:JSONDecode(textBox.Text)
	end)
	if not ok then
		warn("JSON inválido")
		return
	end
	writefile("ClientSettings.json", textBox.Text)
end

saveBtn.MouseButton1Click:Connect(saveFFlags)
rejoinBtn.MouseButton1Click:Connect(function()
	saveFFlags()
	TeleportService:Teleport(game.PlaceId, player)
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	textBox.Visible = not minimized
	saveBtn.Visible = not minimized
	rejoinBtn.Visible = not minimized
	descLabel.Visible = not minimized
	if minimized then
		main.Size = UDim2.fromScale(0.45,0.1)
	else
		main.Size = UDim2.fromScale(0.45,0.6)
	end
end)	minimized = not minimized
	textBox.Visible = not minimized
	saveBtn.Visible = not minimized
	rejoinBtn.Visible = not minimized
	if minimized then
		frame.Size = UDim2.fromScale(0.5, 0.08)
	else
		frame.Size = UDim2.fromScale(0.5, 0.6)
	end
end)
local content = Instance.new("Frame", main)
content.Position = UDim2.fromScale(0, 0.085)
content.Size = UDim2.fromScale(1, 0.915)
content.BackgroundTransparency = 1


local boxHolder = Instance.new("Frame", content)
boxHolder.Position = UDim2.fromScale(0.025, 0.03)
boxHolder.Size = UDim2.fromScale(0.95, 0.75)
boxHolder.BackgroundColor3 = Color3.fromRGB(22,22,24)
boxHolder.BorderSizePixel = 0
Instance.new("UICorner", boxHolder).CornerRadius = UDim.new(0,12)

local boxStroke = Instance.new("UIStroke", boxHolder)
boxStroke.Color = Color3.fromRGB(35,35,38)

local box = Instance.new("TextBox", boxHolder)
box.Size = UDim2.fromScale(0.97, 0.96)
box.Position = UDim2.fromScale(0.015, 0.02)
box.MultiLine = true
box.ClearTextOnFocus = false
box.TextWrapped = false
box.TextXAlignment = Left
box.TextYAlignment = Top
box.Font = Enum.Font.Code
box.TextSize = 14
box.TextColor3 = Color3.fromRGB(225,225,225)
box.BackgroundTransparency = 1
box.PlaceholderText = "Pegá acá tus FFlags"


local function styleButton(btn)
	btn.BackgroundColor3 = Color3.fromRGB(26,26,28)
	btn.TextColor3 = Color3.fromRGB(240,240,240)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(38,38,42)
end


local save = Instance.new("TextButton", content)
save.Size = UDim2.fromScale(0.45, 0.1)
save.Position = UDim2.fromScale(0.025, 0.82)
save.Text = "Guardar fflags"
styleButton(save)


local rejoin = Instance.new("TextButton", content)
rejoin.Size = UDim2.fromScale(0.45, 0.1)
rejoin.Position = UDim2.fromScale(0.525, 0.82)
rejoin.Text = "Guardar + Rejoin"
styleButton(rejoin)


box:GetPropertyChangedSignal("Text"):Connect(function()
	counter.Text = string.format("%.2f KB", #box.Text / 1024)
end)


local function validate(json)
	return pcall(function()
		return HttpService:JSONDecode(json)
	end)
end

local function saveFlags()
	local ok = validate(box.Text)
	if not ok then return end
	writefile("ClientSettings.json", box.Text)
end

save.MouseButton1Click:Connect(saveFlags)
rejoin.MouseButton1Click:Connect(function()
	saveFlags()
	TeleportService:Teleport(game.PlaceId, player)
end)


local minimized = false
local originalSize = main.Size
local originalShadow = shadow.Size

minimize.MouseButton1Click:Connect(function()
	minimized = not minimized

	if minimized then
		content.Visible = false
		main.Size = UDim2.fromScale(0.55, 0.085)
		shadow.Size = UDim2.fromScale(0.56, 0.095)
	else
		content.Visible = true
		main.Size = originalSize
		shadow.Size = originalShadow
	end
end)


close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
