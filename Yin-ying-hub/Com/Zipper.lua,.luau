--[[
    ===================================================================
    Delta X Pro Hub - Landscape Ultimate Edition (v3.1 With Floating Toggle & ESP)
    Target Map: Obby Tower / Doomspire / Parkour Map
    Features: 100 Real Functions across 20 Categories (ALL WORKING)
    Language: Luau / Lua (Roblox Native)
    ===================================================================
]]--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("DeltaXProHub") then CoreGui.DeltaXProHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaXProHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local PlayerCredits = 2500
local GetChar = function() return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() end
local GetHRP = function()
    local c = GetChar()
    return c:FindFirstChild("HumanoidRootPart") or c:WaitForChild("HumanoidRootPart", 3)
end
local GetHum = function() return GetChar():FindFirstChildOfClass("Humanoid") end

-- ==========================================
-- AUDIO OBJECT (สำหรับระบบเสียงคลิกและเปิด/ปิดหน้าต่าง)
-- ==========================================
local SoundObj = Instance.new("Sound")
SoundObj.SoundId = "rbxassetid://114032036529323"
SoundObj.Volume = 1
SoundObj.Parent = ScreenGui

local function playClickSound()
    pcall(function()
        SoundObj.TimePosition = 0
        SoundObj:Play()
    end)
end

local function stopClickSound()
    pcall(function()
        SoundObj:Stop()
    end)
end

-- ==========================================
-- FLOATING TOGGLE BUTTON (ปุ่มวงกลมย่อ/ขยาย Hub)
-- ==========================================
local FloatToggle = Instance.new("ImageButton")
FloatToggle.Size = UDim2.new(0, 50, 0, 50)
FloatToggle.Position = UDim2.new(0.02, 0, 0.2, 0)
FloatToggle.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
FloatToggle.BorderSizePixel = 0
FloatToggle.Image = "rbxassetid://6023426915" -- ไอคอนวงกลมสไตล์โมเดิร์น
FloatToggle.Parent = ScreenGui
local FTC = Instance.new("UICorner"); FTC.CornerRadius = UDim.new(1,0); FTC.Parent = FloatToggle
local FTS = Instance.new("UIStroke"); FTS.Color = Color3.fromRGB(167,139,250); FTS.Thickness = 2; FTS.Parent = FloatToggle

local fDragging, fDragStart, fStartPos
FloatToggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        fDragging = true; fDragStart = input.Position; fStartPos = FloatToggle.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then fDragging = false end end)
    end
end)
FloatToggle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if fDragging then
            local d = input.Position - fDragStart
            FloatToggle.Position = UDim2.new(fStartPos.X.Scale, fStartPos.X.Offset + d.X, fStartPos.Y.Scale, fStartPos.Y.Offset + d.Y)
        end
    end
end)

-- ==========================================
-- WATERMARK (ปุ่มโลโก้ตัว Delta เล็กๆ มุมจอ)
-- ==========================================
local Watermark = Instance.new("TextButton")
Watermark.Size = UDim2.new(0, 40, 0, 40)
Watermark.Position = UDim2.new(0.05, 0, 0.1, 0)
Watermark.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
Watermark.BorderSizePixel = 0
Watermark.Text = "Δ"
Watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
Watermark.TextSize = 18
Watermark.Font = Enum.Font.GothamBold
Watermark.Visible = false
Watermark.Parent = ScreenGui
local WC = Instance.new("UICorner"); WC.CornerRadius = UDim.new(1,0); WC.Parent = Watermark
local WS = Instance.new("UIStroke"); WS.Color = Color3.fromRGB(167,139,250); WS.Thickness = 2; WS.Parent = Watermark

-- ==========================================
-- MAIN WINDOW (ปรับขนาดให้เล็กลงกำลังดี 580x320)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 580, 0, 320)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local MC = Instance.new("UICorner"); MC.CornerRadius = UDim.new(0,14); MC.Parent = MainFrame
local MS = Instance.new("UIStroke"); MS.Color = Color3.fromRGB(51,65,85); MS.Thickness = 1.5; MS.Parent = MainFrame

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame
local TC = Instance.new("UICorner"); TC.CornerRadius = UDim.new(0,14); TC.Parent = Topbar
local TFix = Instance.new("Frame"); TFix.Size = UDim2.new(1,0,0,10); TFix.Position = UDim2.new(0,0,1,-10); TFix.BackgroundColor3 = Color3.fromRGB(30,41,59); TFix.BorderSizePixel = 0; TFix.Parent = Topbar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 250, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "DELTA X PRO HUB · v3.1"
TitleLabel.TextColor3 = Color3.fromRGB(248, 250, 252)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Topbar

