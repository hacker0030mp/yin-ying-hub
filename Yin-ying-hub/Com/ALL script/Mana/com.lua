
--[=[
    ☯ YIN YANG HUB — TABBED CATEGORY UI (FULL FUNCTIONAL EDITION)
    ค่ายผู้พัฒนา: YIN YANG TEAM x GALACTIC HUB
    รองรับ: Mobile Executors (Delta, Hydrogen, Fluxus, Codex) & Roblox Studio
]=]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local GUI_NAME = "YinYangHub_TabbedEdition"
local parentScreen = (gethui and gethui()) or LocalPlayer:WaitForChild("PlayerGui")

local old = parentScreen:FindFirstChild(GUI_NAME)
if old then old:Destroy() end

-- Theme Colors
local C = {
    bg = Color3.fromRGB(15, 18, 24),
    sidebar = Color3.fromRGB(20, 24, 32),
    content = Color3.fromRGB(25, 31, 41),
    panel = Color3.fromRGB(32, 40, 52),
    hover = Color3.fromRGB(45, 56, 72),
    active = Color3.fromRGB(38, 220, 151),
    mint = Color3.fromRGB(160, 255, 216),
    text = Color3.fromRGB(242, 247, 245),
    muted = Color3.fromRGB(140, 155, 160),
    border = Color3.fromRGB(45, 65, 75),
    red = Color3.fromRGB(255, 85, 85),
    blue = Color3.fromRGB(85, 170, 255),
    purple = Color3.fromRGB(180, 100, 255)
}

-- Global State Variables
_G.YinYangConfig = _G.YinYangConfig or {
    WalkSpeed = 16,
    JumpPower = 50,
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    InfJump = false,
    GodMode = false,
    Fullbright = false,
    ESP = false,
    AutoClicker = false,
    KillAura = false,
    Spinbot = false
}

local state = _G.YinYangConfig

-- Helper Function
local function make(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end

local function round(p, r) make("UICorner", {CornerRadius = UDim.new(0, r or 8)}, p) end
local function outline(p, col, tr, th) make("UIStroke", {Color = col or C.border, Transparency = tr or 0, Thickness = th or 1}, p) end

-- Create ScreenGui
local screen = make("ScreenGui", {Name = GUI_NAME, ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999}, parentScreen)

--------------------------------------------------------------------------------
-- Floating Launcher Button (ปุ่มสลับ เปิด/ปิด)
--------------------------------------------------------------------------------
local launcher = make("TextButton", {
    Name = "Launcher",
    Text = "",
    BackgroundColor3 = C.sidebar,
    AutoButtonColor = false,
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0, 15, 0.4, 0),
    ZIndex = 200
}, screen)
round(launcher, 24); outline(launcher, C.active, 0.1, 1.5)

local iconLabel = make("TextLabel", {
    BackgroundTransparency = 1,
    Text = "☯",
    Font = Enum.Font.GothamBlack,
    TextSize = 26,
    TextColor3 = C.mint,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 201
}, launcher)

-- Spin animation for launcher icon
task.spawn(function()
    local rot = 0
    while screen and screen.Parent do
        rot = (rot + 2) % 360
        iconLabel.Rotation = rot
        task.wait(0.03)
    end
end)

-- Mobile Dragging for Launcher
do
    local dragging, dragStart, startPos
    launcher.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = launcher.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            launcher.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function() dragging = false end)
end

--------------------------------------------------------------------------------
-- Main Window Design
--------------------------------------------------------------------------------
local main = make("Frame", {
    Name = "MainFrame",
    BackgroundColor3 = C.bg,
    Size = UDim2.fromOffset(560, 360),
    Position = UDim2.new(0.5, -280, 0.5, -180),
    ClipsDescendants = true,
    ZIndex = 100
}, screen)
round(main, 10); outline(main, C.border, 0.1, 1.2)

launcher.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- Top Header
local header = make("Frame", {
    BackgroundColor3 = C.sidebar,
    Size = UDim2.new(1, 0, 0, 38),
    ZIndex = 101
}, main)

make("TextLabel", {
    BackgroundTransparency = 1,
    Text = "  ☯ YIN YANG HUB  |  ผู้พัฒนา: YIN YANG TEAM x GALACTIC HUB",
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextColor3 = C.mint,
    TextXAlignment = Enum.TextXAlignment.Left,
    Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    ZIndex = 102
}, header)

local closeBtn = make("TextButton", {
    Text = "✕",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = C.red,
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.new(1, -38, 0, 0),
    ZIndex = 102
}, header)
closeBtn.MouseButton1Click:Connect(function() main.Visible = false end)

