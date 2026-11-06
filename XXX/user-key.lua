-- สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaraokeCopperGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- กำหนดคีย์เดียวที่ถูกต้อง และลิงก์ปลายทาง
local CORRECT_KEY = "COPPER12"
local TARGET_LINK = "https://discord.gg/hkS9VUCQRQ"

-- 1. หน้าต่างยืนยันตัวตน (Authentication Frame)
local AuthFrame = Instance.new("Frame")
AuthFrame.Size = UDim2.new(0, 350, 0, 220)
AuthFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
AuthFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AuthFrame.BorderSizePixel = 0
AuthFrame.Parent = ScreenGui

local AuthCorner = Instance.new("UICorner")
AuthCorner.CornerRadius = UDim.new(0, 10)
AuthCorner.Parent = AuthFrame

local AuthTitle = Instance.new("TextLabel")
AuthTitle.Size = UDim2.new(1, 0, 0, 40)
AuthTitle.Text = "ยืนยันคีย์ (COPPER12)"
AuthTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthTitle.TextSize = 16
AuthTitle.Font = Enum.Font.SourceSansBold
AuthTitle.BackgroundTransparency = 1
AuthTitle.Parent = AuthFrame

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Size = UDim2.new(1, 0, 0, 30)
TimerLabel.Position = UDim2.new(0, 0, 0, 40)
TimerLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
TimerLabel.TextSize = 14
TimerLabel.Font = Enum.Font.SourceSans
TimerLabel.BackgroundTransparency = 1
TimerLabel.Parent = AuthFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0, 80)
KeyInput.PlaceholderText = "กรอกคีย์ COPPER12..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KeyInput.TextSize = 14
KeyInput.Parent = AuthFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 6)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.1, 0, 0, 135)
SubmitBtn.Text = "ยืนยันคีย์"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitBtn.TextSize = 15
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Parent = AuthFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 6)
SubmitCorner.Parent = SubmitBtn

-- 2. หน้าต่างหลัก (Main Menu Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 320)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, 0, 0, 40)
MainTitle.Text = "เลือกรันรูปแบบสคริปต์คาราโอเกะ"
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextSize = 18
MainTitle.Font = Enum.Font.SourceSansBold
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = MainFrame

-- ปุ่มตัวเลือกสคริปต์ (หลัก 1, สำรอง 1, สำรอง 2, สำรอง 3)
local scriptsData = {
	{name = "หลัก 1", code = "print('รันสคริปต์ หลัก 1 สำเร็จ')"},
	{name = "สำรอง 1", code = "print('รันสคริปต์ สำรอง 1 สำเร็จ')"},
	{name = "สำรอง 2", code = "print('รันสคริปต์ สำรอง 2 สำเร็จ')"},
	{name = "สำรอง 3", code = "print('รันสคริปต์ สำรอง 3 สำเร็จ')"}
}

for i, data in ipairs(scriptsData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.8, 0, 0, 35)
	btn.Position = UDim2.new(0.1, 0, 0, 40 + (i * 42))
	btn.Text = "รัน: " .. data.name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextSize = 14
	btn.Font = Enum.Font.SourceSansBold
	btn.Parent = MainFrame
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		local success, err = pcall(function()
			loadstring(data.code)()
		end)
		if success then
			btn.Text = "รัน " .. data.name .. " สำเร็จ!"
			task.wait(1.5)
			btn.Text = "รัน: " .. data.name
		else
			warn("Error: " .. tostring(err))
		end
	end)
end

-- ช่องใส่ลิงก์ที่ดึงมาอัตโนมัติ
local LinkBox = Instance.new("TextBox")
LinkBox.Size = UDim2.new(0.55, 0, 0, 35)
LinkBox.Position = UDim2.new(0.1, 0, 0, 230)
LinkBox.Text = TARGET_LINK
LinkBox.TextColor3 = Color3.fromRGB(255, 255, 255)
LinkBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LinkBox.TextSize = 13
LinkBox.ClearTextOnFocus = false
LinkBox.Parent = MainFrame

local LinkCorner = Instance.new("UICorner")
LinkCorner.CornerRadius = UDim.new(0, 6)
LinkCorner.Parent = LinkBox

local RunLinkBtn = Instance.new("TextButton")
RunLinkBtn.Size = UDim2.new(0.22, 0, 0, 35)
RunLinkBtn.Position = UDim2.new(0.68, 0, 0, 230)
RunLinkBtn.Text = "รันจากลิงก์"
RunLinkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunLinkBtn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
RunLinkBtn.TextSize = 13
RunLinkBtn.Font = Enum.Font.SourceSansBold
RunLinkBtn.Parent = MainFrame

local RunLinkCorner = Instance.new("UICorner")
RunLinkCorner.CornerRadius = UDim.new(0, 6)
RunLinkCorner.Parent = RunLinkBtn

-- ปุ่มกดรันสคริปต์จากลิงก์
RunLinkBtn.MouseButton1Click:Connect(function()
	local url = LinkBox.Text
	if url ~= "" then
		local success, err = pcall(function()
			loadstring(game:HttpGet(url))()
		end)
		if success then
			RunLinkBtn.Text = "รันสำเร็จ!"
			task.wait(1.5)
			RunLinkBtn.Text = "รันจากลิงก์"
		else
			RunLinkBtn.Text = "ผิดพลาด"
			task.wait(1.5)
			RunLinkBtn.Text = "รันจากลิงก์"
		end
	end
end)

-- 3. ปุ่มวงกลมย่อ-ขยายหน้าต่าง (Minimize Circle Button)
local ToggleCircle = Instance.new("TextButton")
ToggleCircle.Size = UDim2.new(0, 45, 0, 45)
ToggleCircle.Position = UDim2.new(0, 20, 0.5, -22)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ToggleCircle.Text = "UI"
ToggleCircle.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleCircle.TextSize = 14
ToggleCircle.Font = Enum.Font.SourceSansBold
ToggleCircle.Visible = false
ToggleCircle.Parent = ScreenGui

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = ToggleCircle

-- ฟังก์ชันตรวจสอบคีย์
SubmitBtn.MouseButton1Click:Connect(function()
	if KeyInput.Text == CORRECT_KEY then
		AuthFrame.Visible = false
		MainFrame.Visible = true
		ToggleCircle.Visible = true
	else
		TimerLabel.Text = "คีย์ไม่ถูกต้อง! (ต้องเป็น COPPER12)"
		TimerLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
	end
end)

-- ระบบนับถอยหลัง 10 วินาที
task.spawn(function()
	for i = 10, 1, -1 do
		if AuthFrame.Visible == false then break end
		TimerLabel.Text = "โปรดกรอกคีย์ภายใน: " .. i .. " วินาที"
		task.wait(1)
	end
	if AuthFrame.Visible == true then
		AuthFrame.Visible = false
		MainFrame.Visible = true
		ToggleCircle.Visible = true
	end
end)

-- ฟังก์ชันกดปุ่มวงกลมเพื่อย่อ/ขยายหน้าต่าง
local isMinimized = false
ToggleCircle.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	MainFrame.Visible = not isMinimized
end)
