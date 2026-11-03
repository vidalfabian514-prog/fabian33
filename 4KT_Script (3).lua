-- 4KT SCRIPT — Aimbot + ESP + Chams + No Recoil + Vehicle Aim + Super Jump
-- F = Aimbot | T = ESP | M = Reset (ESC+R+ENTER)
-- G = Teclas/Colores | P = Aimbot | U = Amigos | 8 = Info Usuario
-- Nieve + "4KT ON TOP"

------------------------------------------------------------------
-- PANTALLA DE CARGA (Limpia y Rápida)
------------------------------------------------------------------
task.spawn(function()
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local LocalPlayer = Players.LocalPlayer

	local gui = Instance.new("ScreenGui")
	gui.Name = "FourKT_Loading"
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 9999999
	gui.ResetOnSpawn = false

	pcall(function()
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui", 5) or game:GetService("CoreGui")
	end)

	local bg = Instance.new("Frame")
	bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
	bg.BorderSizePixel = 0
	bg.Parent = gui

	local glow = Instance.new("Frame")
	glow.AnchorPoint = Vector2.new(0.5, 0.5)
	glow.Position = UDim2.fromScale(0.5, 0.45)
	glow.Size = UDim2.fromOffset(380, 380)
	glow.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
	glow.BackgroundTransparency = 0.85
	glow.BorderSizePixel = 0
	glow.ZIndex = 1
	glow.Parent = bg
	Instance.new("UICorner", glow).CornerRadius = UDim.new(1, 0)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 50)
	title.Position = UDim2.new(0, 0, 0.42, -30)
	title.BackgroundTransparency = 1
	title.Text = "4KT ON TOP"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBlack
	title.TextSize = 38
	title.ZIndex = 2
	title.Parent = bg

	local sub = Instance.new("TextLabel")
	sub.Size = UDim2.new(1, 0, 0, 24)
	sub.Position = UDim2.new(0, 0, 0.42, 25)
	sub.BackgroundTransparency = 1
	sub.Text = "Cargando componentes..."
	sub.TextColor3 = Color3.fromRGB(140, 180, 255)
	sub.Font = Enum.Font.GothamMedium
	sub.TextSize = 14
	sub.ZIndex = 2
	sub.Parent = bg

	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(0.3, 0, 0, 6)
	barBg.Position = UDim2.new(0.35, 0, 0.42, 65)
	barBg.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
	barBg.BorderSizePixel = 0
	barBg.ZIndex = 2
	barBg.Parent = bg
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0, 0, 1, 0)
	bar.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
	bar.BorderSizePixel = 0
	bar.ZIndex = 3
	bar.Parent = barBg
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	TweenService:Create(bar, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()

	task.wait(1.5)

	TweenService:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	TweenService:Create(glow, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	TweenService:Create(title, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(sub, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(barBg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	local fadeLast = TweenService:Create(bar, TweenInfo.new(0.4), {BackgroundTransparency = 1})
	fadeLast:Play()

	fadeLast.Completed:Connect(function()
		gui:Destroy()
	end)
end)

------------------------------------------------------------------
-- VARIABLES PRINCIPALES
------------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local Backpack = LocalPlayer:WaitForChild("Backpack", 5)

local CHAMS_COLORS = {
	{ Name = "BLANCO",   Color = Color3.fromRGB(255, 255, 255) },
	{ Name = "NEGRO",    Color = Color3.fromRGB(20, 20, 20) },
	{ Name = "AMARILLO", Color = Color3.fromRGB(255, 220, 40) },
	{ Name = "ROJO",     Color = Color3.fromRGB(255, 50, 50) },
	{ Name = "VERDE",    Color = Color3.fromRGB(40, 255, 80) },
	{ Name = "AZUL",     Color = Color3.fromRGB(50, 140, 255) },
}
local chamsColorIndex = 4
local ChamsColorBtn2

local Settings = {
	ESPEnabled = true,
	TracersEnabled = true,
	HighlightEnabled = true,
	Informacion = true,
	WeaponIconESP = false, -- icono de arma encima del jugador
	NoRecoilEnabled = false,
	VehicleAimEnabled = true,
	DeviceMode = "PC",
	VehicleAimOffsetX = -30,
	VehicleAimOffsetY = -30,
	PredictionEnabled = true, -- predicción RPG / movimiento
	PredictionFactor = 0.13,
	DroppedItemsESP = false,
	SkeletonESP = false,
	SuperJumpEnabled = false,
	JumpPowerValue = 60,
	FOV = 220,
	FOVThickness = 5,
	Smoothness = 0.065,
	MaxDistance = 800,
	AimMode = "Hold",
	AimStrength = 0.92,
	NameColor = Color3.fromRGB(255, 255, 255),
	InfoColor = Color3.fromRGB(0, 255, 128),
	Friends = {},
	AlternateAim = false,
	AlternateInterval = 0.5,
	AimPartMode = "Alternate",
	FullMenuKey = Enum.KeyCode.G,
	AimMenuKey = Enum.KeyCode.P,
	FriendsKey = Enum.KeyCode.U,
	AimKey = Enum.KeyCode.F,
	ESPKey = Enum.KeyCode.T,
	MacroKey = Enum.KeyCode.M,
	ChamsColorIndex = 4,
	ScreenScale = 1.0,
	MenuMinW = 260,
	MenuMinH = 220,
	MenuMaxW = 420,
	MenuMaxH = 620,
}

local CONFIG_FILE = "FourKT_Config.json"
local waitingForKey = nil
local keyBtnRefs = {}
local FullPanel, AimPanel, FriendsPanel, InfoPanel
local UIScale

local function keyName(k)
	if typeof(k) == "EnumItem" then return k.Name end
	if type(k) == "string" and Enum.KeyCode[k] then return k end
	return "?"
end

local function resolveKey(name, fallback)
	if type(name) == "string" and Enum.KeyCode[name] then return Enum.KeyCode[name] end
	return fallback
end

local function getWriteFile() return writefile or (getgenv and getgenv().writefile) end
local function getReadFile() return readfile or (getgenv and getgenv().readfile) end
local function getIsFile() return isfile or (getgenv and getgenv().isfile) end

------------------------------------------------------------------
-- NO RECOIL
------------------------------------------------------------------
local function IsGun(tool)
	if not tool or not tool:IsA("Tool") then return false end
	return tool:GetAttribute("reload_time") or tool:GetAttribute("AmmoType")
end

local function ApplyNoRecoil(gun)
	pcall(function()
		gun:SetAttribute("Recoil", 0.0)
	end)
end

local _lastNoRecoil = 0
RunService.Heartbeat:Connect(function()
	if not Settings.NoRecoilEnabled then return end
	local now = os.clock()
	if now - _lastNoRecoil < 0.12 then return end
	_lastNoRecoil = now
	local char = LocalPlayer.Character
	if char then
		local tool = char:FindFirstChildOfClass("Tool")
		if tool and IsGun(tool) then
			ApplyNoRecoil(tool)
		end
	end
end)


------------------------------------------------------------------
-- SUPER JUMP NORMAL (configurable en P)
------------------------------------------------------------------
local _lastSuperJump = 0
RunService.Heartbeat:Connect(function()
	if not Settings.SuperJumpEnabled then return end
	local now = os.clock()
	if now - _lastSuperJump < 0.25 then return end
	_lastSuperJump = now
	local char = LocalPlayer.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then return end
	pcall(function()
		if hum.UseJumpPower then
			hum.JumpPower = 120
		else
			hum.JumpHeight = 15
		end
	end)
end)

------------------------------------------------------------------
-- MACRO RESET
------------------------------------------------------------------
local macroBusy = false
local function sendKey(keyCode, pressTime)
	pressTime = pressTime or 0.02
	local ok = pcall(function()
		local vim = game:GetService("VirtualInputManager")
		vim:SendKeyEvent(true, keyCode, false, game)
		task.wait(pressTime)
		vim:SendKeyEvent(false, keyCode, false, game)
	end)
	if ok then return true end
	local codes = {[Enum.KeyCode.Escape]=0x1B,[Enum.KeyCode.R]=0x52,[Enum.KeyCode.Return]=0x0D}
	local vk = codes[keyCode]
	if vk and type(keypress)=="function" and type(keyrelease)=="function" then
		pcall(function() keypress(vk) task.wait(pressTime) keyrelease(vk) end)
		return true
	end
	return false
end

local function runResetMacro()
	if macroBusy then return end
	macroBusy = true
	task.spawn(function()
		sendKey(Enum.KeyCode.Escape, 0.006)
		task.wait(0.012)
		sendKey(Enum.KeyCode.R, 0.006)
		task.wait(0.012)
		sendKey(Enum.KeyCode.Return, 0.006)
		task.wait(0.02)
		macroBusy = false
	end)
end

local function SaveConfig(silent)
	local data = {
		FOV = Settings.FOV,
		FOVThickness = Settings.FOVThickness,
		NameColor = {Settings.NameColor.R, Settings.NameColor.G, Settings.NameColor.B},
		InfoColor = {Settings.InfoColor.R, Settings.InfoColor.G, Settings.InfoColor.B},
		Friends = Settings.Friends,
		AlternateAim = Settings.AlternateAim,
		AlternateInterval = Settings.AlternateInterval,
		AimPartMode = Settings.AimPartMode,
		TracersEnabled = Settings.TracersEnabled,
		HighlightEnabled = Settings.HighlightEnabled,
		Informacion = Settings.Informacion,
		WeaponIconESP = Settings.WeaponIconESP,
		NoRecoilEnabled = Settings.NoRecoilEnabled,
		VehicleAimEnabled = Settings.VehicleAimEnabled,
		VehicleAimOffsetX = Settings.VehicleAimOffsetX,
		VehicleAimOffsetY = Settings.VehicleAimOffsetY,
		PredictionEnabled = Settings.PredictionEnabled,
		PredictionFactor = Settings.PredictionFactor,
		DroppedItemsESP = Settings.DroppedItemsESP,
		SkeletonESP = Settings.SkeletonESP,
		SuperJumpEnabled = Settings.SuperJumpEnabled,
		JumpPowerValue = Settings.JumpPowerValue,
		ESPEnabled = true,
		FullMenuKey = keyName(Settings.FullMenuKey),
		AimMenuKey = keyName(Settings.AimMenuKey),
		FriendsKey = keyName(Settings.FriendsKey),
		AimKey = keyName(Settings.AimKey),
		ESPKey = keyName(Settings.ESPKey),
		MacroKey = keyName(Settings.MacroKey),
		Smoothness = Settings.Smoothness,
		MaxDistance = Settings.MaxDistance,
		AimMode = Settings.AimMode,
		AimStrength = Settings.AimStrength,
		ChamsColorIndex = chamsColorIndex,
		ScreenScale = Settings.ScreenScale,
		MenuMaxW = Settings.MenuMaxW,
		MenuMaxH = Settings.MenuMaxH,
	}
	local wf = getWriteFile()
	local ok = false
	if type(wf) == "function" then
		ok = pcall(function() wf(CONFIG_FILE, HttpService:JSONEncode(data)) end)
	end
	if not silent then
		pcall(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Config", Text = ok and "Guardado ✓" or "No se pudo guardar", Duration = 2
			})
		end)
	end
	return ok
end

local function LoadConfig()
	Settings.ESPEnabled = true
	local rf, isf = getReadFile(), getIsFile()
	local success, result = pcall(function()
		if type(isf) == "function" and type(rf) == "function" and isf(CONFIG_FILE) then
			return HttpService:JSONDecode(rf(CONFIG_FILE))
		end
	end)
	if success and type(result) == "table" then
		if result.FOV then Settings.FOV = result.FOV end
		if type(result.FOVThickness) == "number" then Settings.FOVThickness = math.clamp(result.FOVThickness, 1, 15) end
		if result.NameColor then Settings.NameColor = Color3.new(result.NameColor[1], result.NameColor[2], result.NameColor[3]) end
		if result.InfoColor then Settings.InfoColor = Color3.new(result.InfoColor[1], result.InfoColor[2], result.InfoColor[3]) end
		if result.Friends then Settings.Friends = result.Friends end
		if result.AlternateAim ~= nil then Settings.AlternateAim = result.AlternateAim end
		if type(result.AlternateInterval) == "number" then
			Settings.AlternateInterval = math.clamp(result.AlternateInterval, 0.15, 2)
		end
		if type(result.AimPartMode) == "string" and (result.AimPartMode == "Head" or result.AimPartMode == "Chest" or result.AimPartMode == "Alternate") then
			Settings.AimPartMode = result.AimPartMode
			Settings.AlternateAim = (result.AimPartMode == "Alternate")
		end
		if result.TracersEnabled ~= nil then Settings.TracersEnabled = result.TracersEnabled end
		if result.HighlightEnabled ~= nil then Settings.HighlightEnabled = result.HighlightEnabled end
		if result.Informacion ~= nil then Settings.Informacion = result.Informacion end
		if result.WeaponIconESP ~= nil then Settings.WeaponIconESP = result.WeaponIconESP end
		if result.NoRecoilEnabled ~= nil then Settings.NoRecoilEnabled = result.NoRecoilEnabled end
		if result.PredictionEnabled ~= nil then Settings.PredictionEnabled = result.PredictionEnabled end
		if result.DroppedItemsESP ~= nil then Settings.DroppedItemsESP = result.DroppedItemsESP end
		if result.SkeletonESP ~= nil then Settings.SkeletonESP = result.SkeletonESP end
		if result.SuperJumpEnabled ~= nil then Settings.SuperJumpEnabled = result.SuperJumpEnabled end
		if type(result.JumpPowerValue) == "number" then Settings.JumpPowerValue = math.clamp(result.JumpPowerValue, 20, 200) end
		if type(result.PredictionFactor) == "number" then
			Settings.PredictionFactor = math.clamp(result.PredictionFactor, 0.02, 0.45)
		end
		Settings.VehicleAimEnabled = true
		if type(result.VehicleAimOffsetX) == "number" then Settings.VehicleAimOffsetX = result.VehicleAimOffsetX end
		if type(result.VehicleAimOffsetY) == "number" then Settings.VehicleAimOffsetY = result.VehicleAimOffsetY end
		Settings.ESPEnabled = true
		if result.Smoothness then Settings.Smoothness = result.Smoothness end
		if result.MaxDistance then Settings.MaxDistance = result.MaxDistance end
		if type(result.AimMode) == "string" and (result.AimMode=="Hold" or result.AimMode=="Toggle" or result.AimMode=="Always") then
			Settings.AimMode = result.AimMode
		end
		if type(result.AimStrength) == "number" then Settings.AimStrength = math.clamp(result.AimStrength, 0.3, 1) end
		Settings.FullMenuKey = resolveKey(result.FullMenuKey, Enum.KeyCode.G)
		Settings.AimMenuKey = resolveKey(result.AimMenuKey, Enum.KeyCode.P)
		Settings.FriendsKey = resolveKey(result.FriendsKey, Enum.KeyCode.U)
		Settings.AimKey = resolveKey(result.AimKey, Enum.KeyCode.F)
		Settings.ESPKey = resolveKey(result.ESPKey, Enum.KeyCode.T)
		Settings.MacroKey = resolveKey(result.MacroKey, Enum.KeyCode.M)
		if type(result.ChamsColorIndex) == "number" then
			chamsColorIndex = math.clamp(math.floor(result.ChamsColorIndex), 1, #CHAMS_COLORS)
		end
		Settings.ScreenScale = 1
		if type(result.MenuMaxW) == "number" then Settings.MenuMaxW = result.MenuMaxW end
		if type(result.MenuMaxH) == "number" then Settings.MenuMaxH = result.MenuMaxH end
	end
end
LoadConfig()

local ToolNamesCache = {}
local RarityColors = {
	["Legendary"] = Color3.fromRGB(255, 215, 0),
	["Epic"] = Color3.fromRGB(128, 0, 128),
	["Rare"] = Color3.fromRGB(0, 120, 255),
	["Uncommon"] = Color3.fromRGB(180, 180, 180),
	["Omega"] = Color3.fromRGB(0, 255, 255),
	["Common"] = Color3.fromRGB(160, 160, 160),
}

local function buildToolCache()
	for _, source in pairs({ReplicatedStorage, StarterPack}) do
		pcall(function()
			for _, tool in pairs(source:GetDescendants()) do
				if tool:IsA("Tool") and not tonumber(tool.Name) then
					local handle = tool:FindFirstChild("Handle")
					local mesh = handle and (handle:FindFirstChildOfClass("SpecialMesh") or (handle:IsA("MeshPart") and handle))
					if mesh and mesh.MeshId and mesh.MeshId ~= "" then
						ToolNamesCache[mesh.MeshId] = tool.Name
					end
				end
			end
		end)
	end
end

local function getAnalyzedInfo(tool)
	if not tool or not tool:IsA("Tool") then return nil end
	local rarity = tool:GetAttribute("RarityName") or tool:GetAttribute("Rarity")
	if not rarity or rarity == "Common" or rarity == "Común" then return nil end
	local color = RarityColors[rarity] or Color3.new(1, 1, 1)
	local name = tool.Name
	if tonumber(name) then
		local handle = tool:FindFirstChild("Handle")
		local mesh = handle and (handle:FindFirstChildOfClass("SpecialMesh") or (handle:IsA("MeshPart") and handle))
		if mesh then name = ToolNamesCache[mesh.MeshId] or name end
	end
	local low = string.lower(tostring(name))
	if low:find("fist") or low:find("puño") or low:find("puno") then return nil end
	return {Text = name, Color = color, Rarity = rarity}
end

local ESPObjects, TracerObjects, HighlightObjects = {}, {}, {}
local AimbotHolding, AimbotEnabled, LocalRoot = false, false, nil
local LockedTargetPart, LockedTargetPlayer = nil, nil
local LastChamsUpdate, CHAMS_INTERVAL = 0, 0.04
local AlternateTimer, AimAtHead = 0, true
local lastInfoUpdate, infoUpdateInterval = 0, 0
local AIM_MODES = {"Hold", "Toggle", "Always"}
local AIM_MODE_LABELS = { Hold = "MANTENER", Toggle = "TOGGLE", Always = "SIEMPRE" }
local AimModeBtn
local UpdateChams

local function isAimActive()
	if Settings.AimMode == "Always" then return true end
	if Settings.AimMode == "Toggle" then return AimbotEnabled end
	return AimbotHolding
end

local function safeDrawing(className)
	local ok, obj = pcall(function() return Drawing.new(className) end)
	if ok and obj then pcall(function() obj.Visible = false end) return obj end
	return nil
end

local FOVCircle = safeDrawing("Circle")
if FOVCircle then
	pcall(function()
		FOVCircle.Thickness = 5
		FOVCircle.NumSides = 64
		FOVCircle.Radius = Settings.FOV
		FOVCircle.Filled = false
		FOVCircle.Color = Color3.fromRGB(100, 200, 255)
		FOVCircle.Transparency = 0.2
		FOVCircle.Visible = false
	end)
end

pcall(function()
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if pg and pg:FindFirstChild("FourKTMenu") then pg.FourKTMenu:Destroy() end
	if CoreGui:FindFirstChild("FourKTMenu") then CoreGui.FourKTMenu:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FourKTMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999
ScreenGui.IgnoreGuiInset = true
pcall(function() ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 5) end)
if not ScreenGui.Parent then pcall(function() ScreenGui.Parent = CoreGui end) end

UIScale = Instance.new("UIScale")
UIScale.Scale = 1
UIScale.Parent = ScreenGui
Settings.ScreenScale = 1

local function addSnow(panel)
	local folder = Instance.new("Folder")
	folder.Name = "Snow"
	folder.Parent = panel
	panel.ClipsDescendants = true
	local flakes = {}
	for i = 1, 36 do
		local f = Instance.new("TextLabel")
		f.BackgroundTransparency = 1
		f.Size = UDim2.fromOffset(math.random(12,20), math.random(12,20))
		f.Position = UDim2.fromOffset(math.random(0,320), math.random(-30,-5))
		f.Text = math.random(1,2) == 1 and "❄" or "✦"
		f.TextColor3 = Color3.fromRGB(255, 255, 255)
		f.TextTransparency = math.random(0,18)/100
		f.TextSize = math.random(13,20)
		f.Font = Enum.Font.GothamBold
		f.ZIndex = 3
		f.Parent = folder
		table.insert(flakes, {Label=f, Speed=math.random(25,60)/100, Drift=math.random(-14,14)/100, Y=f.Position.Y.Offset, X=f.Position.X.Offset})
	end
	local watermark = Instance.new("TextLabel")
	watermark.Name = "Watermark"
	watermark.Size = UDim2.new(1, 0, 0, 36)
	watermark.Position = UDim2.new(0, 0, 0.5, -18)
	watermark.BackgroundTransparency = 1
	watermark.Text = "4KT ON TOP"
	watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
	watermark.TextTransparency = 0.25
	watermark.Font = Enum.Font.GothamBlack
	watermark.TextSize = 22
	watermark.ZIndex = 2
	watermark.Parent = panel

	RunService.RenderStepped:Connect(function(dt)
		if not panel.Visible then return end
		for _, s in ipairs(flakes) do
			s.Y = s.Y + s.Speed * 60 * dt
			s.X = s.X + s.Drift * 25 * dt
			if s.Y > panel.AbsoluteSize.Y + 20 then s.Y = math.random(-30,-5) s.X = math.random(0,320) end
			if s.X < -10 then s.X = 330 end
			if s.X > 340 then s.X = -10 end
			s.Label.Position = UDim2.fromOffset(s.X, s.Y)
		end
	end)
end

local function CreateBtn(parent, text, y, color, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -16, 0, 44)
	btn.Position = UDim2.fromOffset(10, y)
	btn.BackgroundColor3 = color
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(245, 245, 250)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextWrapped = false
	btn.AutoButtonColor = false
	btn.ZIndex = 5
	btn.AutoButtonColor = true
	btn.Parent = parent
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
	if callback then
		local busy = false
		local function fire()
			if busy then return end
			busy = true
			pcall(callback)
			task.delay(0.12, function() busy = false end)
		end
		btn.MouseButton1Click:Connect(fire)
		btn.Activated:Connect(fire)
	end
	return btn
end

local function makePanel(sizeY)
	local width = 360
	local p = Instance.new("Frame")
	p.Size = UDim2.fromOffset(width, sizeY)
	p.Position = UDim2.new(0.5, -width/2, 0.5, -sizeY/2)
	p.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
	p.BorderSizePixel = 0
	p.Visible = false
	p.Parent = ScreenGui
	Instance.new("UICorner", p).CornerRadius = UDim.new(0, 14)
	local st = Instance.new("UIStroke")
	st.Color = Color3.fromRGB(55, 55, 60)
	st.Thickness = 1.5
	st.Parent = p
	p:SetAttribute("BaseSizeX", width)
	p:SetAttribute("BaseSizeY", sizeY)
	addSnow(p)
	return p
end

local function openPanel(panel)
	if not panel then return end
	if panel ~= FullPanel and FullPanel then FullPanel.Visible = false end
	if panel ~= AimPanel and AimPanel then AimPanel.Visible = false end
	if panel ~= FriendsPanel and FriendsPanel then FriendsPanel.Visible = false end
	if panel ~= InfoPanel and InfoPanel then InfoPanel.Visible = false end
	local w = panel:GetAttribute("BaseSizeX") or 360
	local h = panel:GetAttribute("BaseSizeY") or 420
	panel.AnchorPoint = Vector2.new(0, 0)
	panel.Visible = true
	panel.BackgroundTransparency = 0
	panel.Size = UDim2.fromOffset(w, h)
	local vs = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(400, 700)
	panel.Position = UDim2.fromOffset(math.floor((vs.X - w) / 2), math.floor((vs.Y - h) / 2))
end

local function closePanel(panel)
	if not panel or not panel.Visible then return end
	local w = panel:GetAttribute("BaseSizeX") or 340
	local h = panel:GetAttribute("BaseSizeY") or 400
	local tween = TweenService:Create(panel, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.fromOffset(math.floor(w*0.88), math.floor(h*0.88)),
		BackgroundTransparency = 0.45
	})
	tween:Play()
	tween.Completed:Connect(function()
		panel.Visible = false
		panel.Size = UDim2.fromOffset(w, h)
		panel.Position = UDim2.fromScale(0.5, 0.5)
		panel.BackgroundTransparency = 0
	end)
end

local function togglePanel(panel)
	if panel.Visible then closePanel(panel) else openPanel(panel) end
end

local function makeResizable(panel)
	if not panel then return end
	local handle = Instance.new("TextButton")
	handle.Name = "ResizeHandle"
	handle.Size = UDim2.fromOffset(24, 24)
	handle.Position = UDim2.new(1, -28, 1, -28)
	handle.BackgroundColor3 = Color3.fromRGB(70, 70, 78)
	handle.BorderSizePixel = 0
	handle.Text = "↘"
	handle.TextColor3 = Color3.new(1,1,1)
	handle.TextSize = 14
	handle.Font = Enum.Font.GothamBold
	handle.ZIndex = 25
	handle.Parent = panel
	Instance.new("UICorner", handle).CornerRadius = UDim.new(0, 6)
	local resizing, startPos, startSize = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			startPos = input.Position
			startSize = panel.AbsoluteSize
		end
	end)
	handle.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = false
			panel:SetAttribute("BaseSizeX", panel.AbsoluteSize.X)
			panel:SetAttribute("BaseSizeY", panel.AbsoluteSize.Y)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not resizing then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local delta = input.Position - startPos
		local newW = math.clamp(startSize.X + delta.X, Settings.MenuMinW, Settings.MenuMaxW)
		local newH = math.clamp(startSize.Y + delta.Y, Settings.MenuMinH, Settings.MenuMaxH)
		panel.Size = UDim2.fromOffset(newW, newH)
		-- no mover posición al centro (evita que salte)
	end)
