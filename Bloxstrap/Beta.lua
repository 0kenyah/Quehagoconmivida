local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Crear carpeta Delta > BloxstrapBeta > FFlagsJSON
local delta = workspace:FindFirstChild("Delta") or Instance.new("Folder", workspace)
delta.Name = "Delta"

local bloxBeta = delta:FindFirstChild("BloxstrapBeta") or Instance.new("Folder", delta)
bloxBeta.Name = "BloxstrapBeta"

local fflagsFolder = bloxBeta:FindFirstChild("FFlagsJSON") or Instance.new("Folder", bloxBeta)
fflagsFolder.Name = "FFlagsJSON"

local jsonFile = fflagsFolder:FindFirstChild("FFlags.json") or Instance.new("StringValue", fflagsFolder)
jsonFile.Name = "FFlags.json"

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FFlagsInjectorGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromScale(0.45,0.6)
main.Position = UDim2.fromScale(0.275,0.2)
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
textBox.Text = jsonFile.Value
textBox.PlaceholderText = "Pegá tus FFlags aquí (JSON)"
textBox.Font = Enum.Font.Code
textBox.TextSize = 14
textBox.TextColor3 = Color3.fromRGB(230,230,230)
textBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
textBox.BorderSizePixel = 0
textBox.TextWrapped = false
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

local function applyFFlagsFromJSON(jsonText)
	local ok, data = pcall(function()
		return HttpService:JSONDecode(jsonText)
	end)
	if not ok then
		warn("JSON inválido")
		return
	end
	for k,v in pairs(data) do
		pcall(function()
			if type(v) == "boolean" then
				settings():SetFFlag(k, v)
			elseif type(v) == "number" then
				settings():SetDFFlag(k, v)
			else
				settings():SetFFlag(k, tostring(v))
			end
		end)
	end
	jsonFile.Value = jsonText
end

saveBtn.MouseButton1Click:Connect(function()
	applyFFlagsFromJSON(textBox.Text)
end)

rejoinBtn.MouseButton1Click:Connect(function()
	applyFFlagsFromJSON(textBox.Text)
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
end)

-- Aplicar automáticamente FFlags guardadas al abrir
if jsonFile.Value ~= "" then
	applyFFlagsFromJSON(jsonFile.Value)
endsaveBtn.Font = Enum.Font.Gotham
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

local function applyFFlags()
	local ok, data = pcall(function()
		return HttpService:JSONDecode(textBox.Text)
	end)
	if not ok then
		warn("JSON inválido")
		return
	end
	local fflagsFolder = bloxBeta:FindFirstChild("FFlags") or Instance.new("Folder", bloxBeta)
	fflagsFolder.Name = "FFlags"
	for k,v in pairs(data) do
		local success, err = pcall(function()
			if type(v) == "boolean" then
				settings():SetFFlag(k, v)
			elseif type(v) == "number" then
				settings():SetDFFlag(k, v)
			else
				settings():SetFFlag(k, tostring(v))
			end
		end)
	end
end

saveBtn.MouseButton1Click:Connect(applyFFlags)
rejoinBtn.MouseButton1Click:Connect(function()
	applyFFlags()
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
end)saveBtn.TextSize = 16
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
	local fflagsData = bloxBeta:FindFirstChild("FFlags") or Instance.new("StringValue", bloxBeta)
	fflagsData.Name = "FFlags"
	fflagsData.Value = textBox.Text
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
end)
