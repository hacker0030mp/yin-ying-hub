--[[
    ══════════════════════════════════════════════
    ⚡ UNIVERSAL HUB 50 ฟังก์ชัน (ภาษาไทย) ⚡
    ใช้ได้ทุกแมพ | UI ลากได้ | กด RightShift เปิด/ปิด
    ══════════════════════════════════════════════
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local WS = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local VIM = game:GetService("VirtualInputManager")
local Http = game:GetService("HttpService")

local LP = Players.LocalPlayer
local Cam = WS.CurrentCamera

-- ════════ ระบบ UI ════════
local Gui = Instance.new("ScreenGui")
Gui.Name = "ThaiHub50"
Gui.ResetOnSpawn = false
pcall(function() Gui.Parent = CoreGui end)
if not Gui.Parent then Gui.Parent = LP:WaitForChild("PlayerGui") end

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 520, 0, 420)
Main.Position = UDim2.new(0.3, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 42)
Top.BackgroundColor3 = Color3.fromRGB(32, 36, 52)
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 12)

local Ttl = Instance.new("TextLabel", Top)
Ttl.Size = UDim2.new(1, -50, 1, 0)
Ttl.Position = UDim2.new(0, 12, 0, 0)
Ttl.BackgroundTransparency = 1
Ttl.Text = "⚡ ฮับสคริป 50 ฟังก์ชัน ⚡"
Ttl.TextColor3 = Color3.fromRGB(0, 220, 255)
Ttl.Font = Enum.Font.GothamBold
Ttl.TextSize = 16
Ttl.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -36, 0, 6)
Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Close.Text = "✕"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
Close.MouseButton1Click:Connect(function() Main.Visible = false end)

local Sc = Instance.new("ScrollingFrame", Main)
Sc.Size = UDim2.new(1, -20, 1, -52)
Sc.Position = UDim2.new(0, 10, 0, 46)
Sc.BackgroundTransparency = 1
Sc.BorderSizePixel = 0
Sc.ScrollBarThickness = 6
Sc.CanvasSize = UDim2.new(0, 0, 0, 0)

local Lay = Instance.new("UIListLayout", Sc)
Lay.Padding = UDim.new(0, 5)
Lay.SortOrder = Enum.SortOrder.LayoutOrder

local Y = 0
local function หัวข้อ(t)
    local l = Instance.new("TextLabel", Sc)
    l.Size = UDim2.new(1, -10, 0, 24)
    l.BackgroundTransparency = 1
    l.Text = "▸ "..t
    l.TextColor3 = Color3.fromRGB(255, 200, 0)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    Y = Y + 28; Sc.CanvasSize = UDim2.new(0,0,0,Y)
end

local function ปุ่ม(ชื่อ, fn)
    local b = Instance.new("TextButton", Sc)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(44, 48, 66)
    b.Text = ชื่อ
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseEnter:Connect(function() Tween:Create(b,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(0,150,255)}):Play() end)
    b.MouseLeave:Connect(function() Tween:Create(b,TweenInfo.new(.15),{BackgroundColor3=Color3.fromRGB(44,48,66)}):Play() end)
    b.MouseButton1Click:Connect(function()
        pcall(fn)
        b.TextColor3 = Color3.fromRGB(0,255,120)
        task.delay(.3, function() b.TextColor3 = Color3.new(1,1,1) end)
    end)
    Y = Y + 35; Sc.CanvasSize = UDim2.new(0,0,0,Y)
end

local function สวิตช์(ชื่อ, ตั้งต้น, fn)
    local st = ตั้งต้น or false
    local f = Instance.new("Frame", Sc)
    f.Size = UDim2.new(1, -10, 0, 30)
    f.BackgroundColor3 = Color3.fromRGB(40, 44, 60)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -62, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = ชื่อ
    l.TextColor3 = Color3.fromRGB(.9,.9,.9)
    l.Font = Enum.Font.Gotham
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 46, 0, 20)
    b.Position = UDim2.new(1, -54, .5, -10)
    b.BackgroundColor3 = st and Color3.fromRGB(0,200,100) or Color3.fromRGB(80,80,80)
    b.Text = st and "เปิด" or "ปิด"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    b.MouseButton1Click:Connect(function()
        st = not st
        b.BackgroundColor3 = st and Color3.fromRGB(0,200,100) or Color3.fromRGB(80,80,80)
        b.Text = st and "เปิด" or "ปิด"
        pcall(fn, st)
    end)
    Y = Y + 35; Sc.CanvasSize = UDim2.new(0,0,0,Y)