end

local function makeTitle(parent, text)
	local t = Instance.new("TextLabel")
	t.Size = UDim2.new(1, 0, 0, 40)
	t.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	t.BorderSizePixel = 0
	t.Text = "  " .. text
	t.TextColor3 = Color3.fromRGB(230, 230, 235)
	t.Font = Enum.Font.GothamBold
	t.TextSize = 14
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.ZIndex = 5
	t.Parent = parent
	Instance.new("UICorner", t).CornerRadius = UDim.new(0, 14)
	-- botón X cerrar (estilo captura)
	local xbtn = Instance.new("TextButton")
	xbtn.Size = UDim2.fromOffset(32, 28)
	xbtn.Position = UDim2.new(1, -38, 0, 6)
	xbtn.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
	xbtn.BorderSizePixel = 0
	xbtn.Text = "X"
	xbtn.TextColor3 = Color3.fromRGB(220, 220, 220)
	xbtn.Font = Enum.Font.GothamBold
	xbtn.TextSize = 14
	xbtn.ZIndex = 6
	xbtn.Parent = t
	Instance.new("UICorner", xbtn).CornerRadius = UDim.new(0, 8)
	xbtn.MouseButton1Click:Connect(function()
		if parent and parent.Visible then
			parent.Visible = false
		end
	end)

	-- Arrastrar menú desde el título (sin saltar)
	local dragging = false
	local dragStart = nil
	local startPos = nil
	t.Active = true
	t.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = parent.AbsolutePosition
			parent.AnchorPoint = Vector2.new(0, 0)
		end
	end)
	t.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging or not parent.Visible then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local delta = input.Position - dragStart
		parent.Position = UDim2.fromOffset(startPos.X + delta.X, startPos.Y + delta.Y)
	end)

	return t