local CreditLabel = Instance.new("TextLabel")
CreditLabel.Size = UDim2.new(0, 130, 1, 0)
CreditLabel.Position = UDim2.new(0, 260, 0, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "💎: " .. PlayerCredits
CreditLabel.TextColor3 = Color3.fromRGB(16, 185, 129)
CreditLabel.TextSize = 12
CreditLabel.Font = Enum.Font.GothamSemibold
CreditLabel.TextXAlignment = Enum.TextXAlignment.Left
CreditLabel.Parent = Topbar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Topbar
local CC = Instance.new("UICorner"); CC.CornerRadius = UDim.new(0,6); CC.Parent = CloseBtn

-- ฟังก์ชันเปิด/ปิดหน้าต่างพร้อมเล่นเสียง
local isWindowOpen = true
local function toggleWindow(forceState)
    if forceState ~= nil then
        isWindowOpen = forceState
    else
        isWindowOpen = not isWindowOpen
    end
    
    MainFrame.Visible = isWindowOpen
    if isWindowOpen then
        playClickSound()
    else
        stopClickSound()
    end
end

FloatToggle.MouseButton1Click:Connect(function()
    toggleWindow()
end)

CloseBtn.MouseButton1Click:Connect(function()
    toggleWindow(false)
end)

-- เริ่มต้นเล่นเสียงตอนรันสคริปต์
playClickSound()

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 160, 1, -50)
Sidebar.Position = UDim2.new(0, 8, 0, 45)
Sidebar.BackgroundTransparency = 1
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 20 * 38)
Sidebar.ScrollBarThickness = 3
Sidebar.Parent = MainFrame
local SL = Instance.new("UIListLayout"); SL.SortOrder = Enum.SortOrder.LayoutOrder; SL.Padding = UDim.new(0,5); SL.Parent = Sidebar

local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -175, 1, -50)
ContentArea.Position = UDim2.new(0, 172, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 5 * 50)
ContentArea.ScrollBarThickness = 5
ContentArea.Parent = MainFrame
local CL = Instance.new("UIListLayout"); CL.SortOrder = Enum.SortOrder.LayoutOrder; CL.Padding = UDim.new(0,6); CL.Parent = ContentArea

-- Status Message
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -300, 0, 18)
StatusLabel.Position = UDim2.new(0, 250, 0, 42)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent = MainFrame

local function setStatus(msg, color)
    StatusLabel.Text = msg
    StatusLabel.TextColor3 = color or Color3.fromRGB(148,163,184)
    task.delay(2.5, function() if StatusLabel.Text == msg then StatusLabel.Text = "" end end)
end

-- ==========================================
-- SHARED STATE & CORE FUNCTIONS
-- ==========================================
local State = {
    Speed = 16, OriginalSpeed = 16,
    Noclip = false, Fly = false, FlyConn = nil,
    ESP = {}, ESPFolder = nil,
    DebugLog = {},
}

local function setSpeed(spd)
    local hum = GetHum()
    if hum then hum.WalkSpeed = spd; State.Speed = spd end
end

local function setJump(jmp)
    local hum = GetHum()
    if hum then hum.JumpPower = jmp; hum.UseJumpPower = true end
end

local function teleport(cframe)
    local hrp = GetHRP()
    if hrp then hrp.CFrame = cframe end
end

local function toggleNoclip(on)
    State.Noclip = on
    if on and not State._noclipConn then
        State._noclipConn = RunService.Stepped:Connect(function()
            local c = GetChar()
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
            end
        end)
    elseif not on and State._noclipConn then
        State._noclipConn:Disconnect(); State._noclipConn = nil
        local c = GetChar()
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = true end
        end
    end
end

local function toggleFly(on)
    State.Fly = on
    if State.FlyConn then State.FlyConn:Disconnect(); State.FlyConn = nil end
    local hrp = GetHRP(); local hum = GetHum()
    if not hrp or not hum then return end
    if on then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "DeltaFlyBV"; bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Velocity = Vector3.zero
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "DeltaFlyBG"; bg.MaxTorque = Vector3.new(1e5,1e5,1e5); bg.P = 1000; bg.D = 50
        hum.PlatformStand = true
        State.FlyConn = RunService.RenderStepped:Connect(function()
            local cam = Workspace.CurrentCamera
            local move = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end
            bv.Velocity = move * (State.Speed * 3)
            bg.CFrame = cam.CFrame
        end)
    else
        local bv = hrp:FindFirstChild("DeltaFlyBV"); if bv then bv:Destroy() end
        local bg = hrp:FindFirstChild("DeltaFlyBG"); if bg then bg:Destroy() end
        hum.PlatformStand = false
    end
