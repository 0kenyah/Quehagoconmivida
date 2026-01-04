local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer


local gui = Instance.new("ScreenGui")
gui.Name = "FFlagsInjector"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")


local shadow = Instance.new("Frame", gui)
shadow.Size = UDim2.fromScale(0.56, 0.62)
shadow.Position = UDim2.fromScale(0.22, 0.19)
shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0,16)


local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.55, 0.6)
main.Position = UDim2.fromScale(0.225, 0.2)
main.BackgroundColor3 = Color3.fromRGB(16,16,18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(35,35,38)
stroke.Thickness = 1


local top = Instance.new("Frame", main)
top.Size = UDim2.fromScale(1, 0.085)
top.BackgroundColor3 = Color3.fromRGB(20,20,22)
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,14)

local mask = Instance.new("Frame", top)
mask.Size = UDim2.fromScale(1, 0.5)
mask.Position = UDim2.fromScale(0, 0.5)
mask.BackgroundColor3 = Color3.fromRGB(20,20,22)
mask.BorderSizePixel = 0


local title = Instance.new("TextLabel", top)
title.BackgroundTransparency = 1
title.Size = UDim2.fromScale(0.6, 1)
title.Position = UDim2.fromScale(0.03, 0)
title.Text = "FFlags Injector"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Left
title.TextColor3 = Color3.fromRGB(245,245,245)


local counter = Instance.new("TextLabel", top)
counter.BackgroundTransparency = 1
counter.Size = UDim2.fromScale(0.25, 1)
counter.Position = UDim2.fromScale(0.55, 0)
counter.TextXAlignment = Right
counter.Font = Enum.Font.Gotham
counter.TextSize = 12
counter.TextColor3 = Color3.fromRGB(170,170,170)
counter.Text = "0.00 KB"


local buttons = Instance.new("Frame", top)
buttons.Size = UDim2.fromScale(0.12, 1)
buttons.Position = UDim2.fromScale(0.86, 0)
buttons.BackgroundTransparency = 1


local minimize = Instance.new("TextButton", buttons)
minimize.Size = UDim2.fromOffset(18,18)
minimize.Position = UDim2.fromScale(0.05, 0.5)
minimize.AnchorPoint = Vector2.new(0,0.5)
minimize.Text = ""
minimize.BackgroundColor3 = Color3.fromRGB(245,245,245)
minimize.BorderSizePixel = 0
Instance.new("UICorner", minimize).CornerRadius = UDim.new(1,0)


local close = Instance.new("TextButton", buttons)
close.Size = UDim2.fromOffset(18,18)
close.Position = UDim2.fromScale(0.55, 0.5)
close.AnchorPoint = Vector2.new(0,0.5)
close.Text = "✕"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.fromRGB(240,240,240)
close.BackgroundColor3 = Color3.fromRGB(32,32,34)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)


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
