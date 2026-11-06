--[[
    ================================================================
    🚀 ULTIMATE COMBINED UNIVERSAL HUB (รวมสคริปต์ Roblox ทั้งหมด)
    ================================================================
    รวมฟังก์ชันจาก:
      1. extrait.net.1.lua (UniversalHub 50 Func - EN)
      2. extrait.net.2.lua    (Universal Script Pack - Anti-Fall / Feature Pack)
      3. extrait.net.3.lua (ฮับสคริป 50 ฟังก์ชัน - TH)
    ================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ============================================================
-- 1. ระบบ UI หลัก (หน้าต่างลากได้ เมนูภาษาไทย)
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CombinedUniversalHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    if gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = CoreGui
    end
end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(32, 36, 52)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Ultimate Combined Universal Hub ⚡"
Title.TextColor3 = Color3.fromRGB(0, 220, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -36, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -52)
Scroll.Position = UDim2.new(0, 10, 0, 46)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 6
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

local autoY = 0
local function addLabel(txt)
    local l = Instance.new("TextLabel", Scroll)
    l.Size = UDim2.new(1, -10, 0, 25)
    l.BackgroundTransparency = 1
    l.Text = "▸ "..txt
    l.TextColor3 = Color3.fromRGB(255, 200, 0)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    autoY = autoY + 28
    Scroll.CanvasSize = UDim2.new(0, 0, 0, autoY)
end

local function addButton(name, callback)
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(44, 48, 66)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(44, 48, 66)}):Play()
    end)
    b.MouseButton1Click:Connect(function()
        pcall(callback)
        b.TextColor3 = Color3.fromRGB(0, 255, 120)
        task.delay(0.3, function() b.TextColor3 = Color3.new(1,1,1) end)
    end)
    autoY = autoY + 35
    Scroll.CanvasSize = UDim2.new(0, 0, 0, autoY)
end

local function addToggle(name, default, callback)
    local state = default or false
    local f = Instance.new("Frame", Scroll)
    f.Size = UDim2.new(1, -10, 0, 30)
    f.BackgroundColor3 = Color3.fromRGB(40, 44, 60)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1, -62, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.new(0.9,0.9,0.9)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(0, 46, 0, 20)
    btn.Position = UDim2.new(1, -54, 0.5, -10)
    btn.BackgroundColor3 = state and Color3.fromRGB(0,200,100) or Color3.fromRGB(80,80,80)
    btn.Text = state and "เปิด" or "ปิด"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0,200,100) or Color3.fromRGB(80,80,80)
        btn.Text = state and "เปิด" or "ปิด"
        pcall(callback, state)
    end)
    autoY = autoY + 35
    Scroll.CanvasSize = UDim2.new(0, 0, 0, autoY)
end

-- Helper Functions
local function getChar() return LP.Character or LP.CharacterAdded:Wait() end
local function getHum() return getChar():FindFirstChildOfClass("Humanoid") end
local function getHRP() return getChar():FindFirstChild("HumanoidRootPart") end
local function notify(text)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title="⚡ Combined Hub", Text=text, Duration=3}) end)
end

-- ============================================================
-- 2. รวมฟังก์ชันทั้งหมด (Movement, Combat, Vision, World)
-- ============================================================

-- 🏃 1. MOVEMENT (การเคลื่อนที่)
addLabel("═══ 🏃 การเคลื่อนที่ (Movement) ═══")

_G.Speed = 55
addToggle("เพิ่มความเร็วเดิน (Speed Hack 55)", false, function(on)
    task.spawn(function()
        while on do
            local h = getHum()
            if h then h.WalkSpeed = _G.Speed end
            task.wait(0.05)
        end
    end)
end)

addButton("⚡ WalkSpeed ปกติ (32)", function()
    local h = getHum(); if h then h.WalkSpeed = 32 end
end)

addButton("🚀 WalkSpeed สูงสุด (80)", function()
    local h = getHum(); if h then h.WalkSpeed = 80 end
end)

_G.JumpPower = 100
addToggle("เพิ่มแรงกระโดด (Jump Boost 100)", false, function(on)
    task.spawn(function()
        while on do
            local h = getHum()
            if h then h.UseJumpPower = true; h.JumpPower = _G.JumpPower end
            task.wait(0.05)
        end
    end)
end)

addButton("🦘 กระโดดสูงพิเศษ (150)", function()
    local h = getHum(); if h then h.UseJumpPower = true; h.JumpPower = 150 end
end)