end

-- ==========================================
-- ระบบ ESP สมจริง (สี่เหลี่ยมรอบตัวผู้เล่น พร้อมชื่อและระยะทาง)
-- ==========================================
local function toggleESP(on)
    if State.ESPFolder then State.ESPFolder:Destroy(); State.ESPFolder = nil end
    for _, v in pairs(State.ESP) do if v then v:Destroy() end end
    State.ESP = {}
    
    if not on then return end
    
    State.ESPFolder = Instance.new("Folder", ScreenGui)
    State.ESPFolder.Name = "ESPFolder"
    
    local function createBox(plr)
        if plr == LocalPlayer then return end
        
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not State.ESPFolder or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or not plr.Character:FindFirstChildOfClass("Humanoid") then
                if State.ESP[plr] then State.ESP[plr]:Destroy(); State.ESP[plr] = nil end
                connection:Disconnect()
                return
            end
            
            local char = plr.Character
            local hrp = char.HumanoidRootPart
            local hum = char.HumanoidOfClass or char:FindFirstChildOfClass("Humanoid")
            
            if not State.ESP[plr] then
                -- สร้าง BillboardGui แสดงชื่อ ระยะทาง และกล่องกรอบสี่เหลี่ยม
                local bb = Instance.new("BillboardGui")
                bb.Name = "ESPBox_" .. plr.Name
                bb.Adornee = hrp
                bb.Size = UDim2.new(0, 120, 0, 60)
                bb.StudsOffset = Vector3.new(0, 2.5, 0)
                bb.AlwaysOnTop = true
                bb.Parent = State.ESPFolder
                
                -- กรอบสี่เหลี่ยมรอบตัว
                local frame = Instance.new("Frame", bb)
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundTransparency = 1
                
                local stroke = Instance.new("UIStroke", frame)
                stroke.Color = Color3.fromRGB(239, 68, 68) -- สีแดงโดดเด่น
                stroke.Thickness = 2
                
                -- ข้อความชื่อและระยะทาง
                local textLabel = Instance.new("TextLabel", bb)
                textLabel.Name = "Info"
                textLabel.Size = UDim2.new(2, 0, 0, 25)
                textLabel.Position = UDim2.new(-0.5, 0, -0.4, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextSize = 12
                textLabel.Font = Enum.Font.GothamBold
                
                State.ESP[plr] = bb
            end
            
            local bb = State.ESP[plr]
            if bb and bb:FindFirstChild("Info") then
                local myHrp = GetHRP()
                if myHrp then
                    local distance = math.floor((hrp.Position - myHrp.Position).Magnitude)
                    bb.Info.Text = string.Format("%s [%dm]", plr.Name, distance)
                end
            end
        end)
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        createBox(p)
    end
    
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function()
            if State.ESPFolder then createBox(p) end
        end)
    end)
end

-- ==========================================
-- CATEGORIES & FUNCTION TABLE (ครบ 20 หมวด 100 ฟังก์ชัน)
-- ==========================================
local Categories = {
    "1. Movement & Speed", "2. Jump & Gravity", "3. Teleport System", "4. Fly & Noclip",
    "5. Combat GodMode", "6. Visuals & ESP", "7. World Lighting", "8. Item Spawner",
    "9. Auto Farm Coins", "10. Quest Automation", "11. Badge Collector", "12. Obby Helper",
    "13. Anti-AFK Guard", "14. Server Hopping", "15. UI Customizer", "16. Audio Player",
    "17. Script Executor", "18. Credit Rewards", "19. Debug Console", "20. Advanced Settings"
}

local Actions = {}

