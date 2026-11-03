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
	SpoofNameEnabled = true,
	SpoofNameText = "4KT",
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
		SpoofNameEnabled = Settings.SpoofNameEnabled,
		SpoofNameText = Settings.SpoofNameText,
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
		if result.SpoofNameEnabled ~= nil then Settings.SpoofNameEnabled = result.SpoofNameEnabled end
		if type(result.SpoofNameText) == "string" and result.SpoofNameText ~= "" then Settings.SpoofNameText = result.SpoofNameText end
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
toggleBtn(FullPanel, 412, "SpoofNameEnabled", "Nombre 4KT : ON", "Nombre 4KT : OFF", onC, offC, function()
	SaveConfig(true)
	pcall(applyNameSpoof)
end)

toggleBtn(FullPanel, 372, "SpoofNameEnabled", "Nombre 4KT : ON", "Nombre 4KT : OFF", onC, offC, function()
	SaveConfig(true)
	pcall(function() if applyNameSpoof then applyNameSpoof() end end)
end)
CreateBtn(FullPanel, "💾 Guardar Config", 412, Color3.fromRGB(48, 48, 54), function() SaveConfig(false) end)

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
	bg.Parent ... (Tiempo restante: 53 KB)
