--[=[
    ☯ YIN YANG HUB — TABBED CATEGORY UI (FIXED & FUNCTIONAL EDITION)
]=]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
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
    Fullbright = false,
    ESP = false,
    AutoClicker = false,
    KillAura = false,
    Spinbot = false,
    EmoteSpeed = false,
    AutoKillAura = false
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
-- Floating Launcher Button
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

local header = make("Frame", {
    BackgroundColor3 = C.sidebar,
    Size = UDim2.new(1, 0, 0, 38),
    ZIndex = 101
}, main)

make("TextLabel", {
    BackgroundTransparency = 1,
    Text = "  ☯ YIN YANG HUB  |  Fixed Edition",
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

-- Split Layout
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

make("UIListLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 4)
}, tabScroll)

local contentFrame = make("Frame", {
    BackgroundColor3 = C.content,
    Size = UDim2.new(1, -150, 1, -38),
    Position = UDim2.new(0, 150, 0, 38),
    ZIndex = 101
}, main)

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

    if not activeTab then
        page.Visible = true
        tabBtn.BackgroundColor3 = C.panel
        tabBtn.TextColor3 = C.active
        activeTab = tabName
    end

    return page
end

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

-- 1. หมวดหมู่: ตัวละคร & เคลื่อนที่
local pMove = createTab("ผู้เล่น/เคลื่อนที่", "🏃")

addToggle(pMove, "วิ่งตอนเต้น (Emote Speed)", "EmoteSpeed", function(val)
    state.EmoteSpeed = val
end)

addToggle(pMove, "พลังกระโดด (JumpPower 100)", "JumpBoost", function(val)
    state.JumpPower = val and 100 or 50
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
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

-- 2. หมวดหมู่: มองทะลุ & แมพ
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

-- 3. หมวดหมู่: ต่อสู้ & ออโต้
local pCombat = createTab("ต่อสู้/ออโต้", "⚔️")

addToggle(pCombat, "คลิกอัตโนมัติ (Auto Clicker)", "AutoClicker", function(val)
    state.AutoClicker = val
end)

addToggle(pCombat, "หมุนตัวละคร (Spinbot)", "Spinbot", function(val)
    state.Spinbot = val
end)

addToggle(pCombat, "โจมตีออร่า (KillAura - Dmg 10B)", "KillAura", function(val)
    state.KillAura = val
end)

addToggle(pCombat, "ออโต้คิลล์ออร่า (AutoKillAura - Dmg 10B)", "AutoKillAura", function(val)
    state.AutoKillAura = val
end)

-- 4. หมวดหมู่: วาร์ป & เซิร์ฟเวอร์
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

-- 5. หมวดหมู่: External Hubs
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
-- BACKGROUND LOOPS & SYSTEM LOGIC
--------------------------------------------------------------------------------

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        
        -- รองรับระบบวิ่งตอนเต้น
        if state.EmoteSpeed then
            pcall(function()
                for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                    track:AdjustSpeed(2.0)
                end
            end)
        end
    end

    -- Noclip Logic
    if state.Noclip and char then
        for _, v in pairs(char:GetChildren()) do
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
            pcall(function()
                if mouse1click then mouse1click() end
            end)
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

-- KillAura / AutoKillAura Logic (ดาเมจปรับเป็น 10,000,000,000)
task.spawn(function()
    while true do
        task.wait(0.5)
        if state.KillAura or state.AutoKillAura then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local myRoot = char.HumanoidRootPart
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local enemyRoot = player.Character.HumanoidRootPart
                            local distance = (myRoot.Position - enemyRoot.Position).Magnitude
                            if distance < 15 then
                                local enemyHum = player.Character:FindFirstChild("Humanoid")
                                if enemyHum and enemyHum.Health > 0 then
                                    enemyHum.Health = math.max(0, enemyHum.Health - 10000000000)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

print("[YinYang Hub] อัปเดตดาเมจ 10,000,000,000 เรียบร้อยแล้ว!")