end

local onC, offC = Color3.fromRGB(30, 140, 60), Color3.fromRGB(28, 28, 32)
local function toggleBtn(parent, y, flag, onText, offText, onColor, offColor, callback)
	local btn = CreateBtn(parent, Settings[flag] and onText or offText, y, Settings[flag] and onColor or offColor, function() end)
	btn.MouseButton1Click:Connect(function()
		Settings[flag] = not Settings[flag]
		btn.Text = Settings[flag] and onText or offText
		btn.BackgroundColor3 = Settings[flag] and onColor or offColor
		if callback then callback() end
	end)
	return btn
end

local function refreshChamsColorUI()
	local idx = math.clamp(chamsColorIndex, 1, #CHAMS_COLORS)
	local entry = CHAMS_COLORS[idx]
	local label = "COLOR DE CHAMS: " .. entry.Name
	local col = entry.Color
	local darkText = (idx == 1 or idx == 3 or idx == 5)
	local textCol = darkText and Color3.fromRGB(10,10,10) or Color3.fromRGB(255,255,255)
	if ChamsColorBtn2 then
		ChamsColorBtn2.Text = label
		ChamsColorBtn2.BackgroundColor3 = col
		ChamsColorBtn2.TextColor3 = textCol
	end
end

local function cycleChamsColor()
	chamsColorIndex = (chamsColorIndex % #CHAMS_COLORS) + 1
	Settings.ChamsColorIndex = chamsColorIndex
	refreshChamsColorUI()
end

------------------------------------------------------------------
-- G = Teclas
------------------------------------------------------------------
FullPanel = makePanel(360)
makeTitle(FullPanel, "4KT SCRIPT — Teclas (G)")

CreateBtn(FullPanel, "Nombre Blanco", 52, Color3.fromRGB(50, 50, 56), function()
	Settings.NameColor = Color3.fromRGB(255,255,255)
end)
CreateBtn(FullPanel, "Nombre Rojo", 92, Color3.fromRGB(140,40,50), function()
	Settings.NameColor = Color3.fromRGB(255,80,80)
end)

local function refreshKeyBtns()
	for name, btn in pairs(keyBtnRefs) do
		if waitingForKey == name then
			btn.Text = "Pulsa tecla... (Esc cancela)"
			btn.BackgroundColor3 = Color3.fromRGB(48, 48, 54)
		else
			local labels = {
				FullMenuKey="Menú Completo", AimMenuKey="Menú Aimbot", FriendsKey="Menú Amigos",
				AimKey="Aimbot", ESPKey="ESP", MacroKey="Macro Reset"
			}
			btn.Text = (labels[name] or name) .. ": [" .. keyName(Settings[name]) .. "]"
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
		end
	end
end

local function makeKeyBtn(parent, settingName, y)
	local btn = CreateBtn(parent, "", y, Color3.fromRGB(40, 40, 46), function()
		waitingForKey = (waitingForKey == settingName) and nil or settingName
		refreshKeyBtns()
	end)
	keyBtnRefs[settingName] = btn
	return btn
end

makeKeyBtn(FullPanel, "FullMenuKey", 132)
makeKeyBtn(FullPanel, "AimMenuKey", 172)
makeKeyBtn(FullPanel, "FriendsKey", 212)
makeKeyBtn(FullPanel, "AimKey", 252)
makeKeyBtn(FullPanel, "ESPKey", 292)
makeKeyBtn(FullPanel, "MacroKey", 332)
refreshKeyBtns()
CreateBtn(FullPanel, "💾 Guardar Config", 372, Color3.fromRGB(48, 48, 54), function() SaveConfig(false) end)

------------------------------------------------------------------
-- P = Aimbot (Tiempo de Alternar + Super Jump)
------------------------------------------------------------------
AimPanel = makePanel(480)
makeTitle(AimPanel, "4KT SCRIPT — Aimbot (P)")

AimModeBtn = CreateBtn(AimPanel, "Modo Aimbot: " .. (AIM_MODE_LABELS[Settings.AimMode] or Settings.AimMode), 48, Color3.fromRGB(52, 52, 58), function()
	local idx = 1
	for i, m in ipairs(AIM_MODES) do if m == Settings.AimMode then idx = i break end end
	Settings.AimMode = AIM_MODES[(idx % #AIM_MODES) + 1]
	AimbotHolding = false
	AimbotEnabled = (Settings.AimMode == "Always")
	LockedTargetPart, LockedTargetPlayer = nil, nil
	AimModeBtn.Text = "Modo Aimbot: " .. (AIM_MODE_LABELS[Settings.AimMode] or Settings.AimMode)
	SaveConfig(true)
end)
if Settings.AimMode == "Always" then AimbotEnabled = true end

local FOVBox2 = Instance.new("TextBox")
FOVBox2.Size = UDim2.new(1,-16,0,28)
FOVBox2.Position = UDim2.fromOffset(10, 92)
FOVBox2.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
FOVBox2.BorderSizePixel = 0
FOVBox2.Text = tostring(Settings.FOV)
FOVBox2.TextColor3 = Color3.new(1,1,1)
FOVBox2.Font = Enum.Font.Gotham
FOVBox2.TextSize = 12
FOVBox2.ZIndex = 5
FOVBox2.Parent = AimPanel
Instance.new("UICorner", FOVBox2).CornerRadius = UDim.new(0,8)
FOVBox2.FocusLost:Connect(function()
	local n = tonumber(FOVBox2.Text)
	if n and n > 20 and n < 900 then
		Settings.FOV = n
		if FOVCircle then pcall(function() FOVCircle.Radius = n end) end
	else FOVBox2.Text = tostring(Settings.FOV) end
end)

toggleBtn(AimPanel, 190, "TracersEnabled", "Tracers : ON", "Tracers : OFF", onC, offC)
toggleBtn(AimPanel, 238, "HighlightEnabled", "Chams : ON", "Chams : OFF", onC, offC, function()
	if not Settings.HighlightEnabled then
		for _,h in pairs(HighlightObjects) do if h then pcall(function() h.Enabled=false end) end end
	elseif UpdateChams then UpdateChams() end
end)
toggleBtn(AimPanel, 286, "NoRecoilEnabled", "No Recoil : ON", "No Recoil : OFF", onC, offC, function()
	SaveConfig(true)
end)
toggleBtn(AimPanel, 334, "PredictionEnabled", "Predicción RPG : ON", "Predicción RPG : OFF", onC, offC, function()
	SaveConfig(true)
end)

ChamsColorBtn2 = CreateBtn(AimPanel, "COLOR DE CHAMS: " .. CHAMS_COLORS[chamsColorIndex].Name, 382, Color3.fromRGB(50, 50, 56), function()
	cycleChamsColor()
	if UpdateChams then UpdateChams() end
	SaveConfig(true)
end)
refreshChamsColorUI()

toggleBtn(AimPanel, 430, "Informacion", "INFO Armas : ON", "INFO Armas : OFF", onC, offC)
toggleBtn(AimPanel, 478, "WeaponIconESP", "Icono Arma : ON", "Icono Arma : OFF", onC, offC, function()
	SaveConfig(true)
end)
toggleBtn(AimPanel, 526, "AlternateAim", "Alternar Pecho / Cabeza : ON", "Alternar Pecho / Cabeza : OFF", onC, offC)
toggleBtn(AimPanel, 574, "SkeletonESP", "Skeleton ESP : ON", "Skeleton ESP : OFF", onC, offC, function()
	if Settings.SkeletonESP then
		Settings.HighlightEnabled = false
		if UpdateChams then pcall(UpdateChams) end
		-- actualizar botón de Chams en el menú
		pcall(function()
			local root = AimPanel:FindFirstChild("AimScroll") or AimPanel
			for _, c in ipairs(root:GetDescendants()) do
				if c:IsA("TextButton") and typeof(c.Text) == "string" and c.Text:find("Chams") then
					c.Text = "Chams : OFF"
					c.BackgroundColor3 = offC
				end
			end
			for _, c in ipairs(AimPanel:GetDescendants()) do
				if c:IsA("TextButton") and typeof(c.Text) == "string" and c.Text:find("Chams") then
					c.Text = "Chams : OFF"
					c.BackgroundColor3 = offC
				end
			end
		end)
	end
	SaveConfig(true)
end)

toggleBtn(AimPanel, 618, "SuperJumpEnabled", "Super Jump : ON", "Super Jump : OFF", onC, offC, function()
	SaveConfig(true)
end)
CreateBtn(AimPanel, "Macro Reset [M]", 656, Color3.fromRGB(50, 50, 54), function() runResetMacro() end)

------------------------------------------------------------------
-- SECCIÓN ABAJO: APUNTAR A + 3 OPCIONES TIEMPO DE ALTERNAR
------------------------------------------------------------------
local AimPartLabel = Instance.new("TextLabel")
AimPartLabel.Size = UDim2.new(1, -20, 0, 16)
AimPartLabel.Position = UDim2.fromOffset(10, 700)
AimPartLabel.BackgroundTransparency = 1
AimPartLabel.Text = "Apuntar a:"
AimPartLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
AimPartLabel.Font = Enum.Font.Gotham
AimPartLabel.TextSize = 12
AimPartLabel.TextXAlignment = Enum.TextXAlignment.Left
AimPartLabel.ZIndex = 5
AimPartLabel.Parent = AimPanel

local AimPartHeadBtn, AimPartChestBtn, AimPartAltBtn
local function refreshAimPartBtns()
	local mode = Settings.AimPartMode or "Alternate"
	local sel = Color3.fromRGB(30, 140, 60)
	local unsel = Color3.fromRGB(28, 28, 32)
	if AimPartHeadBtn then
		AimPartHeadBtn.BackgroundColor3 = (mode == "Head") and sel or unsel
		AimPartHeadBtn.Text = (mode == "Head") and "● Cabeza" or "Cabeza"
	end
	if AimPartChestBtn then
		AimPartChestBtn.BackgroundColor3 = (mode == "Chest") and sel or unsel
		AimPartChestBtn.Text = (mode == "Chest") and "● Pecho" or "Pecho"
	end
	if AimPartAltBtn then
		AimPartAltBtn.BackgroundColor3 = (mode == "Alternate") and sel or unsel
		AimPartAltBtn.Text = (mode == "Alternate") and "● Alternar" or "Alternar"
	end
end

local function setAimPartMode(mode)
	Settings.AimPartMode = mode
	Settings.AlternateAim = (mode == "Alternate")
	if mode == "Head" then AimAtHead = true
	elseif mode == "Chest" then AimAtHead = false
	end
	refreshAimPartBtns()
	SaveConfig(true)
end

AimPartHeadBtn = CreateBtn(AimPanel, "Cabeza", 720, Color3.fromRGB(40, 40, 46), function() setAimPartMode("Head") end)
AimPartHeadBtn.Size = UDim2.new(0.30, -14, 0, 26)
AimPartHeadBtn.Position = UDim2.fromOffset(10, 720)

AimPartChestBtn = CreateBtn(AimPanel, "Pecho", 720, Color3.fromRGB(40, 40, 46), function() setAimPartMode("Chest") end)
AimPartChestBtn.Size = UDim2.new(0.30, -14, 0, 26)
AimPartChestBtn.Position = UDim2.new(0.35, 0, 0, 720)

AimPartAltBtn = CreateBtn(AimPanel, "Alternar", 720, Color3.fromRGB(40, 40, 46), function() setAimPartMode("Alternate") end)
AimPartAltBtn.Size = UDim2.new(0.30, -14, 0, 26)
AimPartAltBtn.Position = UDim2.new(0.68, 0, 0, 720)

if Settings.AlternateAim then
	Settings.AimPartMode = "Alternate"
end
refreshAimPartBtns()

-- SECCIÓN 3 OPCIONES DE TIEMPO ALTERNAR
local AltTimeLabel = Instance.new("TextLabel")
AltTimeLabel.Size = UDim2.new(1, -20, 0, 16)
AltTimeLabel.Position = UDim2.fromOffset(10, 756)
AltTimeLabel.BackgroundTransparency = 1
AltTimeLabel.Text = "Tiempo de Alternar  ( Velocidad )"
AltTimeLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
AltTimeLabel.Font = Enum.Font.Gotham
AltTimeLabel.TextSize = 12
AltTimeLabel.TextXAlignment = Enum.TextXAlignment.Left
AltTimeLabel.ZIndex = 5
AltTimeLabel.Parent = AimPanel

local AltTime1Btn, AltTime2Btn, AltTime3Btn

local function refreshAltTimeBtns()
	local cur = Settings.AlternateInterval or 0.5
	local sel = Color3.fromRGB(30, 140, 60)
	local unsel = Color3.fromRGB(28, 28, 32)
	if AltTime1Btn then
		local active = math.abs(cur - 0.25) < 0.05
		AltTime1Btn.BackgroundColor3 = active and sel or unsel
		AltTime1Btn.Text = active and "● 0.25s (Rápido)" or "0.25s"
	end
	if AltTime2Btn then
		local active = math.abs(cur - 0.5) < 0.05
		AltTime2Btn.BackgroundColor3 = active and sel or unsel
		AltTime2Btn.Text = active and "● 0.5s (Normal)" or "0.5s"
	end
	if AltTime3Btn then
		local active = math.abs(cur - 1.0) < 0.05
		AltTime3Btn.BackgroundColor3 = active and sel or unsel
		AltTime3Btn.Text = active and "● 1.0s (Lento)" or "1.0s"
	end
end

local function setAltTime(val)
	Settings.AlternateInterval = val
	refreshAltTimeBtns()
	SaveConfig(true)
end

AltTime1Btn = CreateBtn(AimPanel, "0.25s", 776, Color3.fromRGB(40, 40, 46), function() setAltTime(0.25) end)
AltTime1Btn.Size = UDim2.new(0.30, -12, 0, 36)
AltTime1Btn.Position = UDim2.fromOffset(10, 776)

AltTime2Btn = CreateBtn(AimPanel, "0.5s", 776, Color3.fromRGB(40, 40, 46), function() setAltTime(0.5) end)
AltTime2Btn.Size = UDim2.new(0.30, -12, 0, 36)
AltTime2Btn.Position = UDim2.new(0.35, 0, 0, 776)

AltTime3Btn = CreateBtn(AimPanel, "1.0s", 776, Color3.fromRGB(40, 40, 46), function() setAltTime(1.0) end)
AltTime3Btn.Size = UDim2.new(0.30, -12, 0, 36)
AltTime3Btn.Position = UDim2.new(0.68, 0, 0, 776)

refreshAltTimeBtns()

CreateBtn(AimPanel, "💾  Guardar", 826, Color3.fromRGB(48, 48, 54), function() SaveConfig(false) end)

------------------------------------------------------------------
-- U = Amigos
------------------------------------------------------------------

-- Scroll en P (rueda del ratón) para ver todas las opciones
do
	local scroll = Instance.new("ScrollingFrame")
	scroll.Name = "AimScroll"
	scroll.Size = UDim2.new(1, -6, 1, -48)
	scroll.Position = UDim2.fromOffset(3, 44)
	scroll.BackgroundTransparency = 1
	scroll.BorderSizePixel = 0
	scroll.ScrollBarThickness = 6
	scroll.ScrollBarImageColor3 = Color3.fromRGB(140, 140, 150)
	scroll.CanvasSize = UDim2.fromOffset(0, 1100)
	scroll.ScrollingDirection = Enum.ScrollingDirection.Y
	scroll.ZIndex = 4
	scroll.Parent = AimPanel

	local pad = Instance.new("UIPadding")
	pad.PaddingBottom = UDim.new(0, 30)
	pad.Parent = scroll

	for _, child in ipairs(AimPanel:GetChildren()) do
		if child:IsA("GuiObject") and child.Name ~= "AimScroll" and not child:IsA("UICorner") and not child:IsA("UIStroke") then
			local isTitle = child:IsA("TextLabel") and child.Position.Y.Offset == 0 and child.Size.Y.Offset >= 32
			if child.Name == "ResizeHandle" then isTitle = true end
			if not isTitle then
				child.Parent = scroll
			end
		end
	end
end

FriendsPanel = makePanel(360)
makeTitle(FriendsPanel, "4KT SCRIPT — Amigos (U)")

local FriendStatus = Instance.new("TextLabel")
FriendStatus.Size = UDim2.new(1,-20,0,20)
FriendStatus.Position = UDim2.fromOffset(10,50)
FriendStatus.BackgroundTransparency = 1
FriendStatus.Text = "Jugadores del servidor (toca para amigo)"
FriendStatus.TextColor3 = Color3.fromRGB(200, 200, 210)
FriendStatus.Font = Enum.Font.Gotham
FriendStatus.TextSize = 12
FriendStatus.TextXAlignment = Enum.TextXAlignment.Left
FriendStatus.ZIndex = 5
FriendStatus.Parent = FriendsPanel

local FriendsList = Instance.new("ScrollingFrame")
FriendsList.Size = UDim2.new(1,-20,0,330)
FriendsList.Position = UDim2.fromOffset(10,76)
FriendsList.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
FriendsList.BorderSizePixel = 0
FriendsList.ScrollBarThickness = 5
FriendsList.CanvasSize = UDim2.fromOffset(0,0)
FriendsList.AutomaticCanvasSize = Enum.AutomaticSize.Y
FriendsList.ZIndex = 5
FriendsList.Parent = FriendsPanel
Instance.new("UICorner", FriendsList).CornerRadius = UDim.new(0,8)

local flLayout = Instance.new("UIListLayout")
flLayout.Padding = UDim.new(0,5)
flLayout.SortOrder = Enum.SortOrder.LayoutOrder
flLayout.Parent = FriendsList

local function isFriendName(name)
	if not name then return false end
	return Settings.Friends[tostring(name):lower():gsub("%s+","")] == true
end

local function setFriendName(name, on)
	local n = tostring(name):lower():gsub("%s+","")
	if n == "" then return end
	if on then Settings.Friends[n] = true else Settings.Friends[n] = nil end
end

local function RefreshFriendsListU()
	for _, c in pairs(FriendsList:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	local order = 0
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			order = order + 1
			local display = (plr.DisplayName and plr.DisplayName ~= "" and plr.DisplayName) or plr.Name
			local isF = isFriendName(display) or isFriendName(plr.Name)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1,-8,0,32)
			btn.BackgroundColor3 = isF and Color3.fromRGB(20, 70, 35) or Color3.fromRGB(40, 40, 48)
			btn.BorderSizePixel = 0
			btn.Text = isF and ("✓  " .. display .. "  [AMIGO]") or ("+  " .. display)
			btn.TextColor3 = isF and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(230, 240, 255)
			btn.Font = Enum.Font.GothamBold
			btn.TextSize = 13
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.ZIndex = 5
			btn.LayoutOrder = order
			btn.Parent = FriendsList
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
			local stroke = Instance.new("UIStroke")
			stroke.Color = isF and Color3.fromRGB(40, 200, 80) or Color3.fromRGB(120, 120, 130)
			stroke.Thickness = 1
			stroke.Parent = btn
			btn.MouseButton1Click:Connect(function()
				local now = isFriendName(display) or isFriendName(plr.Name)
				setFriendName(display, not now)
				setFriendName(plr.Name, not now)
				SaveConfig(true)
				RefreshFriendsListU()
				if UpdateChams then UpdateChams() end
			end)
		end
	end
	FriendStatus.Text = order == 0 and "No hay otros jugadores" or ("Jugadores: " .. order .. "  ·  toca para agregar/quitar")
end

Players.PlayerAdded:Connect(function() task.defer(RefreshFriendsListU) end)
Players.PlayerRemoving:Connect(function() task.defer(RefreshFriendsListU) end)
RefreshFriendsListU()


------------------------------------------------------------------

-- 8 = Info Usuario (panel amarillo)
------------------------------------------------------------------
InfoPanel = makePanel(420)
makeTitle(InfoPanel, "4KT SCRIPT — Info (8)")
-- fondo amarillo suave
pcall(function()
	InfoPanel.BackgroundColor3 = Color3.fromRGB(40, 36, 12)
end)

local function countryFlag(code)
	if not code or #code ~= 2 then return "🏳️" end
	code = code:upper()
	local a, b = code:byte(1), code:byte(2)
	if not a or not b then return "🏳️" end
	-- regional indicator symbols
	local function ri(c)
		return utf8.char(0x1F1E6 + (c - 65))
	end
	if a < 65 or a > 90 or b < 65 or b > 90 then return "🏳️" end
	return ri(a) .. ri(b)
end

local function getCountryCode()
	local code = "XX"
	pcall(function()
		local loc = game:GetService("LocalizationService")
		code = loc:GetCountryRegionForPlayerAsync(LocalPlayer) or "XX"
	end)
	return tostring(code)
end

local function getBlockSpinLevel()
	local level = "?"
	pcall(function()
		local ls = LocalPlayer:FindFirstChild("leaderstats")
		if ls then
			for _, v in pairs(ls:GetChildren()) do
				local n = string.lower(v.Name)
				if n:find("level") or n:find("lvl") or n:find("nivel") then
					level = tostring(v.Value)
					return
				end
			end
		end
		for _, attr in ipairs({"Level", "level", "Lvl", "PlayerLevel"}) do
			local v = LocalPlayer:GetAttribute(attr)
			if v ~= nil then level = tostring(v) return end
		end
		local char = LocalPlayer.Character
		if char then
			for _, attr in ipairs({"Level", "level"}) do
				local v = char:GetAttribute(attr)
				if v ~= nil then level = tostring(v) return end
			end
		end
	end)
	return level
end

local InfoAvatar = Instance.new("ImageLabel")
InfoAvatar.Size = UDim2.fromOffset(96, 96)
InfoAvatar.Position = UDim2.fromOffset(16, 48)
InfoAvatar.BackgroundColor3 = Color3.fromRGB(60, 50, 10)
InfoAvatar.BorderSizePixel = 0
InfoAvatar.ZIndex = 5
InfoAvatar.Parent = InfoPanel
Instance.new("UICorner", InfoAvatar).CornerRadius = UDim.new(0, 12)

local InfoLines = Instance.new("TextLabel")
InfoLines.Size = UDim2.new(1, -130, 0, 200)
InfoLines.Position = UDim2.fromOffset(124, 48)
InfoLines.BackgroundTransparency = 1
InfoLines.TextXAlignment = Enum.TextXAlignment.Left
InfoLines.TextYAlignment = Enum.TextYAlignment.Top
InfoLines.Font = Enum.Font.GothamBold
InfoLines.TextSize = 13
InfoLines.TextColor3 = Color3.fromRGB(255, 230, 80)
InfoLines.TextStrokeTransparency = 0.6
InfoLines.ZIndex = 5
InfoLines.Text = "Cargando..."
InfoLines.Parent = InfoPanel

local function refreshInfoPanel()
	local code = getCountryCode()
	local flag = countryFlag(code)
	local level = getBlockSpinLevel()
	local display = LocalPlayer.DisplayName or LocalPlayer.Name
	local user = LocalPlayer.Name
	local uid = tostring(LocalPlayer.UserId)
	InfoLines.Text = table.concat({
		"Usuario: " .. user,
		"Display: " .. display,
		"UserId: " .. uid,
		"País: " .. flag .. "  " .. code,
		"Nivel BlockSpin: " .. level,
		"",
		"Script: 4KT ON TOP",
	}, "\n")
	pcall(function()
		InfoAvatar.Image = Players:GetUserThumbnailAsync(
			LocalPlayer.UserId,
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size100x100
		)
	end)
end

CreateBtn(InfoPanel, "🔄 Actualizar info", 270, Color3.fromRGB(180, 140, 20), function()
	refreshInfoPanel()
end)
CreateBtn(InfoPanel, "Cerrar", 310, Color3.fromRGB(80, 60, 10), function()
	InfoPanel.Visible = false
end)

-- borde amarillo
pcall(function()
	local st = Instance.new("UIStroke")
	st.Color = Color3.fromRGB(255, 200, 40)
	st.Thickness = 2
	st.Parent = InfoPanel
end)

task.defer(refreshInfoPanel)

makeResizable(FullPanel)
makeResizable(AimPanel)
makeResizable(FriendsPanel)
makeResizable(InfoPanel)

------------------------------------------------------------------
-- SELECTOR PC / CELULAR + MENÚS FLOTANTES (móvil)
------------------------------------------------------------------
local DeviceMode = Settings.DeviceMode or "PC"
local MobileFloats = nil

local function destroyMobileFloats()
	if MobileFloats then
		pcall(function() MobileFloats:Destroy() end)
		MobileFloats = nil
	end
end

local function createMobileFloats()
	destroyMobileFloats()
	local gui = Instance.new("ScreenGui")
	gui.Name = "FourKT_MobileFloats"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 1000000
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function() gui.Parent = LocalPlayer:WaitForChild("PlayerGui", 3) end)
	if not gui.Parent then pcall(function() gui.Parent = CoreGui end) end
	MobileFloats = gui

	local function makeFloat(text, color, posY, onClick)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.fromOffset(54, 54)
		btn.Position = UDim2.new(1, -64, 0, posY)
		btn.BackgroundColor3 = color
		btn.BackgroundTransparency = 0.15
		btn.BorderSizePixel = 0
		btn.Text = text
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 16
		btn.ZIndex = 50
		btn.AutoButtonColor = true
		btn.Parent = gui
		Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(255, 255, 255)
		stroke.Thickness = 1
		stroke.Transparency = 0.5
		stroke.Parent = btn
		btn.MouseButton1Click:Connect(onClick)
		local dragging, dStart, pStart = false, nil, nil
		btn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dStart = input.Position
				pStart = btn.AbsolutePosition
			end
		end)
		btn.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if not dragging then return end
			if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
			local d = input.Position - dStart
			btn.Position = UDim2.fromOffset(pStart.X + d.X, pStart.Y + d.Y)
			btn.AnchorPoint = Vector2.new(0, 0)
		end)
		return btn
	end

	makeFloat("P", Color3.fromRGB(30, 120, 60), 160, function()
		if AimPanel then togglePanel(AimPanel) end
	end)
	makeFloat("G", Color3.fromRGB(50, 50, 120), 230, function()
		if FullPanel then togglePanel(FullPanel) end
	end)
	makeFloat("U", Color3.fromRGB(120, 50, 50), 300, function()
		if FriendsPanel then
			togglePanel(FriendsPanel)
			pcall(RefreshFriendsListU)
		end
	end)
end

local function applyDeviceMode(mode)
	DeviceMode = mode
	Settings.DeviceMode = mode
	pcall(function() SaveConfig(true) end)
	if mode == "Mobile" then
		createMobileFloats()
	else
		destroyMobileFloats()
	end
end


do
	local pick = Instance.new("ScreenGui")
	pick.Name = "FourKT_DevicePick"
	pick.ResetOnSpawn = false
	pick.IgnoreGuiInset = true
	pick.DisplayOrder = 10000000
	pcall(function() pick.Parent = LocalPlayer:WaitForChild("PlayerGui", 3) end)
	if not pick.Parent then pcall(function() pick.Parent = CoreGui end) end

	local bg = Instance.new("Frame")
	bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
	bg.BackgroundTransparency = 0.25
	bg.BorderSizePixel = 0
	bg.Parent = pick

	local card = Instance.new("Frame")
	card.AnchorPoint = Vector2.new(0.5, 0.5)
	card.Position = UDim2.fromScale(0.5, 0.5)
	card.Size = UDim2.fromOffset(380, 280)
	card.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
	card.BorderSizePixel = 0
	card.Parent = bg
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 20)
	local cardStroke = Instance.new("UIStroke")
	cardStroke.Color = Color3.fromRGB(70, 70, 90)
	cardStroke.Thickness = 1.5
	cardStroke.Transparency = 0.3
	cardStroke.Parent = card

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -24, 0, 36)
	title.Position = UDim2.fromOffset(12, 14)
	title.BackgroundTransparency = 1
	title.Text = "4KT ON TOP"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBlack
	title.TextSize = 22
	title.Parent = card

	local sub = Instance.new("TextLabel")
	sub.Size = UDim2.new(1, -24, 0, 22)
	sub.Position = UDim2.fromOffset(12, 48)
	sub.BackgroundTransparency = 1
	sub.Text = "Elige cómo quieres usar el script"
	sub.TextColor3 = Color3.fromRGB(160, 165, 180)
	sub.Font = Enum.Font.Gotham
	sub.TextSize = 13
	sub.Parent = card

	local function makeDeviceCard(label, imageId, color, x)
		local holder = Instance.new("TextButton")
		holder.Size = UDim2.fromOffset(150, 160)
		holder.Position = UDim2.fromOffset(x, 90)
		holder.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
		holder.BorderSizePixel = 0
		holder.Text = ""
		holder.AutoButtonColor = false
		holder.Parent = card
		Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 16)
		local st = Instance.new("UIStroke")
		st.Color = color
		st.Thickness = 2
		st.Transparency = 0.35
		st.Parent = holder

		local img = Instance.new("ImageLabel")
		img.Size = UDim2.fromOffset(72, 72)
		img.Position = UDim2.new(0.5, -36, 0, 22)
		img.BackgroundTransparency = 1
		img.Image = imageId
		img.ScaleType = Enum.ScaleType.Fit
		img.Parent = holder

		local txt = Instance.new("TextLabel")
		txt.Size = UDim2.new(1, -10, 0, 28)
		txt.Position = UDim2.new(0, 5, 1, -40)
		txt.BackgroundTransparency = 1
		txt.Text = label
		txt.TextColor3 = Color3.fromRGB(240, 240, 245)
		txt.Font = Enum.Font.GothamBold
		txt.TextSize = 16
		txt.Parent = holder

		holder.MouseEnter:Connect(function()
			st.Transparency = 0
			holder.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
		end)
		holder.MouseLeave:Connect(function()
			st.Transparency = 0.35
			holder.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
		end)

		return holder
	end

	-- Iconos oficiales-ish de Roblox (monitor / teléfono)
	local pcBtn = makeDeviceCard("PC", "rbxassetid://6034837797", Color3.fromRGB(70, 140, 255), 28)
	local mobBtn = makeDeviceCard("Celular", "rbxassetid://6034281891", Color3.fromRGB(60, 200, 100), 202)

	local chosen = false
	local function finish(mode)
		if chosen then return end
		chosen = true
		applyDeviceMode(mode)
		pcall(function() pick:Destroy() end)
	end

	pcBtn.MouseButton1Click:Connect(function() finish("PC") end)
	mobBtn.MouseButton1Click:Connect(function() finish("Mobile") end)
