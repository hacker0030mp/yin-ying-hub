--[[
    ██╗   ██╗███╗   ██╗██╗██╗   ██╗███████╗██████╗ ███████╗ █████╗ ██╗     
    ██║   ██║████╗  ██║██║██║   ██║██╔════╝██╔══██╗██╔════╝██╔══██╗██║     
    ██║   ██║██╔██╗ ██║██║██║   ██║█████╗  ██████╔╝███████╗███████║██║     
    ██║   ██║██║╚██╗██║██║╚██╗ ██╔╝██╔══╝  ██╔══██╗╚════██║██╔══██║██║     
    ╚██████╔╝██║ ╚████║██║ ╚████╔╝ ███████╗██║  ██║███████║██║  ██║███████╗
     ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ============================================================
-- 1. ระบบ UI หลัก (Draggable + Toggle)
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalHub_50Func"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 400)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ UniversalHub | 50 Functions ⚡"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -50)
Scroll.Position = UDim2.new(0, 10, 0, 45)
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
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}):Play()
    end)
    b.MouseButton1Click:Connect(function()
        pcall(callback)
        b.TextColor3 = Color3.fromRGB(0, 255, 100)
        task.delay(0.3, function() b.TextColor3 = Color3.new(1,1,1) end)
    end)
    autoY = autoY + 35
    Scroll.CanvasSize = UDim2.new(0, 0, 0, autoY)
end

local function addToggle(name, default, callback)
    local state = default or false
    local f = Instance.new("Frame", Scroll)
    f.Size = UDim2.new(1, -10, 0, 30)
    f.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    
    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.new(0.9,0.9,0.9)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(0, 45, 0, 20)
    btn.Position = UDim2.new(1, -52, 0.5, -10)
    btn.BackgroundColor3 = state and Color3.fromRGB(0,200,100) or Color3.fromRGB(80,80,80)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0,200,100) or Color3.fromRGB(80,80,80)
        btn.Text = state and "ON" or "OFF"
        pcall(callback, state)
    end)
    autoY = autoY + 35
    Scroll.CanvasSize = UDim2.new(0, 0, 0, autoY)
end

-- ============================================================
-- 2. ระบบ Character / Helper
-- ============================================================
local function getChar() return LP.Character or LP.CharacterAdded:Wait() end
local function getHum() return getChar():FindFirstChildOfClass("Humanoid") end
local function getHRP() return getChar():FindFirstChild("HumanoidRootPart") end
local function notify(text)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title="⚡ UniversalHub", Text=text, Duration=3}) end)
end

-- ============================================================
-- 3. ฟังก์ชันหลัก 50 อย่าง (จัดหมวด)
-- ============================================================

-- 🌟 [1-6] ระบบเคลื่อนที่
addLabel("═══ 🏃 MOVEMENT (1-6) ═══")
_G.Speed = 50
addToggle("Speed Hack (ใส่ค่า 50)", false, function(on)
    task.spawn(function()
        while on do
            local h = getHum(); if h then h.WalkSpeed = _G.Speed end
            task.wait(0.05)
        end
    end)
end)

_G.Jump = 100
addToggle("Jump Boost", false, function(on)
    task.spawn(function()
        while on do
            local h = getHum(); if h then h.JumpPower = _G.Jump; h.UseJumpPower = true end
            task.wait(0.05)
        end
    end)
end)

_G.FlySpeed = 60
addToggle("Fly (WASD)", false, function(on)
    local char = getChar(); local hrp = char:FindFirstChild("HumanoidRootPart"); local hum = getHum()
    if not hrp then return end
    if not on then
        hum.PlatformStand = false
        return
    end
    local bv = Instance.new("BodyVelocity", hrp); bv.Name="FlyBV"
    bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Velocity = Vector3.zero
    local bg = Instance.new("BodyGyro", hrp); bg.Name="FlyBG"
    bg.Power = 1e5; bg.D = 500; bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
    hum.PlatformStand = true
    task.spawn(function()
        while bv.Parent == hrp do
            local dir = Camera.CFrame.LookVector
            local move = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + dir end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - dir end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Camera.CFrame.RightVector * -1 end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
            bv.Velocity = move.Magnitude > 0 and (move.Unit * _G.FlySpeed) or Vector3.zero
            task.wait()
        end
    end)
end)

addToggle("Noclip (ทะลุสิ่งของ)", false, function(on)
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

addToggle("Infinite Jump", false, function(on)
    if on then
        _G.JumpBind = UserInputService.JumpRequest:Connect(function()
            local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if _G.JumpBind then _G.JumpBind:Disconnect() end
    end
end)

addButton("Teleport ไปยังจุดที่ Save", function()
    local pos = getHRP() and getHRP().CFrame
    if pos then _G.SavedPos = pos; notify("SAVE ตำแหน่งแล้ว") end
end)
addButton("กลับไปยังจุดที่ Save", function()
    if _G.SavedPos then getChar():SetPrimaryPartCFrame(_G.SavedPos) end
end)

-- ⚔️ [7-10] ระบบ INF ต่างๆ
addLabel("═══ ⚔️ COMBAT (7-10) ═══")
addToggle("Infinite Oxygen", false, function(on)
    task.spawn(function()
        while on do
            local c = getChar(); if c then local b = c:FindFirstChild("Breath"); if b then b:SetAttribute("Oxygen", 9999) end end
            task.wait(0.1)
        end
    end)
end)

addToggle("Anti AFK", false, function(on)
    if on then
        _G.AfkCon = LP.Idled:Connect(function()
            pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), Camera.CFrame) end)
            task.wait(1)
            pcall(function() game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), Camera.CFrame) end)
        end)
    else
        if _G.AfkCon then _G.AfkCon:Disconnect() end
    end
end)

addButton("Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)

addButton("Hop Random Server", function()
    local http = game:GetService("HttpService")
    local ok, res = pcall(function()
        return http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if ok then
        for _, s in pairs(res.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id, LP) end)
                return
            end
        end
    end
    notify("ไม่พบ Server ว่าง")
end)

-- 👁️ [11-18] ระบบมองเห็น / กล้อง
addLabel("═══ 👁️ VISION (11-18) ═══")
addToggle("Fullbright", false, function(on)
    if on then
        _G.FB_old = {Ambient=Lighting.Ambient, Outdoor=Lighting.OutdoorAmbient, Brightness=Lighting.Brightness}
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.OutdoorAmbient = Color3.new(1,1,1)
        Lighting.Brightness = 5
        task.spawn(function()
            while Lighting.Ambient == Color3.new(1,1,1) do
                if Lighting.FogEnd < 1e5 then Lighting.FogEnd = 1e5 end
                task.wait(0.5)
            end
        end)
    else
        if _G.FB_old then
            Lighting.Ambient = _G.FB_old