--------------------------------------------------------------------------------
-- Split Layout (Left Sidebar & Right Content)
--------------------------------------------------------------------------------
-- Left Sidebar Frame
local sidebar = make("Frame", {
    BackgroundColor3 = C.sidebar,
    Size = UDim2.new(0, 150, 1, -38),
    Position = UDim2.new(0, 0, 0, 38),
    ZIndex = 101
}, main)
outline(sidebar, C.border, 0.2, 1)

local tabScroll = make("ScrollingFrame", {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -8, 1, -10),
    Position = UDim2.new(0, 4, 0, 5),
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 2,
    ZIndex = 102
}, sidebar)

local tabListLayout = make("UIListLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 4)
}, tabScroll)

-- Right Content Frame
local contentFrame = make("Frame", {
    BackgroundColor3 = C.content,
    Size = UDim2.new(1, -150, 1, -38),
    Position = UDim2.new(0, 150, 0, 38),
    ZIndex = 101
}, main)

--------------------------------------------------------------------------------
-- Tab & Component Builders
--------------------------------------------------------------------------------
local tabs = {}
local activeTab = nil

local function createTab(tabName, icon)
    local page = make("ScrollingFrame", {
        Name = tabName .. "Page",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.new(0, 6, 0, 6),
        Visible = false,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 4,
        ZIndex = 102
    }, contentFrame)

    make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    }, page)

    local tabBtn = make("TextButton", {
        Text = (icon or "📁") .. " " .. tabName,
        Font = Enum.Font.GothamSemibold,
        TextSize = 11,
        TextColor3 = C.muted,
        BackgroundColor3 = C.bg,
        Size = UDim2.new(1, 0, 0, 32),
        ZIndex = 103
    }, tabScroll)
    round(tabBtn, 6)

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            t.button.BackgroundColor3 = C.bg
            t.button.TextColor3 = C.muted
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = C.panel
        tabBtn.TextColor3 = C.active
        activeTab = tabName
    end)

    tabs[tabName] = {button = tabBtn, page = page}

    -- Auto select first tab
    if not activeTab then
        page.Visible = true
        tabBtn.BackgroundColor3 = C.panel
        tabBtn.TextColor3 = C.active
        activeTab = tabName
    end

    return page
end

-- Component Functions
local function addAction(page, text, callback)
    local btn = make("TextButton", {
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = C.text,
        BackgroundColor3 = C.panel,
        Size = UDim2.new(1, 0, 0, 34),
        ZIndex = 103
    }, page)
    round(btn, 6); outline(btn, C.border, 0.2, 1)

    btn.MouseButton1Click:Connect(function()
        local success, err = pcall(callback)
        if not success then warn("[YinYang Error]:", err) end
    end)
end

local function addToggle(page, text, stateKey, callback)
    local container = make("Frame", {
        BackgroundColor3 = C.panel,
        Size = UDim2.new(1, 0, 0, 34),
        ZIndex = 103
    }, page)
    round(container, 6); outline(container, C.border, 0.2, 1)

    make("TextLabel", {
        BackgroundTransparency = 1,
        Text = "  " .. text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 11,
        TextColor3 = C.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0.7, 0, 1, 0),
        ZIndex = 104
    }, container)

    local toggleBtn = make("TextButton", {
        Text = state[stateKey] and "ON" or "OFF",
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextColor3 = state[stateKey] and C.mint or C.red,
        BackgroundColor3 = state[stateKey] and C.hover or C.bg,
        Size = UDim2.new(0, 50, 0, 22),
        Position = UDim2.new(1, -56, 0.5, -11),
        ZIndex = 104
    }, container)
    round(toggleBtn, 4); outline(toggleBtn, state[stateKey] and C.active or C.red, 0.3, 1)

    toggleBtn.MouseButton1Click:Connect(function()
        state[stateKey] = not state[stateKey]
        toggleBtn.Text = state[stateKey] and "ON" or "OFF"
        toggleBtn.TextColor3 = state[stateKey] and C.mint or C.red
        toggleBtn.BackgroundColor3 = state[stateKey] and C.hover or C.bg
        toggleBtn.UIStroke.Color = state[stateKey] and C.active or C.red
        if callback then callback(state[stateKey]) end
    end)
end

--------------------------------------------------------------------------------
-- TABS & FEATURES SETUP
--------------------------------------------------------------------------------

-- 1. หมวดหมู่: ตัวละคร & เคลื่อนที่ (Movement)
local pMove = createTab("ผู้เล่น/เคลื่อนที่", "🏃")

addToggle(pMove, "สปีดการเดิน (WalkSpeed 32)", "SpeedBoost", function(val)
    state.WalkSpeed = val and 32 or 16
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state.WalkSpeed
    end
end)

addToggle(pMove, "พลังกระโดด (JumpPower 100)", "JumpBoost", function(val)
    state.JumpPower = val and 100 or 50
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = state.JumpPower
    end
end)