end


------------------------------------------------------------------
-- ESP / AIM / CHAMS
------------------------------------------------------------------
local function UpdateLocalRoot()
	LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end
LocalPlayer.CharacterAdded:Connect(UpdateLocalRoot)
UpdateLocalRoot()

local function IsAlive(p)
	local c = p.Character
	if not c then return false end
	local h = c:FindFirstChildOfClass("Humanoid")
	return h and h.Health > 0
end

local function IsFriend(p)
	local n = (p.DisplayName or p.Name):lower()
	return Settings.Friends[n] or Settings.Friends[p.Name:lower()]
end

local function GetTargetPart(char)
	if not char then return nil end
	local mode = Settings.AimPartMode or (Settings.AlternateAim and "Alternate" or "Head")
	if mode == "Chest" then
		return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
	elseif mode == "Alternate" or Settings.AlternateAim then
		if AimAtHead then
			return char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
		end
		return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
	end
	return char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
end

local function getPredictedPosition(targetPart, predictionFactor)
	if not targetPart then return nil end
	local ok, vel = pcall(function()
		return targetPart.AssemblyLinearVelocity
	end)
	if not ok or not vel then
		ok, vel = pcall(function() return targetPart.Velocity end)
	end
	if not ok or not vel then return targetPart.Position end
	return targetPart.Position + (vel * (predictionFactor or 0.13))
