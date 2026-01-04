local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "FFlagsEditor"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.5, 0.6)
frame.Position = UDim2.fromScale(0.25, 0.2)
frame.BackgroundColor3 = Color3.fromRGB(24,24,24)

local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.fromScale(1, 0.08)
topBar.Position = UDim2.fromScale(0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(18,18,18)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.fromScale(1, 1)
title.BackgroundTransparency = 1
title.Text = "FFlags Editor"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(230,230,230)

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.fromOffset(24,24)
closeBtn.Position = UDim2.new(1, -28, 0, 4)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(36,36,36)

local minBtn = Instance.new("TextButton", topBar)
minBtn.Size = UDim2.fromOffset(20,20)
minBtn.Position = UDim2.new(1, -60, 0, 6)
minBtn.Text = ""
minBtn.BackgroundColor3 = Color3.new(1,1,1)
minBtn.BorderSizePixel = 0

local textBox = Instance.new("TextBox", frame)
textBox.Position = UDim2.fromScale(0.025, 0.12)
textBox.Size = UDim2.fromScale(0.95, 0.7)
textBox.MultiLine = true
textBox.ClearTextOnFocus = false
textBox.Text = ""
textBox.PlaceholderText = "Pegá tus FFlags aquí (JSON)"
textBox.Font = Enum.Font.Code
textBox.TextSize = 14
textBox.TextColor3 = Color3.fromRGB(230,230,230)
textBox.BackgroundColor3 = Color3.fromRGB(30,30,30)

local saveBtn = Instance.new("TextButton", frame)
saveBtn.Size = UDim2.fromScale(0.45, 0.1)
saveBtn.Position = UDim2.fromScale(0.025, 0.84)
saveBtn.Text = "Guardar"
saveBtn.Font = Enum.Font.SourceSans
saveBtn.TextSize = 18
saveBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
saveBtn.TextColor3 = Color3.fromRGB(235,235,235)

local rejoinBtn = Instance.new("TextButton", frame)
rejoinBtn.Size = UDim2.fromScale(0.45, 0.1)
rejoinBtn.Position = UDim2.fromScale(0.525, 0.84)
rejoinBtn.Text = "Guardar + Rejoin"
rejoinBtn.Font = Enum.Font.SourceSans
rejoinBtn.TextSize = 18
rejoinBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
rejoinBtn.TextColor3 = Color3.fromRGB(235,235,235)

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
box.PlaceholderText = "Pegá acá tus FFlags (JSON completo)"


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
