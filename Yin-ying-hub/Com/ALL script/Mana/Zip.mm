-- =========================================================================
-- ☯️ YIN-YANG HUB | SIMPLE KEY SYSTEM & SCRIPT SELECTOR ☯️
-- ระบบ Key คีย์เดิม: YINYANG2026 (กดคัดลอกแล้ววางให้อัตโนมัติ)
-- =========================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local parentGui = (gethui and gethui()) or (syn and syn.protect_gui and CoreGui) or LocalPlayer:WaitForChild("PlayerGui")

-- ลบ UI เก่าทิ้งหากรันซ้ำ
pcall(function()
    if parentGui:FindFirstChild("YinYangKeySystemGui") then
        parentGui.YinYangKeySystemGui:Destroy()
    end
end)

-- 🔑 คีย์เดิมสำหรับเข้าใช้งาน
local CORRECT_KEY = "YINYANG2026"
local MAIN_SCRIPT_URL_1 = "https://raw.githubusercontent.com/hacker0030mp/yin-ying-hub/refs/heads/main/Yin-ying-hub/Com/ALL%20script/Mana/com.lua"
local MAIN_SCRIPT_URL_2 = "https://raw.githubusercontent.com/hacker0030mp/yin-ying-hub/refs/heads/main/Yin-ying-hub/Com/ALL%20script/Mana/Ran-script-outside-the-system"
local MAIN_SCRIPT_URL_3 = "https://raw.githubusercontent.com/hacker0030mp/yin-ying-hub/refs/heads/main/Yin-ying-hub/Com/XMP-all-script%20x%20hub"
    
-- สร้าง ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YinYangKeySystemGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- หน้าต่าง Key System
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.fromOffset(360, 220)
KeyFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(16, 185, 129)
Stroke.Thickness = 1.8
Stroke.Parent = KeyFrame

-- หัวข้อ
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "☯️ YIN-YANG HUB | KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(52, 211, 153)
Title.TextSize = 14
Title.Parent = KeyFrame

-- ช่องกรอก Key
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 40)
KeyInput.Position = UDim2.new(0, 20, 0, 50)
KeyInput.BackgroundColor3 = Color3.fromRGB(8, 14, 12)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "กดปุ่มคัดลอกด้านล่างเพื่อวาง Key..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(236, 253, 245)
KeyInput.TextSize = 12
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyFrame
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", KeyInput).Color = Color3.fromRGB(30, 70, 55)

-- ปุ่ม Copy Key (คัดลอกคีย์เดิมและวางลงช่องให้อัตโนมัติ)
local CopyKeyBtn = Instance.new("TextButton")
CopyKeyBtn.Size = UDim2.new(0.46, -5, 0, 38)
CopyKeyBtn.Position = UDim2.new(0, 20, 0, 100)
CopyKeyBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 40)
CopyKeyBtn.Font = Enum.Font.GothamBold
CopyKeyBtn.Text = "📋 คัดลอก & วาง Key"
CopyKeyBtn.TextColor3 = Color3.fromRGB(110, 231, 183)
CopyKeyBtn.TextSize = 12
CopyKeyBtn.Parent = KeyFrame
Instance.new("UICorner", CopyKeyBtn).CornerRadius = UDim.new(0, 8)

-- ปุ่ม ยืนยัน Key
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.46, -5, 0, 38)
SubmitBtn.Position = UDim2.new(0.54, -15, 0, 100)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Text = "✓ ยืนยัน Key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 12
SubmitBtn.Parent = KeyFrame
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)

-- ข้อความแจ้งเตือนสถานะ
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 30)
StatusLabel.Position = UDim2.new(0, 20, 0, 150)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "กดปุ่มคัดลอกเพื่อวาง Key อัตโนมัติ"
StatusLabel.TextColor3 = Color3.fromRGB(150, 180, 170)
StatusLabel.TextSize = 11
StatusLabel.Parent = KeyFrame

-- =========================================================================
-- ⏳ หน้าต่าง LOADING FRAME (10 วินาที)
-- =========================================================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.fromOffset(360, 160)
LoadingFrame.Position = UDim2.new(0.5, -180, 0.5, -80)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 20)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Visible = false
LoadingFrame.Parent = ScreenGui
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 12)