end

-- Predicción al PISO: anticipa movimiento y ray al suelo
local function GetGroundPredictPoint(character)
	if not character or not Settings.PredictionEnabled then return nil end
	local root = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not root or not humanoid or humanoid.Health <= 0 then return nil end
	local velocity = Vector3.zero
	pcall(function()
		velocity = root.AssemblyLinearVelocity or root.Velocity or Vector3.zero
	end)
	local factor = Settings.PredictionFactor or 0.13
	local predicted = root.Position + (velocity * factor)
	local rayOrigin = predicted + Vector3.new(0, 8, 0)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {character, LocalPlayer.Character}
	local hit = workspace:Raycast(rayOrigin, Vector3.new(0, -600, 0), params)
	if hit then
		return hit.Position + Vector3.new(0, 0.15, 0) -- un poco sobre el piso
	end
	return Vector3.new(predicted.X, predicted.Y - 3, predicted.Z)
end


local function scoreTarget(part, center, localPos)
	local sp, onScreen = Camera:WorldToViewportPoint(part.Position)
	if not onScreen or sp.Z <= 0 then return nil end
	local screenDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
	if screenDist > Settings.FOV then return nil end
	local worldDist = (part.Position - localPos).Magnitude
	if worldDist > Settings.MaxDistance then return nil end
	return (screenDist * 2.4) + (worldDist * 0.08)
end

local function isLocalInVehicle()
	local char = LocalPlayer.Character
	if not char then return false end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return false end
	return hum.Sit == true or hum.SeatPart ~= nil
end

local function GetClosestPlayer()
	local center = Camera.ViewportSize / 2
	local localPos = LocalRoot and LocalRoot.Position or Camera.CFrame.Position
	local inVehicle = isLocalInVehicle()
	local stickyMul = inVehicle and 2.9 or 1.6

	if LockedTargetPart and LockedTargetPart.Parent and LockedTargetPlayer and LockedTargetPlayer.Parent then
		if IsAlive(LockedTargetPlayer) and not IsFriend(LockedTargetPlayer) then
			local part = GetTargetPart(LockedTargetPlayer.Character) or LockedTargetPart
			if part and part.Parent then
				local worldDist = (part.Position - localPos).Magnitude
				if worldDist <= (Settings.MaxDistance or 800) then
					local sp, on = Camera:WorldToViewportPoint(part.Position)
					if sp.Z > 0 then
						local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
						if on and sd <= Settings.FOV * stickyMul then
							LockedTargetPart = part
							return part, LockedTargetPlayer
						end
						if inVehicle and sd <= Settings.FOV * (stickyMul + 0.8) then
							LockedTargetPart = part
							return part, LockedTargetPlayer
						end
					elseif inVehicle and worldDist < 250 then
						LockedTargetPart = part
						return part, LockedTargetPlayer
					end
				end
			end
		end
	end
	LockedTargetPart, LockedTargetPlayer = nil, nil
	local bestPart, bestPlayer, bestScore = nil, nil, math.huge
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and IsAlive(p) and not IsFriend(p) then
			local part = GetTargetPart(p.Character)
			if part then
				local score = scoreTarget(part, center, localPos)
				if score and score < bestScore then
					bestScore = score
					bestPart = part
					bestPlayer = p
				end
			end
		end
	end
	if bestPart then LockedTargetPart = bestPart LockedTargetPlayer = bestPlayer end
	return bestPart, bestPlayer
end


------------------------------------------------------------------
-- ESP ICONO DE ARMA (estilo slot inventario BlockSpin)
------------------------------------------------------------------
local WeaponIconCache = setmetatable({}, { __mode = "k" })

local function getEquippedTool(player)
	local char = player.Character
	if not char then return nil end
	return char:FindFirstChildOfClass("Tool")
end

local function getToolIcon(tool)
	if not tool then return "" end
	local tex = ""
	pcall(function()
		if tool.TextureId and tool.TextureId ~= "" then
			tex = tool.TextureId
		end
	end)
	if tex ~= "" then return tex end
	pcall(function()
		local handle = tool:FindFirstChild("Handle")
		if handle then
			local dec = handle:FindFirstChildOfClass("Decal")
			if dec and dec.Texture and dec.Texture ~= "" then
				tex = dec.Texture
			elseif handle:IsA("MeshPart") and handle.TextureID and handle.TextureID ~= "" then
				tex = handle.TextureID
			end
		end
	end)
	return tex
end

local function getToolDisplayName(tool)
	if not tool then return "?" end
	local name = tool.Name
	if tonumber(name) then
		local handle = tool:FindFirstChild("Handle")
		local mesh = handle and (handle:FindFirstChildOfClass("SpecialMesh") or (handle:IsA("MeshPart") and handle))
		if mesh and mesh.MeshId and ToolNamesCache[mesh.MeshId] then
			name = ToolNamesCache[mesh.MeshId]
		end
	end
	local low = string.lower(tostring(name))
	if low:find("fist") or low:find("puño") then return nil end
	return tostring(name)
end

local function getToolSlotColor(tool)
	-- colores estilo inventario (rareza)
	local rarity = nil
	pcall(function()
		rarity = tool:GetAttribute("RarityName") or tool:GetAttribute("Rarity")
	end)
	if rarity and RarityColors[rarity] then
		local c = RarityColors[rarity]
		return Color3.new(c.R * 0.55, c.G * 0.45, c.B * 0.7)
	end
	local n = string.lower(getToolDisplayName(tool) or "")
	if n:find("rpg") then return Color3.fromRGB(160, 110, 40) end
	if n:find("energy") or n:find("shot") then return Color3.fromRGB(110, 50, 160) end
	if n:find("bat") or n:find("barbed") then return Color3.fromRGB(100, 45, 140) end
	return Color3.fromRGB(90, 50, 140)
end

local function clearWeaponIcon(player)
	local gui = WeaponIconCache[player]
	if gui then
		pcall(function() gui:Destroy() end)
		WeaponIconCache[player] = nil
	end
end

local function makeWeaponSlotGui()
	local gui = Instance.new("BillboardGui")
	gui.Name = "FourKT_WeaponIcon"
	gui.Size = UDim2.fromOffset(38, 38)
	gui.StudsOffset = Vector3.new(0, 5.8, 0)
	gui.AlwaysOnTop = true
	gui.MaxDistance = 450

	local frame = Instance.new("Frame")
	frame.Name = "Slot"
	frame.Size = UDim2.fromScale(1, 1)
	frame.BackgroundColor3 = Color3.fromRGB(90, 50, 140)
	frame.BorderSizePixel = 0
	frame.Parent = gui
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Thickness = 1.2
	stroke.Transparency = 0.35
	stroke.Parent = frame

	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.Position = UDim2.new(0.5, 0, 0.42, 0)
	icon.Size = UDim2.fromOffset(22, 22)
	icon.BackgroundTransparency = 1
	icon.Image = ""
	icon.ScaleType = Enum.ScaleType.Fit
	icon.ZIndex = 2
	icon.Parent = frame

	local nameLab = Instance.new("TextLabel")
	nameLab.Name = "Name"
	nameLab.Size = UDim2.new(1, -6, 0, 16)
	nameLab.Position = UDim2.new(0, 3, 1, -18)
	nameLab.BackgroundTransparency = 1
	nameLab.Text = ""
	nameLab.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLab.TextStrokeTransparency = 0.5
	nameLab.Font = Enum.Font.GothamBold
	nameLab.TextSize = 8
	nameLab.TextScaled = true
	nameLab.ZIndex = 3
	nameLab.Parent = frame

	return gui
end