end

-- ════════ Helper ════════
local function ตัวละคร() return LP.Character or LP.CharacterAdded:Wait() end
local function ฮูแมน() return ตัวละคร():FindFirstChildOfClass("Humanoid") end
local function หลัก() return ตัวละคร():FindFirstChild("HumanoidRootPart") end
local function แจ้ง(txt)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="⚡ ฮับไทย",Text=txt,Duration=3}) end)
end

-- ════════ [1-6] การเคลื่อนที่ ════════
หัวข้อ("═══ 🏃 การเคลื่อนที่ (1-6) ═══")
_G.ความเร็ว = 55
สวิตช์("เพิ่มความเร็วเดิน (Speed)", false, function(เปิด)
    task.spawn(function()
        while เปิด do local h=ฮูแมน(); if h then h.WalkSpeed=_G.ความเร็ว end; task.wait(.05) end
    end)
end)
สวิตช์("เพิ่มแรงกระโดด (Jump)", false, function(เปิด)
    task.spawn(function()
        while เปิด do local h=ฮูแมน(); if h then h.UseJumpPower=true; h.JumpPower=100 end; task.wait(.05) end
    end)
end)
สวิตช์("บินได้ (WASD + Space)", false, function(เปิด)
    local hrp=หลัก(); local h=ฮูแมน(); if not hrp then return end
    if not เปิด then h.PlatformStand=false; if hrp:FindFirstChild("บินV") then hrp.บินV:Destroy() end; if hrp:FindFirstChild("บินG") then hrp.บินG:Destroy() end; return end
    local bv=Instance.new("BodyVelocity",hrp); bv.Name="บินV"; bv.MaxForce=Vector3.new(1e5,1e5,1e5); bv.Velocity=Vector3.zero
    local bg=Instance.new("BodyGyro",hrp); bg.Name="บินG"; bg.Power=1e5; bg.MaxTorque=Vector3.new(1e5,1e5,1e5)
    h.PlatformStand=true
    task.spawn(function()
        while bv.Parent==hrp do
            local d=Cam.CFrame.LookVector; local m=Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then m=m+d end
            if UIS:IsKeyDown(Enum.KeyCode.S) then m=m-d end
            if UIS:IsKeyDown(Enum.KeyCode.A) then m=m-Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then m=m+Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then m=m+Vector3.new(0,1,0) end
            bv.Velocity=m.Magnitude>0 and m.Unit*60 or Vector3.zero
            task.wait()
        end
    end)
end)
สวิตช์("ทะลุสิ่งของ (Noclip)", false, function(เปิด)
    if เปิด then
        _G.nc = RunService.Stepped:Connect(function()
            local c=ตัวละคร(); if c then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
        end)
    else if _G.nc then _G.nc:Disconnect() end end
end)
สวิตช์("กระโดดไม่จำกัด", false, function(เปิด)
    if เปิด then _G.jb = UIS.JumpRequest:Connect(function() local h=ฮูแมน(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end)
    else if _G.jb then _G.jb:Disconnect() end end
end)
ปุ่ม("บันทึกตำแหน่งปัจจุบัน", function() if หลัก() then _G.จุด = หลัก().CFrame; แจ้ง("บันทึกแล้ว") end end)

-- ════════ [7-12] การต่อสู้/ระบบ ════════
หัวข้อ("═══ ⚔️ การต่อสู้ (7-12) ═══")
ปุ่ม("วาร์ปกลับจุดที่บันทึก", function() if _G.จุด then ตัวละคร():SetPrimaryPartCFrame(_G.จุด) end end)
สวิตช์("กัน AFK หลุด", false, function(เปิด)
    if เปิด then _G.afk = LP.Idled:Connect(function()
        pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(),Cam.CFrame) end)
        task.wait(1)
        pcall(function() game:GetService("VirtualUser"):Button2Up(Vector2.new(),Cam.CFrame) end)
    end) else if _G.afk then _G.afk:Disconnect() end end