local LoadStroke = Instance.new("UIStroke")
LoadStroke.Color = Color3.fromRGB(16, 185, 129)
LoadStroke.Thickness = 1.8
LoadStroke.Parent = LoadingFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 40)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "☯️ กำลังเตรียมความพร้อม... (10 วินาที)"
LoadTitle.TextColor3 = Color3.fromRGB(52, 211, 153)
LoadTitle.TextSize = 14
LoadTitle.Parent = LoadingFrame

-- แถบ Loading Bar
local ProgressBarBg = Instance.new("Frame")
ProgressBarBg.Size = UDim2.new(1, -40, 0, 14)
ProgressBarBg.Position = UDim2.new(0, 20, 0, 60)
ProgressBarBg.BackgroundColor3 = Color3.fromRGB(8, 14, 12)
ProgressBarBg.Parent = LoadingFrame
Instance.new("UICorner", ProgressBarBg).CornerRadius = UDim.new(1, 0)

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
ProgressBarFill.Parent = ProgressBarBg
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(1, 0)

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 0, 30)
PercentText.Position = UDim2.new(0, 0, 0, 95)
PercentText.BackgroundTransparency = 1
PercentText.Font = Enum.Font.GothamBold
PercentText.Text = "กำลังโหลดระบบ... 0%"
PercentText.TextColor3 = Color3.fromRGB(236, 253, 245)
PercentText.TextSize = 12
PercentText.Parent = LoadingFrame

-- =========================================================================
-- 🖥️ หน้าต่างเลือกสคริปต์หลัก (SCRIPT SELECTOR MENU) หลังโหลดครบ 10 วิ
-- =========================================================================
local SelectFrame = Instance.new("Frame")
SelectFrame.Name = "SelectFrame"
SelectFrame.Size = UDim2.fromOffset(360, 280)
SelectFrame.Position = UDim2.new(0.5, -180, 0.5, -140)
SelectFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 20)
SelectFrame.BorderSizePixel = 0
SelectFrame.Visible = false
SelectFrame.Parent = ScreenGui
Instance.new("UICorner", SelectFrame).CornerRadius = UDim.new(0, 12)

local SelectStroke = Instance.new("UIStroke")
SelectStroke.Color = Color3.fromRGB(16, 185, 129)
SelectStroke.Thickness = 1.8
SelectStroke.Parent = SelectFrame

local SelectTitle = Instance.new("TextLabel")
SelectTitle.Size = UDim2.new(1, 0, 0, 40)
SelectTitle.BackgroundTransparency = 1
SelectTitle.Font = Enum.Font.GothamBold
SelectTitle.Text = "☯️ เลือกสคริปต์หลักที่ต้องการใช้งาน"
SelectTitle.TextColor3 = Color3.fromRGB(52, 211, 153)
SelectTitle.TextSize = 14
SelectTitle.Parent = SelectFrame

-- ปุ่มกดรันสคริปต์ที่ 1 (Main Script 1)
local RunBtn1 = Instance.new("TextButton")
RunBtn1.Size = UDim2.new(1, -40, 0, 45)
RunBtn1.Position = UDim2.new(0, 20, 0, 55)
RunBtn1.BackgroundColor3 = Color3.fromRGB(20, 50, 40)
RunBtn1.Font = Enum.Font.GothamBold
RunBtn1.Text = "🚀 รันสคริปต์หลัก 1 (Com.lua)"
RunBtn1.TextColor3 = Color3.fromRGB(110, 231, 183)
RunBtn1.TextSize = 12
RunBtn1.Parent = SelectFrame
Instance.new("UICorner", RunBtn1).CornerRadius = UDim.new(0, 8)

-- ปุ่มกดรันสคริปต์ที่ 2 (Main Script 2)
local RunBtn2 = Instance.new("TextButton")
RunBtn2.Size = UDim2.new(1, -40, 0, 45)
RunBtn2.Position = UDim2.new(0, 20, 0, 110)
RunBtn2.BackgroundColor3 = Color3.fromRGB(20, 50, 40)
RunBtn2.Font = Enum.Font.GothamBold
RunBtn2.Text = "🚀 รันสคริปต์นอกระบบ (Outside System)"
RunBtn2.TextColor3 = Color3.fromRGB(110, 231, 183)
RunBtn2.TextSize = 12
RunBtn2.Parent = SelectFrame
Instance.new("UICorner", RunBtn2).CornerRadius = UDim.new(0, 8)