local function updateWeaponIcons()
	if not Settings.WeaponIconESP then
		for pl in pairs(WeaponIconCache) do
			clearWeaponIcon(pl)
		end
		return
	end
	local parentGui = ScreenGui
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl == LocalPlayer then continue end
		local char = pl.Character
		local head = char and (char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart"))
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local tool = getEquippedTool(pl)
		local dispName = tool and getToolDisplayName(tool)
		if head and hum and hum.Health > 0 and tool and dispName then
			local iconId = getToolIcon(tool)
			local gui = WeaponIconCache[pl]
			if not gui or not gui.Parent then
				gui = makeWeaponSlotGui()
				gui.Parent = parentGui
				WeaponIconCache[pl] = gui
			end
			gui.Adornee = head
			gui.Enabled = true
			do
				local myH = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				local inCar = myH and (myH.Sit or myH.SeatPart ~= nil)
				gui.StudsOffset = inCar and Vector3.new(0, 7.2, 0) or Vector3.new(0, 5.8, 0)
			end
			local slot = gui:FindFirstChild("Slot")
			if slot then
				slot.BackgroundColor3 = getToolSlotColor(tool)
				local icon = slot:FindFirstChild("Icon")
				local nameLab = slot:FindFirstChild("Name")
				if icon then
					icon.Image = iconId or ""
				end
				if nameLab then
					local short = dispName
					if #short > 12 then short = string.sub(short, 1, 11) .. "…" end
					nameLab.Text = short
				end
			end
		else
			local gui = WeaponIconCache[pl]
			if gui then gui.Enabled = false end
		end
	end
end

local _lastWeaponIcon = 0
RunService.Heartbeat:Connect(function()
	if not Settings.WeaponIconESP then return end
	local now = os.clock()
	if now - _lastWeaponIcon < 0.15 then return end
	_lastWeaponIcon = now
	updateWeaponIcons()
end)

Players.PlayerRemoving:Connect(function(pl)
	clearWeaponIcon(pl)
end)


------------------------------------------------------------------
-- DROPPED ITEMS ESP + SKELETON ESP (tecla L)
------------------------------------------------------------------
local DroppedESPCache = {}
local SkeletonCache = {}

local SKELETON_BONES = {
	{"Head", "UpperTorso"},
	{"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"},
	{"LeftUpperArm", "LeftLowerArm"},
	{"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"},
	{"RightUpperArm", "RightLowerArm"},
	{"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"},
	{"LeftUpperLeg", "LeftLowerLeg"},
	{"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"},
	{"RightUpperLeg", "RightLowerLeg"},
	{"RightLowerLeg", "RightFoot"},
}

local function getDroppedItemInfo(model)
	if not model then return nil end
	local name = model:GetAttribute("DisplayName") or model:GetAttribute("Name") or model.Name
	local rarity = model:GetAttribute("RarityName") or model:GetAttribute("Rarity") or "Common"
	local img = model:GetAttribute("ImageId") or model:GetAttribute("Icon") or model:GetAttribute("Texture")
	if type(img) == "number" then img = "rbxassetid://" .. tostring(img) end
	if type(img) ~= "string" or img == "" then
		local handle = model:FindFirstChild("Handle", true)
		if handle then
			if handle:IsA("MeshPart") and handle.TextureID ~= "" then
				img = handle.TextureID
			else
				local sm = handle:FindFirstChildOfClass("SpecialMesh")
				if sm and sm.TextureId ~= "" then img = sm.TextureId end
			end
		end
	end
	if not img or img == "" then img = "rbxassetid://7072725737" end
	local col = (RarityColors and RarityColors[rarity]) or Color3.fromRGB(160, 160, 160)
	local amount = model:GetAttribute("Amount") or 1
	return name, rarity, img, col, amount
end

local function clearDroppedESP(model)
	local gui = DroppedESPCache[model]
	if gui then
		pcall(function() gui:Destroy() end)
		DroppedESPCache[model] = nil
	end
end

local function makeDroppedESP(model)
	local zone = model:FindFirstChild("PickUpZone")
		or model:FindFirstChildWhichIsA("BasePart")
		or model.PrimaryPart
	if not zone then return nil end
	local name, rarity, img, col, amount = getDroppedItemInfo(model)
	local bill = Instance.new("BillboardGui")
	bill.Name = "FourKT_DroppedESP"
	bill.Adornee = zone
	bill.Size = UDim2.fromOffset(120, 22)
	bill.StudsOffset = Vector3.new(0, 1.2, 0)
	bill.AlwaysOnTop = true
	bill.MaxDistance = 800
	bill.Parent = ScreenGui

	local row = Instance.new("Frame", bill)
	row.Size = UDim2.fromScale(1, 1)
	row.BackgroundTransparency = 1

	local layout = Instance.new("UIListLayout", row)
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 3)

	local iconBg = Instance.new("Frame", row)
	iconBg.Size = UDim2.fromOffset(18, 18)
	iconBg.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
	iconBg.BackgroundTransparency = 0.15
	iconBg.LayoutOrder = 1
	Instance.new("UICorner", iconBg).CornerRadius = UDim.new(1, 0)
	local st = Instance.new("UIStroke", iconBg)
	st.Color = col
	st.Thickness = 1.5
	local icon = Instance.new("ImageLabel", iconBg)
	icon.Size = UDim2.new(1, -4, 1, -4)
	icon.Position = UDim2.fromOffset(2, 2)
	icon.BackgroundTransparency = 1
	icon.Image = img

	local nameBg = Instance.new("Frame", row)
	nameBg.AutomaticSize = Enum.AutomaticSize.X
	nameBg.Size = UDim2.fromOffset(0, 16)
	nameBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	nameBg.BackgroundTransparency = 0.25
	nameBg.LayoutOrder = 2
	Instance.new("UICorner", nameBg).CornerRadius = UDim.new(0.5, 0)
	local pad = Instance.new("UIPadding", nameBg)
	pad.PaddingLeft = UDim.new(0, 6)
	pad.PaddingRight = UDim.new(0, 6)
	local lab = Instance.new("TextLabel", nameBg)
	lab.AutomaticSize = Enum.AutomaticSize.X
	lab.Size = UDim2.fromOffset(0, 16)
	lab.BackgroundTransparency = 1
	lab.Font = Enum.Font.GothamBold
	lab.TextSize = 10
	lab.TextColor3 = Color3.fromRGB(255, 255, 255)
	lab.Text = (amount and amount > 1) and (name .. " x" .. tostring(amount)) or tostring(name)

	return bill
end

local function updateDroppedItemsESP()
	if not Settings.DroppedItemsESP then
		for m, gui in pairs(DroppedESPCache) do
			if gui then pcall(function() gui:Destroy() end) end
			DroppedESPCache[m] = nil
		end
		return
	end
	local folder = workspace:FindFirstChild("DroppedItems")
	if not folder then
		for m, gui in pairs(DroppedESPCache) do
			if gui then gui.Enabled = false end
		end
		return
	end
	local hrp = LocalRoot or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
	if not hrp then return end

	local seen = {}
	for _, model in ipairs(folder:GetChildren()) do
		if model:IsA("Model") and model.Name ~= "Money" and not model:GetAttribute("Locked") then
			local zone = model:FindFirstChild("PickUpZone")
				or model:FindFirstChildWhichIsA("BasePart")
				or model.PrimaryPart
			if zone and (zone.Position - hrp.Position).Magnitude <= 800 then
				seen[model] = true
				if not DroppedESPCache[model] or not DroppedESPCache[model].Parent then
					DroppedESPCache[model] = makeDroppedESP(model)
				else
					DroppedESPCache[model].Enabled = true
				end
			elseif DroppedESPCache[model] then
				DroppedESPCache[model].Enabled = false
			end
		end
	end
	for m, gui in pairs(DroppedESPCache) do
		if not seen[m] or not m.Parent then
			clearDroppedESP(m)
		end
	end
end

local function clearSkeleton(player)
	local data = SkeletonCache[player]
	if not data then return end
	if data.lines then
		for _, line in pairs(data.lines) do
			pcall(function() if line and line.Remove then line:Remove() end end)
		end
	end
	if data.conn then pcall(function() data.conn:Disconnect() end) end
	SkeletonCache[player] = nil
end

local function createSkeleton(player)
	if player == LocalPlayer then return end
	if SkeletonCache[player] then return end
	local lines = {}
	local conn = RunService.RenderStepped:Connect(function()
		if not Settings.SkeletonESP or not player.Parent then
			for _, line in pairs(lines) do
				if line then pcall(function() line.Visible = false end) end
			end
			return
		end
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not char or not hum or not hrp or hum.Health <= 0 then
			for _, line in pairs(lines) do
				if line then pcall(function() line.Visible = false end) end
			end
			return
		end
		local locked = (LockedTargetPlayer == player)
		-- mucho más visible
		local col = locked and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(80, 255, 120)
		for i, pair in ipairs(SKELETON_BONES) do
			local a = char:FindFirstChild(pair[1])
			local b = char:FindFirstChild(pair[2])
			if not lines[i] then
				pcall(function()
					lines[i] = Drawing.new("Line")
					lines[i].Thickness = 4.5
					lines[i].Transparency = 0
				end)
			end
			local line = lines[i]
			if line then
				line.Color = col
				line.Thickness = locked and 5.5 or 4.5
				line.Transparency = 0
				if a and b then
					local p1, on1 = Camera:WorldToViewportPoint(a.Position)
					local p2, on2 = Camera:WorldToViewportPoint(b.Position)
					if on1 and on2 and p1.Z > 0 and p2.Z > 0 then
						line.From = Vector2.new(p1.X, p1.Y)
						line.To = Vector2.new(p2.X, p2.Y)
						line.Visible = true
					else
						line.Visible = false
					end
				else
					line.Visible = false
				end
			end
		end
	end)
	SkeletonCache[player] = { conn = conn, lines = lines }
end

local function updateSkeletons()
	if not Settings.SkeletonESP then
		for pl in pairs(SkeletonCache) do
			clearSkeleton(pl)
		end
		return
	end
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl ~= LocalPlayer then
			createSkeleton(pl)
		end
	end
end

RunService.Heartbeat:Connect(function()
	updateDroppedItemsESP()
	updateSkeletons()
end)

Players.PlayerRemoving:Connect(function(pl)
	clearSkeleton(pl)
end)

local function CreateESP(player)
	if ESPObjects[player] then
		local g = ESPObjects[player]
		local ok = g and g.Box and pcall(function() return g.Box.Visible end)
		if ok then return end
		pcall(function()
			if g.Box then g.Box:Remove() end
			if g.NameTag then g.NameTag:Remove() end
			if g.Bar then g.Bar:Remove() end
			if g.Back then g.Back:Remove() end
			if g.Item1 then g.Item1:Remove() end
			if g.Item2 then g.Item2:Remove() end
		end)
		ESPObjects[player] = nil
	end
	local box = safeDrawing("Square")
	local name = safeDrawing("Text")
	local back = safeDrawing("Square")
	local bar = safeDrawing("Square")
	local i1 = safeDrawing("Text")
	local i2 = safeDrawing("Text")
	if not box or not name then return end
	pcall(function()
		box.Thickness = 1
		box.Filled = false
		name.Size = 14
		name.Center = true
		name.Outline = true
		name.Font = 2
		if back then back.Filled = true back.Thickness = 0 back.Color = Color3.fromRGB(40,40,40) end
		if bar then bar.Filled = true bar.Thickness = 0 end
		if i1 then i1.Center = true i1.Outline = true i1.Size = 13 i1.Font = 2 end
		if i2 then i2.Center = true i2.Outline = true i2.Size = 13 i2.Font = 2 end
	end)
	ESPObjects[player] = {Box=box, NameTag=name, Back=back, Bar=bar, Item1=i1, Item2=i2}
end

local function CreateTracer(player)
	if TracerObjects[player] then
		local ok = pcall(function() return TracerObjects[player].Visible end)
		if ok then return end
		pcall(function() TracerObjects[player]:Remove() end)
		TracerObjects[player] = nil
	end
	local line = safeDrawing("Line")
	if line then
		pcall(function() line.Thickness = 1.5 line.Color = Color3.fromRGB(0,255,100) line.Visible = false end)
		TracerObjects[player] = line
	end
end