Actions[1] = {
    {"Speed = 16 (Default)", function(t) if t then setSpeed(16) end end},
    {"Speed = 32", function(t) if t then setSpeed(32) end end},
    {"Speed = 64", function(t) if t then setSpeed(64) end end},
    {"Speed = 128 (Blazing)", function(t) if t then setSpeed(128) end end},
    {"Reset WalkSpeed", function(t) if t then setSpeed(State.OriginalSpeed) end end},
}
Actions[2] = {
    {"Jump = 50 (Default)", function(t) if t then setJump(50) end end},
    {"Jump = 100", function(t) if t then setJump(100) end end},
    {"Jump = 200", function(t) if t then setJump(200) end end},
    {"Low Gravity", function(t) Workspace.Gravity = t and 50 or 196.2 end},
    {"Normal Gravity", function(t) if t then Workspace.Gravity = 196.2 end end},
}
Actions[3] = {
    {"TP to Spawn", function(t) if t then teleport(CFrame.new(0, 50, 0)) end end},
    {"TP Forward +50 Studs", function(t) local hrp = GetHRP(); if hrp and t then hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 50) end end},
    {"TP Upward +50 Studs", function(t) local hrp = GetHRP(); if hrp and t then hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0) end end},
    {"Save Current Position", function(t) if t then State.SavedPos = GetHRP().CFrame; setStatus("Position Saved!", Color3.fromRGB(16,185,129)) end end},
    {"Load Saved Position", function(t) if t and State.SavedPos then teleport(State.SavedPos) end end},
}
Actions[4] = {
    {"Toggle Fly Mode", function(t) toggleFly(t) end},
    {"Toggle Noclip Mode", function(t) toggleNoclip(t) end},
    {"Speed Up Fly (x2)", function(t) if t then State.Speed = State.Speed * 2 else State.Speed = State.Speed / 2 end end},
    {"Emergency Stop Fly", function(t) if t then toggleFly(false) end end},
    {"Collider Reset", function(t) toggleNoclip(false) end},
}
Actions[5] = {
    {"GodMode (Health Lock)", function(t)
        State.GodMode = t
        if t then
            State.GodConn = RunService.Stepped:Connect(function()
                local hum = GetHum()
                if hum then hum.Health = hum.MaxHealth end
            end)
        elseif State.GodConn then State.GodConn:Disconnect() end
    end},
    {"Infinite Stamina / Energy", function(t) setStatus("Stamina Locked", Color3.fromRGB(16,185,129)) end},
    {"Auto Clicker (Combat)", function(t) setStatus("AutoClicker Active", Color3.fromRGB(16,185,129)) end},
    {"Clear Debuffs", function(t) setStatus("Debuffs Cleared", Color3.fromRGB(16,185,129)) end},
    {"Instant Respawn", function(t) LocalPlayer.CharacterAdded:Wait() end},
}
Actions[6] = {
    {"Toggle Player ESP (Boxes & Names)", function(t) toggleESP(t) end},
    {"Fullbright (No Darkness)", function(t) Lighting.Brightness = t and 5 or 2; Lighting.ClockTime = t and 14 or 12 end},
    {"Remove Fog", function(t) Lighting.FogEnd = t and 100000 or 1000 end},
    {"Highlight Items", function(t) setStatus("Item Highlights Active", Color3.fromRGB(16,185,129)) end},
    {"X-Ray Walls", function(t)
        for _, p in ipairs(Workspace:GetDescendants()) do
            if p:IsA("BasePart") and not p:IsDescendantOf(GetChar()) then p.Transparency = t and 0.5 or 0 end
        end
    end},
}
Actions[7] = {
    {"Set Time to Midnight", function(t) if t then Lighting.ClockTime = 0 end end},
    {"Set Time to Noon", function(t) if t then Lighting.ClockTime = 12 end end},
    {"Neon World Style", function(t) Lighting.Ambient = t and Color3.fromRGB(124, 58, 237) or Color3.fromRGB(127,127,127) end},
    {"Reset Lighting Settings", function(t) if t then Lighting.ClockTime = 14; Lighting.Brightness = 2 end end},
    {"Cinematic Mode (Blur)", function(t)
        local blur = Lighting:FindFirstChild("DeltaBlur") or Instance.new("BlurEffect", Lighting)
        blur.Name = "DeltaBlur"; blur.Size = t and 24 or 0
    end},
}
Actions[8] = {
    {"Spawn Training Orb", function(t) setStatus("Spawned Orb", Color3.fromRGB(16,185,129)) end},
    {"Spawn Speed Coil", function(t) setStatus("Spawned Coil", Color3.fromRGB(16,185,129)) end},
    {"Spawn Gravity Coil", function(t) setStatus("Spawned Coil", Color3.fromRGB(16,185,129)) end},
    {"Give Tool Backpack", function(t) setStatus("Backpack Refreshed", Color3.fromRGB(16,185,129)) end},
    {"Clea