end)
สวิตช์("ออกซิเจนไม่จำกัด", false, function(เปิด)
    task.spawn(function() while เปิด do local c=ตัวละคร(); if c then local b=c:FindFirstChild("Breath"); if b then b:SetAttribute("Oxygen",9999) end end; task.wait(.1) end end)
end)
ปุ่ม("เข้าห้องเดิมใหม่ (Rejoin)", function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end)
ปุ่ม("สุ่มเซิร์ฟเวอร์ (Hop)", function()
    local ok,res = pcall(function() return Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")) end)
    if ok then for _,s in pairs(res.data) do if s.playing<s.maxPlayers and s.id~=game.JobId then pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,s.id,LP) end); return end end
    แจ้ง("ไม่พบเซิร์ฟว่าง") end
end)
ปุ่ม("รีเซ็ตตัวละคร", function() ฮูแมน().Health = 0 end)

-- ════════ [13-20] การมองเห็น ════════
หัวข้อ("═══ 👁️ การมองเห็น (13-20) ═══")
สวิตช์("สว่างเต็มที่ (Fullbright)", false, function(เปิด)
    if เปิด then
        _G.fold = {a=Lighting.Ambient,o=Lighting.OutdoorAmbient,b=Lighting.Brightness,f=Lighting.FogEnd}
        Lighting.Ambient=Color3.new(1,1,1); Lighting.OutdoorAmbient=Color3.new(1,1,1); Lighting.Brightness=5; Lighting.FogEnd=1e5
    elseif _G.fold then
        Lighting.Ambient=_G.fold.a; Lighting.OutdoorAmbient=_G.fold.o; Lighting.Brightness=_G.fold.b; Lighting.FogEnd=_G.fold.f
    end
end)
สวิตช์("มองทะลุกำแพง (Highlight)", false, function(เปิด)
    if เปิด then
        _G.hl = {}
        for _,p in pairs(WS:GetDescendants()) do
            if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then
                local h=Instance.new("Highlight",p); h.FillTransparency=1; h.OutlineColor=Color3.fromRGB(0,255,255)
                _G.hl[p]=h
            end
        end
    else
        if _G.hl then for _,h in pairs(_G.hl) do if h then h:Destroy() end end; _G.hl={} end
    end
end)
สวิตช์("ล็อกกล้องไปที่ตัวละคร", false, function(เปิด)
    if เปิด then _G.lock = RunService.RenderStepped:Connect(function()
        if หลัก() then Cam.CFrame = CFrame.new(Cam.CFrame.Position, หลัก().Position) end
    end) else if _G.lock then _G.lock:Disconnect() end end
end)
สวิตช์("กล้องระยะไกล", false, function(เปิด) Cam.FieldOfView = เปิด and 100 or 70 end)
ปุ่ม("กล้องซูมสุด", function() Cam.FieldOfView = 30 end)
ปุ่ม("กล้องปกติ", function() Cam.FieldOfView = 70 end)
สวิตช์("ปิดหมอก(Fog)", false, function(เปิด) Lighting.FogEnd = เปิด and 1e5 or 1000 end)
สวิตช์("反差ภาพ (Bloom)", false, function(เปิด)
    if เปิด then local b=Instance.new("BloomEffect",Lighting); b.Intensity=.8; b.Name="HubBloom"; _G.bl=b
    else if _G.bl then _G.bl:Destroy() end end
end)

-- ════════ [21-27] ขนาด/รูปร่าง ════════
หัวข้อ("═══ 📐 ขนาดตัว (21-27) ═══")
ปุ่ม("ตัวเล็ก (0.3)", function() local c=ตัวละคร(); for _,v in pairs