_G.FlySpeed = 60
addToggle("✈️ ระบบบิน (WASD + Space + Shift/Ctrl)", false, function(on)
    local hrp = getHRP(); local hum = getHum()
    if not hrp then return end
    if not on then
        if hum then hum.PlatformStand = false end
        if hrp:FindFirstChild("FlyBV") then hrp.FlyBV:Destroy() end
        if hrp:FindFirstChild("FlyBG") then hrp.FlyBG:Destroy() end
        return
    end
    local bv = Instance.new("BodyVelocity", hrp); bv.Name = "FlyBV"
    bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Velocity = Vector3.zero
    local bg = Instance.new("BodyGyro", hrp); bg.Name = "FlyBG"
    bg.Power = 1e5; bg.D = 500; bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
    if hum then hum.PlatformStand = true end
    task.spawn(function()
        while bv.Parent == hrp do
            local dir = Camera.CFrame.LookVector
            local move = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + dir end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - dir end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
            bv.Velocity = move.Magnitude > 0 and (move.Unit * _G.FlySpeed) or Vector3.zero
            if bg then bg.CFrame = Camera.CFrame end
            task.wait()
        end
    end)
end)

addToggle("👻 เดินทะลุกำแพง (Noclip)", false, function(on)
    if on then
        _G.NoclipCon = RunService.Stepped:Connect(function()
            local c = getChar(); if not c then return end
            for _, v in pairs(c:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end)
    else
        if _G.NoclipCon then _G.NoclipCon:Disconnect() end
    end
end)

addToggle("🦘 กระโดดไม่จำกัด (Infinite Jump)", false, function(on)
    if on then
        _G.JumpBind = UserInputService.JumpRequest:Connect(function()
            local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if _G.JumpBind then _G.JumpBind:Disconnect() end
    end
end)

local antiFallEnabled = false
addToggle("🪂 ป้องกันตกแมพ (Anti-Fall)", false, function(on)
    antiFallEnabled = on
end)

RunService.Heartbeat:Connect(function()
    if antiFallEnabled then
        local hrp = getHRP()
        if hrp and hrp.Position.Y < -50 then
            hrp.CFrame = CFrame.new(hrp.Position.X, 100, hrp.Position.Y)
            notify("Anti-Fall ทำงาน: ช่วยเหลือก่อนตกแมพ!")
        end
    end
end)

-- 📍 2. TELEPORT & LOCATION (วาร์ปและบันทึกพิกัด)
addLabel("═══ 📍 วาร์ปและพิกัด (Teleport) ═══")

addButton("💾 บันทึกตำแหน่งปัจจุบัน", function()
    local pos = getHRP() and getHRP().CFrame
    if pos then _G.SavedPos = pos; notify("บันทึกตำแหน่งเรียบร้อย!") end
end)

addButton("🌀 วาร์ปกลับจุดที่บันทึก", function()
    if _G.SavedPos and getChar() then
        getChar():SetPrimaryPartCFrame(_G.SavedPos)
        notify("วาร์ปไปยังจุดเซฟแล้ว")
    else
        notify("ยังไม่ได้บันทึกตำแหน่ง!")
    end
end)

addButton("🏠 วาร์ปกลับจุดเกิด (Spawn Location)", function()
    local hrp = getHRP()
    local sp = Workspace:FindFirstChildOfClass("SpawnLocation")
    if hrp and sp then
        hrp.CFrame = sp.CFrame + Vector3.new(0, 5, 0)
        notify("วาร์ปกลับ Spawn แล้ว")
    else
        notify("ไม่พบ Spawn Location")
    end
end)

addButton("🎯 วาร์ปไปหาผู้เล่นคนแรกในเซิร์ฟเวอร์", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local myHrp = getHRP()
            if myHrp then myHrp.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0) end
            notify("วาร์ปไปหา: " .. p.Name)
            break
        end
    end
end)

-- ⚔️ 3. COMBAT & SYSTEM (ต่อสู้และระบบ)
addLabel("═══ ⚔️ ระบบต่อสู้ & เซิร์ฟเวอร์ ═══")

addToggle("🤿 ออกซิเจนไม่จำกัด (Infinite Oxygen)", false, function(on)
    task.spawn(function()
        while on do
            local c = getChar()
            if c then
                local b = c:FindFirstChild("Breath")
                if b then b:SetAttribute("Oxygen", 9999) end
            end
            task.wait(0.1)
        end
    end)
end)

addToggle("🛡️ ป้องกัน AFK (Anti-AFK)", false, function(on)
    if on then
        _G.AfkCon = LP.Idled:Connect(function()
            pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), Camera.CFrame) end)
            task.wait(1)
            pcall(function() game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), Camera.CFrame) end)
        end)
        notify("เปิดระบบ Anti-AFK แล้ว")
    else
        if _G.AfkCon then _G.AfkCon:Disconnect() end
    end