-- ปุ่มกดรันสคริปต์ที่ 3 (Main Script 3)
local RunBtn3 = Instance.new("TextButton")
RunBtn3.Size = UDim2.new(1, -40, 0, 45)
RunBtn3.Position = UDim2.new(0, 20, 0, 165)
RunBtn3.BackgroundColor3 = Color3.fromRGB(20, 50, 40)
RunBtn3.Font = Enum.Font.GothamBold
RunBtn3.Text = "🚀 รัน XMP All Script Hub"
RunBtn3.TextColor3 = Color3.fromRGB(110, 231, 183)
RunBtn3.TextSize = 12
RunBtn3.Parent = SelectFrame
Instance.new("UICorner", RunBtn3).CornerRadius = UDim.new(0, 8)

-- ปิดหน้าต่างทั้งหมด
local CloseHubBtn = Instance.new("TextButton")
CloseHubBtn.Size = UDim2.new(1, -40, 0, 35)
CloseHubBtn.Position = UDim2.new(0, 20, 0, 225)
CloseHubBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
CloseHubBtn.Font = Enum.Font.GothamBold
CloseHubBtn.Text = "❌ ปิดหน้าต่างนี้"
CloseHubBtn.TextColor3 = Color3.fromRGB(239, 68, 68)
CloseHubBtn.TextSize = 11
CloseHubBtn.Parent = SelectFrame
Instance.new("UICorner", CloseHubBtn).CornerRadius = UDim.new(0, 8)

-- =========================================================================
-- ⚡ ฟังก์ชันการทำงาน
-- =========================================================================

-- กดคัดลอก Key เดิม และ วางลงช่องให้อัตโนมัติทันที
CopyKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(CORRECT_KEY)
    end
    
    KeyInput.Text = CORRECT_KEY
    
    StatusLabel.Text = "📋 คัดลอกและวาง Key สำเร็จแล้ว!"
    StatusLabel.TextColor3 = Color3.fromRGB(52, 211, 153)
end)

-- กดตกลงยืนยัน Key
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        KeyFrame.Visible = false
        LoadingFrame.Visible = true

        task.spawn(function()
            local duration = 10
            for i = 1, duration do
                local percent = math.floor((i / duration) * 100)
                PercentText.Text = "กำลังโหลดระบบ... " .. percent .. "% (" .. i .. "/10s)"
                
                TweenService:Create(ProgressBarFill, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Size = UDim2.new(i / duration, 0, 1, 0)
                }):Play()

                task.wait(1)
            end

            -- ซ่อนหน้าโหลด แล้วแสดงเมนูเลือกสคริปต์
            LoadingFrame.Visible = false
            SelectFrame.Visible = true
        end)
    else
        StatusLabel.Text = "❌ Key ไม่ถูกต้อง! กรุณาลองใหม่อีกครั้ง"
        StatusLabel.TextColor3 = Color3.fromRGB(239, 68, 68)
    end
end)

-- ปุ่มรันสคริปต์ที่ 1
RunBtn1.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    local success, err = pcall(function()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL_1))()
    end)
    if not success then
        warn("เกิดข้อผิดพลาดในการโหลดสคริปต์ 1: " .. tostring(err))
    end
end)

-- ปุ่มรันสคริปต์ที่ 2
RunBtn2.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    local success, err = pcall(function()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL_2))()
    end)
    if not success then
        warn("เกิดข้อผิดพลาดในการโหลดสคริปต์ 2: " .. tostring(err))
    end
end)

-- ปุ่มรันสคริปต์ที่ 3
RunBtn3.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    local success, err = pcall(function()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL_3))()
    end)
    if not success then
        warn("เกิดข้อผิดพลาดในการโหลดสคริปต์ 3: " .. tostring(err))
    end
end)

-- ปุ่มปิดหน้าต่าง
CloseHubBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
    