local function getChamsColor()
	return CHAMS_COLORS[math.clamp(chamsColorIndex or 4, 1, #CHAMS_COLORS)].Color
end

local function applyChamsColor(hl, isFriend)
	if not hl then return end
	local col = isFriend and Color3.fromRGB(40, 255, 80) or getChamsColor()
	pcall(function()
		hl.FillColor = col
		hl.OutlineColor = isFriend and Color3.fromRGB(180, 255, 200) or Color3.fromRGB(255, 255, 255)
		hl.FillTransparency = 0.45
		hl.OutlineTransparency = 0.15
	end)
end

local function CreateHighlight(player)
	local existing = HighlightObjects[player]
	if existing then
		local alive = pcall(function() return existing.Parent ~= nil end)
		if alive and existing.Parent then return end
		pcall(function() existing:Destroy() end)
		HighlightObjects[player] = nil
	end
	local hl = Instance.new("Highlight")
	hl.Name = "FourKT_Chams"
	hl.FillColor = getChamsColor()
	hl.OutlineColor = Color3.fromRGB(255, 255, 255)
	hl.FillTransparency = 0.45
	hl.OutlineTransparency = 0.15
	hl.Enabled = false
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = ScreenGui
	if player.Character then hl.Adornee = player.Character end
	HighlightObjects[player] = hl
end

UpdateChams = function()
	if not Settings.HighlightEnabled then
		for _, h in pairs(HighlightObjects) do if h then pcall(function() h.Enabled = false end) end end
		return
	end
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			CreateHighlight(player)
			local hl = HighlightObjects[player]
			if not hl then continue end
			local char = player.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if char and hum and hum.Health > 0 then
				pcall(function()
					hl.Adornee = char
					applyChamsColor(hl, IsFriend(player))
					hl.Enabled = true
				end)
			else
				pcall(function() hl.Enabled = false end)
			end
		end
	end
end

local function clearESPDraw(g)
	if not g then return end
	pcall(function()
		if g.Box then g.Box.Visible = false end
		if g.NameTag then g.NameTag.Visible = false end
		if g.Bar then g.Bar.Visible = false end
		if g.Back then g.Back.Visible = false end
		if g.Item1 then g.Item1.Visible = false end
		if g.Item2 then g.Item2.Visible = false end
	end)
end

local function RemoveESP(player)
	local g = ESPObjects[player]
	if g then
		pcall(function() if g.Box then g.Box:Remove() end end)
		pcall(function() if g.NameTag then g.NameTag:Remove() end end)
		pcall(function() if g.Bar then g.Bar:Remove() end end)
		pcall(function() if g.Back then g.Back:Remove() end end)
		pcall(function() if g.Item1 then g.Item1:Remove() end end)
		pcall(function() if g.Item2 then g.Item2:Remove() end end)
		ESPObjects[player] = nil
	end
	if TracerObjects[player] then pcall(function() TracerObjects[player]:Remove() end) TracerObjects[player] = nil end
	if HighlightObjects[player] then pcall(function() HighlightObjects[player]:Destroy() end) HighlightObjects[player] = nil end
end


local function UpdateESP()
	Settings.ESPEnabled = true
	local cam = workspace.CurrentCamera
	if cam then Camera = cam end
	local localPos = LocalRoot and LocalRoot.Position or Camera.CFrame.Position
	local screenBottom = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
	local now = tick()
	local updInfo = (now - lastInfoUpdate) >= (infoUpdateInterval or 0)

	for _, player in pairs(Players:GetPlayers()) do
		if player == LocalPlayer then continue end
		if not IsAlive(player) then
			clearESPDraw(ESPObjects[player])
			if TracerObjects[player] then pcall(function() TracerObjects[player].Visible = false end) end
			continue
		end
		CreateESP(player)
		CreateTracer(player)
		CreateHighlight(player)
		local gui = ESPObjects[player]
		local line = TracerObjects[player]
		local char = player.Character
		local root = char and (
			char:FindFirstChild("HumanoidRootPart")
			or char:FindFirstChild("UpperTorso")
			or char:FindFirstChild("Torso")
			or char:FindFirstChild("Head")
		)
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if not (root and hum and gui) then
			clearESPDraw(gui)
			if line then pcall(function() line.Visible = false end) end
			continue
		end
		local dist = (root.Position - localPos).Magnitude
		if dist > (Settings.MaxDistance or 800) then
			clearESPDraw(gui)
			if line then pcall(function() line.Visible = false end) end
			continue
		end
		local friend = IsFriend(player)
		if gui.Box and gui.NameTag then
			-- Caja en el cuerpo; letras más ABAJO (pies) para ver el personaje completo
			local bodyPos = root.Position
			local upper = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
			if upper then bodyPos = upper.Position end
			local feetPos = root.Position - Vector3.new(0, 2.8, 0)
			local pos, onScreen = Camera:WorldToViewportPoint(bodyPos)
			local feetScreen, feetOn = Camera:WorldToViewportPoint(feetPos)
			local headPart = char:FindFirstChild("Head")
			local headScreen, headOn = nil, false
			if headPart then
				headScreen, headOn = Camera:WorldToViewportPoint(headPart.Position + Vector3.new(0, 0.35, 0))
			end
			if onScreen and pos.Z > 0 then
				local screenPt = Vector2.new(pos.X, pos.Y)
				local feetPt = (feetOn and feetScreen.Z > 0) and Vector2.new(feetScreen.X, feetScreen.Y) or Vector2.new(pos.X, pos.Y + 40)
				local headPt = (headOn and headScreen and headScreen.Z > 0) and Vector2.new(headScreen.X, headScreen.Y) or Vector2.new(pos.X, pos.Y - 28)
				local myHumEsp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				local meInCar = myHumEsp and (myHumEsp.Sit or myHumEsp.SeatPart ~= nil)
				if meInCar and gui.SmoothScreen then
					screenPt = gui.SmoothScreen:Lerp(screenPt, 0.35)
					if gui.SmoothFeet then
						feetPt = gui.SmoothFeet:Lerp(feetPt, 0.35)
					end
					if gui.SmoothHead then
						headPt = gui.SmoothHead:Lerp(headPt, 0.35)
					end
				end
				gui.SmoothScreen = screenPt
				gui.SmoothFeet = feetPt
				gui.SmoothHead = headPt
				local scale = 1000 / math.max(pos.Z, 1)
				local boxSize = Vector2.new(math.clamp(4 * scale, 14, 140), math.clamp(6.5 * scale, 22, 200))
				local boxPos = Vector2.new(screenPt.X - boxSize.X / 2, screenPt.Y - boxSize.Y / 2)
				-- Desde carro: nombre/info ARRIBA de la cabeza (más estable al mover el mouse)
				local labelAnchor = meInCar and headPt or feetPt
				local nameYOff = meInCar and -18 or 4
				local itemYBase = meInCar and -34 or 18
				pcall(function()
					gui.Box.Size = boxSize
					gui.Box.Position = boxPos
					gui.Box.Color = friend and Color3.fromRGB(80,255,120) or Color3.fromRGB(255,40,40)
					gui.Box.Visible = true
					gui.NameTag.Text = string.format("%s [%d/%d]", player.DisplayName or player.Name, math.floor(hum.Health), math.floor(hum.MaxHealth))
					gui.NameTag.Position = Vector2.new(labelAnchor.X, labelAnchor.Y + nameYOff)
					gui.NameTag.Color = friend and Color3.fromRGB(40,255,80) or Settings.NameColor
					gui.NameTag.Visible = true
					local hpP = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
					if gui.Back then
						gui.Back.Size = Vector2.new(3, boxSize.Y)
						gui.Back.Position = Vector2.new(boxPos.X - 6, boxPos.Y)
						gui.Back.Visible = true
					end
					if gui.Bar then
						local fh = boxSize.Y * hpP
						gui.Bar.Size = Vector2.new(3, fh)
						gui.Bar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + (boxSize.Y - fh))
						gui.Bar.Color = hpP > 0.7 and Color3.fromRGB(0,255,100) or hpP > 0.3 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,50,50)
						gui.Bar.Visible = true
					end
					if Settings.Informacion then
						if updInfo then
							local items, tools = {}, {}
							local eq = char:FindFirstChildOfClass("Tool")
							if eq then table.insert(tools, eq) end
							local bp = player:FindFirstChild("Backpack")
							if bp then for _, tool in pairs(bp:GetChildren()) do if tool:IsA("Tool") then table.insert(tools, tool) end end end
							for _, tool in pairs(tools) do
								local info = getAnalyzedInfo(tool)
								if info and #items < 2 then table.insert(items, info) end
							end
							gui.TempItem1, gui.TempItem2 = items[1], items[2]
						end
						for i = 1, 2 do
							local lab = gui["Item" .. i]
							local data = gui["TempItem" .. i]
							if lab then
								if data then
									lab.Text = "[" .. data.Text .. "]"
									lab.Color = data.Color
									lab.Position = Vector2.new(labelAnchor.X, labelAnchor.Y + itemYBase + (i - 1) * (meInCar and -14 or 14))
									lab.Visible = true
								else lab.Visible = false end
							end
						end
					else
						if gui.Item1 then gui.Item1.Visible = false end
						if gui.Item2 then gui.Item2.Visible = false end
					end
				end)
				if Settings.TracersEnabled and line then
					pcall(function()
						line.From = screenBottom
						line.To = Vector2.new(screenPt.X, screenPt.Y)
						line.Color = friend and Color3.fromRGB(80,255,120) or Color3.fromRGB(0,255,100)
						line.Visible = true
					end)
				elseif line then
					pcall(function() line.Visible = false end)
				end
			else
				clearESPDraw(gui)
				if line then pcall(function() line.Visible = false end) end
			end
		end
	end
	if updInfo then lastInfoUpdate = now end
end

RunService.RenderStepped:Connect(function(dt)
	local sc = Camera.ViewportSize / 2
	local active = isAimActive()
	if FOVCircle then
		pcall(function()
			FOVCircle.Position = sc
			FOVCircle.Radius = Settings.FOV
			FOVCircle.Thickness = 5
			FOVCircle.Visible = active
		end)
	end
	local partMode = Settings.AimPartMode or (Settings.AlternateAim and "Alternate" or "Head")
	if partMode == "Alternate" or Settings.AlternateAim then
		AlternateTimer = AlternateTimer + dt
		local interval = Settings.AlternateInterval or 0.5
		if AlternateTimer >= interval then
			AlternateTimer = 0
			AimAtHead = not AimAtHead
		end
	elseif partMode == "Head" then
		AimAtHead = true
	elseif partMode == "Chest" then
		AimAtHead = false
	end
	if not active then
		LockedTargetPart, LockedTargetPlayer = nil, nil
		return
	end
	local target = GetClosestPlayer()
	if not target then return end
	local aimPos = target.Position
	local lc = LocalPlayer.Character
	local myHum = lc and lc:FindFirstChildOfClass("Humanoid")
	local mySitting = myHum and (myHum.Sit or myHum.SeatPart ~= nil)
	local char = target.Parent
	local targetHum = char and char:FindFirstChildOfClass("Humanoid")
	local targetSitting = targetHum and (targetHum.Sit or targetHum.SeatPart ~= nil)

	-- PREDICCIÓN AL PISO (prioridad si está activa)
	if Settings.PredictionEnabled and char then
		local ground = GetGroundPredictPoint(char)
		if ground then
			aimPos = ground
		end
	elseif char then
		local head = char:FindFirstChild("Head")
		local upper = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
		local mode = Settings.AimPartMode or (Settings.AlternateAim and "Alternate" or "Head")
		local useHead = (mode == "Head") or ((mode == "Alternate" or Settings.AlternateAim) and AimAtHead)
		if mode == "Chest" then useHead = false end
		if useHead and head then
			aimPos = head.Position + Vector3.new(0, targetSitting and -0.25 or -0.08, 0)
		elseif upper then
			aimPos = upper.Position + Vector3.new(0, targetSitting and 0.05 or 0.12, 0)
		elseif head then
			aimPos = head.Position
		end
	end

	-- Aim carro: offset fuerte SOLO si TÚ estás en el carro
	-- Si solo el enemigo va en carro y tú a pie: no mover la mira al lado
	if Settings.VehicleAimEnabled and mySitting then
		local head = char and char:FindFirstChild("Head")
		if head then
			local camRight = Camera.CFrame.RightVector
			aimPos = head.Position + Vector3.new(0, -1.8, 0) + (camRight * -2)
		end
	elseif targetSitting and char then
		-- tú a pie, enemigo en carro: solo un poco más abajo en la cabeza
		local head = char:FindFirstChild("Head")
		if head then
			aimPos = head.Position + Vector3.new(0, -0.2, 0)
		end
	end

	local goal = CFrame.lookAt(Camera.CFrame.Position, aimPos)
	if Settings.VehicleAimEnabled and mySitting then
		Camera.CFrame = goal
	else
		local smooth = math.clamp(Settings.Smoothness or 0.065, 0.01, 0.4)
		local strength = math.clamp(Settings.AimStrength or 0.92, 0.3, 1)
		local alpha = math.clamp((1 - smooth) * strength, 0.15, 0.98)
		Camera.CFrame = Camera.CFrame:Lerp(goal, alpha)
	end
end)

local _espFrame = 0
RunService.RenderStepped:Connect(function()
	_espFrame += 1
	-- cada 2 frames = menos lag con muchos jugadores
	if _espFrame % 2 == 0 then
		UpdateESP()
	end
end)
RunService.Heartbeat:Connect(function()
	local now = os.clock()
	if now - LastChamsUpdate >= CHAMS_INTERVAL then
		LastChamsUpdate = now
		UpdateChams()
	end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if waitingForKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.Escape then waitingForKey = nil refreshKeyBtns() return end
			if input.KeyCode ~= Enum.KeyCode.Unknown then
				Settings[waitingForKey] = input.KeyCode
				waitingForKey = nil
				refreshKeyBtns()
				SaveConfig(true)
			end
		end
		return
	end
	if gpe then return end
	if input.KeyCode == Settings.AimKey then
		if Settings.AimMode == "Hold" then
			AimbotHolding = true
		elseif Settings.AimMode == "Toggle" then
			AimbotEnabled = not AimbotEnabled
			if not AimbotEnabled then LockedTargetPart, LockedTargetPlayer = nil, nil end
		end
	elseif input.KeyCode == Settings.MacroKey then
		runResetMacro()
	elseif input.KeyCode == Settings.ESPKey then
		Settings.ESPEnabled = true
	elseif input.KeyCode == Settings.FullMenuKey then
		togglePanel(FullPanel)
	elseif input.KeyCode == Settings.AimMenuKey then
		togglePanel(AimPanel)
	elseif input.KeyCode == Settings.FriendsKey then
		togglePanel(FriendsPanel)
		RefreshFriendsListU()
	elseif input.KeyCode == Enum.KeyCode.Eight or input.KeyCode == Enum.KeyCode.KeypadEight
		or (input.KeyCode and input.KeyCode.Name == "Eight") then
		if InfoPanel then
			if InfoPanel.Visible then
				InfoPanel.Visible = false
			else
				-- cerrar otros menús
				if AimPanel then AimPanel.Visible = false end
				if FullPanel then FullPanel.Visible = false end
				if FriendsPanel then FriendsPanel.Visible = false end
				InfoPanel.Visible = true
				InfoPanel.AnchorPoint = Vector2.new(0.5, 0.5)
				InfoPanel.Position = UDim2.fromScale(0.5, 0.5)
				local w = InfoPanel:GetAttribute("BaseSizeX") or 360
				local h = InfoPanel:GetAttribute("BaseSizeY") or 420
				InfoPanel.Size = UDim2.fromOffset(w, h)
				pcall(refreshInfoPanel)
			end
		end
	elseif input.KeyCode == Enum.KeyCode.V then
		Settings.PredictionEnabled = not Settings.PredictionEnabled
		SaveConfig(true)
		pcall(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "4KT Predicción",
				Text = Settings.PredictionEnabled and "PISO ON" or "OFF",
				Duration = 2
			})
		end)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Settings.AimKey and Settings.AimMode == "Hold" then
		AimbotHolding = false
		LockedTargetPart, LockedTargetPlayer = nil, nil
	end
end)

Players.PlayerRemoving:Connect(RemoveESP)
pcall(buildToolCache)
for _, v in pairs(Players:GetPlayers()) do
	if v ~= LocalPlayer then CreateESP(v) CreateTracer(v) CreateHighlight(v) end
end
Players.PlayerAdded:Connect(function(v)
	task.wait(0.5)
	CreateESP(v) CreateTracer(v) CreateHighlight(v)
	RefreshFriendsListU()
end)

pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "4KT ON TOP",
		Text = "F=Aimbot | P=Menú+Skeleton | G/U/8 menús | V=Predicción",
		Duration = 4
	})