end)

addButton("💀 รีเซ็ตตัวละคร (Reset Character)", function()
    local h = getHum()
    if h then h.Health = 0 end
end)

addButton("🔄 Rejoin (เข้าห้องเดิมใหม่)", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)

addButton("🌐 Hop Server (สุ่มหาเซิร์ฟเวอร์ใหม่)", function()
    local ok, res = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if ok and res and res.data then
        for _, s in pairs(res.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, LP) end)
                return
            end
        end
    end
    notify("ไม่พบ Server ว่าง")
end)

addButton("📋 คัดลอก PlaceID", function()
    if setclipboard then
        setclipboard(tostring(game.PlaceId))
        notify("คัดลอก PlaceID ลงคลิปบอร์ดแล้ว!")
    end
end)

-- 👁️ 4. VISION & GRAPHICS (การมองเห็น)
addLabel("═══ 👁️ การมองเห็น & กราฟิก ═══")

addToggle("💡 สว่างเต็มที่ (Fullbright)", false, function(on)
    if on then
        _G.FB_old = {Ambient=Lighting.Ambient, Outdoor=Lighting.OutdoorAmbient, Brightness=Lighting.Brightness, FogEnd=Lighting.FogEnd}
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.OutdoorAmbient = Color3.new(1,1,1)
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e6
    else
        if _G.FB_old then
            Lighting.Ambient = _G.FB_old.Ambient
            Lighting.OutdoorAmbient = _G.FB_old.Outdoor
            Lighting.Brightness = _G.FB_old.Brightness
            Lighting.FogEnd = _G.FB_old.FogEnd
            Lighting.GlobalShadows = true
        end
    end
end)

addToggle("🔍 มองทะลุกำแพง (ESP Highlight)", false, function(on)
    if on then
        _G.hl = {}
        for _, p in pairs(Workspace:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                local h = Instance.new("Highlight", p)
                h.FillTransparency = 1
                h.OutlineColor = Color3.fromRGB(0, 255, 255)
                _G.hl[p] = h
            end
        end
    else
        if _G.hl then
            for _, h in pairs(_G.hl) do if h then h:Destroy() end end
            _G.hl = {}
        end
    end
end)

addToggle("🔒 ล็อกกล้องติดตามตัวละคร", false, function(on)
    if on then
        _G.LockCamCon = RunService.RenderStepped:Connect(function()
            local hrp = getHRP()
            if hrp then Camera.CFrame = CFrame.new(Camera.CFrame.Position, hrp.Position) end
        end)
    else
        if _G.LockCamCon then _G.LockCamCon:Disconnect() end
    end
end)

addToggle("🎥 กล้องระยะไกล (FOV 100)", false, function(on)
    Camera.FieldOfView = on and 100 or 70
end)

addButton("🔍 ซูมกล้องสุด (FOV 30)", function()
    Camera.FieldOfView = 30
end)

addButton("📷 รีเซ็ตกล้องปกติ (FOV 70)", function()
    Camera.FieldOfView = 70
end)

addToggle("🌫️ ปิดหมอก (Remove Fog)", false, function(on)
    Lighting.FogEnd = on and 1e5 or 1000
end)

addToggle("✨ เอฟเฟกต์ภาพ (Bloom Effect)", false, function(on)
    if on then
        local b = Instance.new("BloomEffect", Lighting)
        b.Intensity = 0.8
        b.Name = "HubBloom"
        _G.bl = b
    else
        if _G.bl then _G.bl:Destroy() end
    end
end)

-- ❌ ปิดเมนู
addLabel("═══ ❌ ปิดเมนู ═══")
addButton("❌ ทำลาย GUI นี้", function()
    ScreenGui:Destroy()
end)

-- Auto Re-apply Speed on Respawn
LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.WalkSpeed < 16 then hum.WalkSpeed = 16 end
end)

notify("โหลด Ultimate Combined Hub สำเร็จ!")
print("[Combined Hub] Loaded Successfully!")
