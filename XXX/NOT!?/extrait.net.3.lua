--[[
    Universal Script | Feature Pack
    ใช้ได้ทุกแมพ - รันใน Executor
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LP = Players.LocalPlayer

-- ============================================
-- 1. ป้องกันการถูก Kick จาก WaitForChild
-- ============================================
pcall(function()
    for _, v in ipairs(game:GetDescendants()) do end
end)

-- ============================================
-- 2. GUI หลัก
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if protect_gui then protect_gui(ScreenGui) else
    if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = game:GetService("CoreGui") end
end

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 240, 0, 320)
Main.Position = UDim2.new(0, 20, 0, 100)
Main.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 34)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Title.BorderSizePixel = 0
Title.Text = "🌐 Universal Hub"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = Main
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -44)
Scroll.Position = UDim2.new(0, 5, 0, 39)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 6)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

local function makeBtn(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -6, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.Parent = Scroll
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
    return b
end

-- ============================================
-- 3. ฟีเจอร์
-- ============================================

-- WalkSpeed
makeBtn("⚡ Speed ปกติ (32)", function()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 32 end
end)

makeBtn("🚀 ลดน้ำหนัก (x3)", function()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 80 end
end)

-- Jump
makeBtn("🦘 กระโดดสูง", function()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 150 end
end)

-- Anti-Fall (ไม่ตกแมพ)
local antiFall = false
makeBtn("🪂 Anti-Fall [OFF]", function(btn)
    antiFall = not antiFall
    btn.Text = "🪂 Anti-Fall [" .. (antiFall and "ON" or "OFF") .. "]"
end)

-- Noclip
local noclipCon
makeBtn("👻 Noclip", function()
    if noclipCon then noclipCon:Disconnect(); noclipCon = nil return end
    noclipCon = RunService.Stepped:Connect(function()
        if LP.Character then
            for _, v in ipairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
            end
        end
    end)
end)

-- Fullbright
makeBtn("💡 Fullbright", function()
    Lighting.Brightness = 3
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e6
    pcall(function() Lighting.EnvironmentDiffuseScale = 1 end)
end)

-- Teleport ไปจุด Spawn
makeBtn("🏠 กลับจุดเกิด", function()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local sp = workspace:FindFirstChildOfClass("SpawnLocation")
    if hrp and sp then hrp.CFrame = sp.CFrame + Vector3.new(0, 5, 0) end
end)

-- กระโดดบิน (Fly ง่ายๆ)
local flying, flyBV, flyBG
makeBtn("✈️ Fly [Toggle]", function(btn)
    if flying then
        flying = false
        if flyBV then flyBV:Destroy() end
        if flyBG then flyBG:Destroy() end
        btn.Text = "✈️ Fly [Toggle]"
        return
    end
    flying = true
    btn.Text = "✈️ Fly [ON]"
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    flyBV = Instance.new("BodyVelocity", hrp)
    flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
    flyBV.Velocity = Vector3.new(0,0,0)
    flyBG = Instance.new("BodyGyro", hrp)
    flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
    flyBG.P = 1e4
    flyBG.CFrame = hrp.CFrame
    local cam = workspace.CurrentCamera
    local con = RunService.RenderStepped:Connect(function()
        if not flying then con:Disconnect() return end
        local dir = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
        if flyBV then flyBV.Velocity = dir * 60 end
        if flyBG and hrp then flyBG.CFrame = cam.CFrame end
    end)
end)

-- ดูผู้เล่นในเซิร์ฟเวอร์ + TP
makeBtn("🎯 TP หาผู้เล่นคนแรก", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local myHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if myHrp then myHrp.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0) end
            break
        end
    end
end)

-- Rejoin เซิร์ฟเวอร์
makeBtn("🔄 Rejoin", function()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end)
end)

-- เก็บ Asset ไป clipboard
makeBtn("📋 Copy PlaceID", function()
    if setclipboard then setclipboard(tostring(game.PlaceId)) end
end)

-- ปิด GUI
makeBtn("❌ ปิดเมนู", function()
    ScreenGui:Destroy()
end)

-- ============================================
-- 4. Anti-Fall Loop
-- ============================================
RunService.Heartbeat:Connect(function()
    if antiFall and LP.Character then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Position.Y < -50 then
            hrp.CFrame = CFrame.new(0, 100, 0)
        end
    end
end)

-- ============================================
-- 5. Re-apply ขนาดตัวหลัง respawn (ถ้าเกมรีเซ็ต)
-- ============================================
LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = math.max(hum.WalkSpeed, 20) end
end)

print("[UniversalHub] โหลดสำเร็จ!")