end)


------------------------------------------------------------------
-- OVERHEAD VISUAL "4KT On top" (etiqueta neón sobre tu personaje)
------------------------------------------------------------------
do
	local Player = LocalPlayer
	local PlayerGui = Player:WaitForChild("PlayerGui", 5)

	local sharedState = _G
	pcall(function()
		if type(getgenv) == "function" then sharedState = getgenv() end
	end)
	if type(sharedState.CUSTOM_CELESTIAL_CLEANUP) == "function" then
		pcall(sharedState.CUSTOM_CELESTIAL_CLEANUP)
	end

	if Player.Character then
		local oldTag = Player.Character:FindFirstChild("CUSTOM_OVERHEAD_TAG", true)
		if oldTag then oldTag:Destroy() end
	end

	local COLOR = {
		Night = Color3.fromRGB(14, 9, 31),
		DarkViolet = Color3.fromRGB(35, 13, 58),
		Purple = Color3.fromRGB(161, 64, 255),
		Pink = Color3.fromRGB(248, 63, 220),
		Cyan = Color3.fromRGB(85, 229, 255),
		Ice = Color3.fromRGB(219, 245, 255),
		White = Color3.fromRGB(251, 246, 255),
		Dim = Color3.fromRGB(169, 167, 201)
	}

	local alive = true
	local enabled = true
	local sizePercent = 26
	local currentTag = nil
	local currentHumanoid = nil
	local lastNameDistance = setmetatable({}, {__mode = "k"})
	local visualConnection = nil
	local globalConnections = {}
	local nameWatch = nil

	local function track(connection)
		globalConnections[#globalConnections + 1] = connection
		return connection
	end

	local function make(className, parent, props)
		local obj = Instance.new(className)
		for property, value in pairs(props or {}) do
			obj[property] = value
		end
		obj.Parent = parent
		return obj
	end

	local function rounded(parent, radius)
		return make("UICorner", parent, {CornerRadius = UDim.new(0, radius)})
	end

	local function stroke(parent, color, thickness, alpha)
		return make("UIStroke", parent, {
			Color = color,
			Thickness = thickness,
			Transparency = alpha,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		})
	end

	local function circle(parent, size, color, transparency)
		local part = make("Frame", parent, {
			Size = UDim2.fromOffset(size, size),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = color,
			BackgroundTransparency = transparency or 0,
			BorderSizePixel = 0
		})
		make("UICorner", part, {CornerRadius = UDim.new(1, 0)})
		return part
	end

	local function restoreName(humanoid)
		if not humanoid then return end
		local previous = lastNameDistance[humanoid]
		if previous ~= nil then
			pcall(function() humanoid.NameDisplayDistance = previous end)
			lastNameDistance[humanoid] = nil
		end
	end

	local function hideName(humanoid)
		if not humanoid then return end
		if lastNameDistance[humanoid] == nil then
			lastNameDistance[humanoid] = humanoid.NameDisplayDistance
		end
		pcall(function() humanoid.NameDisplayDistance = 0 end)
	end

	local function removeVisual()
		if visualConnection then
			visualConnection:Disconnect()
			visualConnection = nil
		end
		if currentTag then
			currentTag:Destroy()
			currentTag = nil
		end
		if currentHumanoid then
			restoreName(currentHumanoid)
			currentHumanoid = nil
		end
	end

	local function makeLabel(parent, text, size, font, color, position, dimensions, z)
		return make("TextLabel", parent, {
			Name = "Label",
			Text = text,
			Font = font,
			TextColor3 = color,
			TextSize = size,
			TextScaled = false,
			TextWrapped = false,
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			Position = position,
			Size = dimensions,
			ZIndex = z or 1
		})
	end

	local function createOverhead(rootPart, head)
		local headRise = math.clamp(head.Position.Y - rootPart.Position.Y, 1.3, 3.4)
		local fixedHeight = headRise + (1.95 + 1.20 * (sizePercent / 100))

		local tag = make("BillboardGui", rootPart, {
			Name = "CUSTOM_OVERHEAD_TAG",
			Adornee = rootPart,
			AlwaysOnTop = true,
			LightInfluence = 0,
			MaxDistance = 185,
			ResetOnSpawn = false,
			StudsOffsetWorldSpace = Vector3.new(0, fixedHeight, 0),
			Size = UDim2.fromOffset(410, 145)
		})

		local root = make("Frame", tag, {
			Name = "EffectCanvas",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(410, 145),
			ClipsDescendants = false
		})

		make("UIScale", root, { Scale = sizePercent / 100 })

		local haze = make("Frame", root, {
			Position = UDim2.fromOffset(18, 38),
			Size = UDim2.fromOffset(374, 83),
			BackgroundColor3 = COLOR.Purple,
			BackgroundTransparency = 0.94,
			BorderSizePixel = 0,
			ZIndex = 1
		})
		rounded(haze, 20)

		local halo = make("Frame", root, {
			Position = UDim2.fromOffset(26, 43),
			Size = UDim2.fromOffset(358, 72),
			BackgroundColor3 = COLOR.Pink,
			BackgroundTransparency = 0.95,
			BorderSizePixel = 0,
			ZIndex = 2
		})
		rounded(halo, 17)

		local plate = make("Frame", root, {
			Position = UDim2.fromOffset(29, 46),
			Size = UDim2.fromOffset(352, 66),
			BackgroundColor3 = COLOR.Night,
			BackgroundTransparency = 0.56,
			BorderSizePixel = 0,
			ZIndex = 3
		})
		rounded(plate, 16)

		local edge = stroke(plate, COLOR.Purple, 1.8, 0.33)
		local edgeGradient = make("UIGradient", edge, {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, COLOR.Cyan),
				ColorSequenceKeypoint.new(0.31, COLOR.Purple),
				ColorSequenceKeypoint.new(0.64, COLOR.Pink),
				ColorSequenceKeypoint.new(1, COLOR.Cyan)
			}),
			Rotation = 0
		})

		local topLight = make("Frame", root, {
			Position = UDim2.fromOffset(83, 44),
			Size = UDim2.fromOffset(244, 2),
			BackgroundColor3 = COLOR.Cyan,
			BackgroundTransparency = 0.65,
			BorderSizePixel = 0,
			ZIndex = 6
		})
		rounded(topLight, 2)

		local lowLight = make("Frame", root, {
			Position = UDim2.fromOffset(136, 112),
			Size = UDim2.fromOffset(138, 2),
			BackgroundColor3 = COLOR.Pink,
			BackgroundTransparency = 0.68,
			BorderSizePixel = 0,
			ZIndex = 6
		})
		rounded(lowLight, 2)

		local crestBase = make("Frame", root, {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(205, 25),
			Size = UDim2.fromOffset(148, 23),
			BackgroundColor3 = COLOR.DarkViolet,
			BackgroundTransparency = 0.52,
			BorderSizePixel = 0,
			ZIndex = 8
		})
		rounded(crestBase, 9)
		stroke(crestBase, COLOR.Cyan, 1.25, 0.32)
		makeLabel(crestBase, "4KT // GANG", 11, Enum.Font.GothamBold, COLOR.Ice, UDim2.fromScale(0, 0), UDim2.fromScale(1, 1), 9)

		local textArea = UDim2.fromOffset(352, 40)
		local shadowA = makeLabel(root, "4KT On top", 30, Enum.Font.GothamBlack, COLOR.Pink, UDim2.fromOffset(31, 60), textArea, 7)
		shadowA.TextTransparency = 0.86

		local shadowB = makeLabel(root, "4KT On top", 30, Enum.Font.GothamBlack, COLOR.Cyan, UDim2.fromOffset(27, 58), textArea, 7)
		shadowB.TextTransparency = 0.89

		local mainText = makeLabel(root, "4KT On top", 30, Enum.Font.GothamBlack, COLOR.White, UDim2.fromOffset(29, 59), textArea, 10)
		mainText.TextTransparency = 0.15
		mainText.TextStrokeColor3 = COLOR.DarkViolet
		mainText.TextStrokeTransparency = 0.62

		local textGradient = make("UIGradient", mainText, {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, COLOR.Purple),
				ColorSequenceKeypoint.new(0.25, COLOR.Ice),
				ColorSequenceKeypoint.new(0.5, COLOR.White),
				ColorSequenceKeypoint.new(0.72, COLOR.Pink),
				ColorSequenceKeypoint.new(1, COLOR.Cyan)
			}),
			Rotation = 5
		})

		local scannerMask = make("Frame", plate, {
			Position = UDim2.fromOffset(12, 3),
			Size = UDim2.fromOffset(328, 60),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			ZIndex = 11
		})
		local scanner = make("Frame", scannerMask, {
			Position = UDim2.fromOffset(-40, 0),
			Size = UDim2.fromOffset(26, 60),
			BackgroundColor3 = COLOR.White,
			BackgroundTransparency = 0.94,
			Rotation = 14,
			BorderSizePixel = 0,
			ZIndex = 11
		})
		make("UIGradient", scanner, {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.48, 0.28),
				NumberSequenceKeypoint.new(1, 1)
			})
		})

		local diamonds = {}
		for i = 1, 4 do
			local diamond = make("Frame", root, {
				Size = UDim2.fromOffset(9, 9),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = i % 2 == 0 and COLOR.Cyan or COLOR.Pink,
				BackgroundTransparency = 0.44,
				BorderSizePixel = 0,
				Rotation = 45,
				ZIndex = 8
			})
			stroke(diamond, COLOR.White, 0.6, 0.53)
			diamonds[#diamonds + 1] = diamond
		end

		local particles = {}
		for i = 1, 14 do
			local particle = circle(root, (i % 3) + 2, i % 3 == 0 and COLOR.Cyan or (i % 2 == 0 and COLOR.Pink or COLOR.Purple), 0.51)
			particle.ZIndex = 8
			particles[#particles + 1] = particle
		end

		local orbitCenter = Vector2.new(205, 79)
		local startingTime = os.clock()
		local acc = 0

		visualConnection = RunService.Heartbeat:Connect(function(dt)
			if not alive or not enabled or not tag.Parent then
				if visualConnection then visualConnection:Disconnect() end
				return
			end
			acc = acc + dt
			if acc < (1 / 24) then return end
			acc = 0

			local tt = os.clock() - startingTime
			edgeGradient.Rotation = (tt * 27) % 360
			textGradient.Offset = Vector2.new(math.sin(tt * 0.78) * 0.3, 0)
			edge.Transparency = 0.35 + 0.21 * (0.5 + 0.5 * math.sin(tt * 2.0))
			haze.BackgroundTransparency = 0.93 + 0.05 * (0.5 + 0.5 * math.sin(tt * 2.2))
			halo.BackgroundTransparency = 0.94 + 0.05 * (0.5 + 0.5 * math.sin(tt * 1.7))
			topLight.BackgroundTransparency = 0.65 + 0.20 * (0.5 + 0.5 * math.sin(tt * 2.4))
			lowLight.BackgroundTransparency = 0.66 + 0.20 * (0.5 + 0.5 * math.sin(tt * 3.1))
			scanner.Position = UDim2.fromOffset(-40 + (tt * 84) % 408, 0)

			for i, diamond in ipairs(diamonds) do
				local a = tt * 0.76 + (i - 1) * math.pi / 2
				local rx = 190 * math.cos(a)
				local ry = 51 * math.sin(a)
				diamond.Position = UDim2.fromOffset(orbitCenter.X + rx, orbitCenter.Y + ry)
				diamond.Rotation = 45 + (tt * 92) % 360
				diamond.BackgroundTransparency = 0.43 + 0.35 * (0.5 + 0.5 * math.sin(tt * 3 + i))
			end

			for i, particle in ipairs(particles) do
				local speed = 0.34 + (i % 4) * 0.14
				local a = tt * speed + (i * 2.39996)
				local rx = (180 + (i % 3) * 13) * math.cos(a)
				local ry = (39 + (i % 5) * 8) * math.sin(a * 1.37)
				particle.Position = UDim2.fromOffset(orbitCenter.X + rx, orbitCenter.Y + ry - math.sin(tt * 1.1 + i) * 9)
				particle.BackgroundTransparency = 0.55 + 0.40 * (0.5 + 0.5 * math.sin(tt * 2.9 + i * 1.65))
			end
		end)

		return tag
	end

	local function installOnCharacter(character)
		if not alive or character ~= Player.Character then return end
		local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 12)
		local rootPart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 12)
		local hum = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 12)

		if not alive or character ~= Player.Character then return end
		if not head or not hum or not rootPart then return end

		if nameWatch then nameWatch:Disconnect(); nameWatch = nil end
		removeVisual()
		currentHumanoid = hum
		hideName(hum)

		nameWatch = hum:GetPropertyChangedSignal("NameDisplayDistance"):Connect(function()
			if alive and currentHumanoid == hum and hum.NameDisplayDistance ~= 0 then
				hideName(hum)
			end
		end)

		currentTag = createOverhead(rootPart, head)
	end

	local function cleanup()
		if not alive then return end
		alive = false
		enabled = false
		if nameWatch then nameWatch:Disconnect(); nameWatch = nil end
		removeVisual()
		for _, connection in ipairs(globalConnections) do
			pcall(function() connection:Disconnect() end)
		end
		if sharedState.CUSTOM_CELESTIAL_CLEANUP == cleanup then
			sharedState.CUSTOM_CELESTIAL_CLEANUP = nil
		end
	end

	sharedState.CUSTOM_CELESTIAL_CLEANUP = cleanup

	track(Player.CharacterAdded:Connect(function(character)
		task.spawn(installOnCharacter, character)
	end))

	if Player.Character then
		task.spawn(installOnCharacter, Player.Character)
	end
end



print("[4KT] predicción al piso lista")