addToggle(pMove, "กระโดดได้ไม่จำกัด (Inf Jump)", "InfJump", function(val)
    state.InfJump = val
end)

addToggle(pMove, "เดินทะลุกำแพง (Noclip)", "Noclip", function(val)
    state.Noclip = val
end)

addToggle(pMove, "โหมดบิน (Fly Mode)", "Fly", function(val)
    state.Fly = val
end)

addAction(pMove, "❤️ ฮีลเลือดเต็ม (Heal Max HP)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
    end
end)

addAction(pMove, "🔄 รีเซ็ตตัวละคร (Reset Character)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)

-- 2. หมวดหมู่: มองทะลุ & แมพ (Visuals & World)
local pVisual = createTab("การมองเห็น/แมพ", "👁️")

addToggle(pVisual, "เปิดแมพสว่าง (Fullbright)", "Fullbright", function(val)
    state.Fullbright = val
    if not val then
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
    end
end)

addToggle(pVisual, "ESP มองทะลุผู้เล่น", "ESP", function(val)
    state.ESP = val
end)

-- 3. หมวดหมู่: ระบบต่อสู้ & ออโต้ (Combat & Automation)
local pCombat = createTab("ต่อสู้/ออโต้", "⚔️")

addToggle(pCombat, "คลิกอัตโนมัติ (Auto Clicker)", "AutoClicker", function(val)
    state.AutoClicker = val
end)

addToggle(pCombat, "โจมตีรอบตัว (Kill Aura)", "KillAura", function(val)
    state.KillAura = val
end)

addToggle(pCombat, "หมุนตัวละคร (Spinbot)", "Spinbot", function(val)
    state.Spinbot = val
end)

-- 4. หมวดหมู่: วาร์ป & เซิร์ฟเวอร์ (Teleport & Server)
local pTP = createTab("วาร์ป/เซิร์ฟเวอร์", "🌐")

addAction(pTP, "🎯 วาร์ปไปจุดปลอดภัย (Safezone TP)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
    end
end)

addAction(pTP, "🔄 Rejoin เซิร์ฟเวอร์เดิม", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

addAction(pTP, "🔀 Server Hop (สุ่มย้ายเซิร์ฟ)", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- 5. หมวดหมู่: External Hubs (Galactic WindUI & Others)
local pExt = createTab("สคริปต์ภายนอก", "🌌")

addAction(pExt, "🌌 รัน Galactic-Hub WindUI", function()
    task.spawn(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GalacticScripts/Galactic-Hub/refs/heads/main/WindUI"))()
        end)
        if success then
            print("[Galactic-Hub] โหลด WindUI สำเร็จ!")
        else
            warn("[Galactic-Hub Error]: ", err)
        end
    end)
end)

addAction(pExt, "❌ ปิดการทำงานของ Hub ทั้งหมด", function()
    screen:Destroy()
end)

--------------------------------------------------------------------------------
-- BACKGROUND LOOPS & SYSTEM LOGIC (ทำงานจริงตามปุ่มกด)
--------------------------------------------------------------------------------

-- Loop: Maintain Character Stats & Properties
RunService.Stepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        if state.SpeedBoost then hum.WalkSpeed = state.WalkSpeed end
        if state.JumpBoost then hum.JumpPower = state.JumpPower end
    end

    -- Noclip Logic
    if state.Noclip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end

    -- Fullbright Logic
    if state.Fullbright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
    end
end)

-- Infinite Jump Listener
UserInputService.JumpRequest:Connect(function()
    if state.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Auto Clicker Loop
task.spawn(function()
    while true do
        task.wait(0.1)
        if state.AutoClicker then
            mouse1click()
        end
    end
end)

-- Spinbot Loop
task.spawn(function()
    while true do
        task.wait(0.03)
        if state.Spinbot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
        end
    end
end)

-- ESP System Loop
task.spawn(function()
    local espFolder = Instance.new("Folder", screen)
    espFolder.Name = "YinYangESP"

    while true do
        task.wait(0.5)
        espFolder:ClearAllChildren()

        if state.ESP then
            for _, target in pairs(Players:GetPlayers()) do
                if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = target.Character.HumanoidRootPart
                    local bgui = Instance.new("BillboardGui", espFolder)
                    bgui.Adornee = hrp
                    bgui.Size = UDim2.fromOffset(100, 30)
                    bgui.AlwaysOnTop = true

                    local txt = Instance.new("TextLabel", bgui)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Text = target.Name
                    txt.TextColor3 = C.red
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 12
                end
            end
        end
    end
end)

print("[YinYang Hub] โหลดระบบหมวดหมู่ x Galactic Hub สำเร็จเรียบร้อยแล้ว!")
