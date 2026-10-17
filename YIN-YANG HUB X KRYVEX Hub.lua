--[================================================================--
--        YIN-YANG HUB X KRYVEX Hub + Mini Status Bar (Official)    --
--[================================================================--

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ลบ UI เก่าออกหากมีการรันซ้ำ
if PlayerGui:FindFirstChild("YinYangKryvexGui") then
	PlayerGui.YinYangKryvexGui:Destroy()
end

-- 1. สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YinYangKryvexGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 2. สร้างหน้าต่าง Loading (ธีม Yin-Yang)
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 240, 0, 240)
LoadingFrame.Position = UDim2.new(0.5, -120, 0.5, -120)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 2
UIStroke.Parent = LoadingFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = LoadingFrame

-- ไอคอนหยิน-หยาง
local IconImage = Instance.new("ImageLabel")
IconImage.Size = UDim2.new(0, 100, 0, 100)
IconImage.Position = UDim2.new(0.5, -50, 0.3, -50)
IconImage.BackgroundTransparency = 1
IconImage.Image = "https://cdn.phototourl.com/member/2026-10-16-c8fd00c7-3c45-446d-bf02-956f9ca17068.jpg"
IconImage.Parent = LoadingFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 0, 30)
TitleText.Position = UDim2.new(0, 0, 0.75, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "YIN-YANG HUB X KRYVEX Hub"
TitleText.Parent = LoadingFrame

-- ระบบหมุนไอคอนอัตโนมัติ (Automatic Rotation)
local isRotating = true
task.spawn(function()
	while isRotating and LoadingFrame.Parent do
		IconImage.Rotation = (IconImage.Rotation + 3) % 360
		task.wait(0.01)
	end
end)

-- 3. ฟังก์ชันสร้าง Pop-up แจ้งเตือน
local function CreateNotification(stepText, descText, callback)
	local NotifFrame = Instance.new("Frame")
	NotifFrame.Size = UDim2.new(0, 340, 0, 160)
	NotifFrame.Position = UDim2.new(0.5, -170, 0.5, -80)
	NotifFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	NotifFrame.BorderSizePixel = 0
	NotifFrame.Parent = ScreenGui

	local NotifStroke = Instance.new("UIStroke")
	NotifStroke.Color = Color3.fromRGB(255, 255, 255)
	NotifStroke.Thickness = 1.5
	NotifStroke.Parent = NotifFrame

	local NotifCorner = Instance.new("UICorner")
	NotifCorner.CornerRadius = UDim.new(0, 12)
	NotifCorner.Parent = NotifFrame

	local HeaderLabel = Instance.new("TextLabel")
	HeaderLabel.Size = UDim2.new(1, 0, 0, 25)
	HeaderLabel.Position = UDim2.new(0, 0, 0, 8)
	HeaderLabel.BackgroundTransparency = 1
	HeaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	HeaderLabel.TextSize = 13
	HeaderLabel.Font = Enum.Font.GothamBold
	HeaderLabel.Text = "YIN-YANG HUB X KRYVEX Hub (" .. stepText .. ")"
	HeaderLabel.Parent = NotifFrame

	local DescLabel = Instance.new("TextLabel")
	DescLabel.Size = UDim2.new(1, -20, 0, 45)
	DescLabel.Position = UDim2.new(0, 10, 0, 38)
	DescLabel.BackgroundTransparency = 1
	DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	DescLabel.TextSize = 12
	DescLabel.Font = Enum.Font.Gotham
	DescLabel.Text = descText
	DescLabel.TextWrapped = true
	DescLabel.Parent = NotifFrame

	-- ปุ่ม [ไม่ยืนยัน]
	local CancelBtn = Instance.new("TextButton")
	CancelBtn.Size = UDim2.new(0, 140, 0, 35)
	CancelBtn.Position = UDim2.new(0, 18, 1, -48)
	CancelBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
	CancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CancelBtn.TextSize = 13
	CancelBtn.Font = Enum.Font.GothamBold
	CancelBtn.Text = "ไม่ยืนยัน"
	CancelBtn.Parent = NotifFrame

	local CancelCorner = Instance.new("UICorner")
	CancelCorner.CornerRadius = UDim.new(0, 8)
	CancelCorner.Parent = CancelBtn

	-- ปุ่ม [ยืนยัน]
	local ConfirmBtn = Instance.new("TextButton")
	ConfirmBtn.Size = UDim2.new(0, 140, 0, 35)
	ConfirmBtn.Position = UDim2.new(1, -158, 1, -48)
	ConfirmBtn.BackgroundColor3 = Color3.fromRGB(30, 150, 60)
	ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	ConfirmBtn.TextSize = 13
	ConfirmBtn.Font = Enum.Font.GothamBold
	ConfirmBtn.Text = "ยืนยัน"
	ConfirmBtn.Parent = NotifFrame

	local ConfirmCorner = Instance.new("UICorner")
	ConfirmCorner.CornerRadius = UDim.new(0, 8)
	ConfirmCorner.Parent = ConfirmBtn

	CancelBtn.MouseButton1Click:Connect(function()
		NotifFrame:Destroy()
		callback(false)
	end)

	ConfirmBtn.MouseButton1Click:Connect(function()
		NotifFrame:Destroy()
		callback(true)
	end)
end

-- 4. ฟังก์ชันสร้าง Mini Status Bar สีเหลือง ทรงวงรี (หลังกดยืนยันผ่าน)
local function CreateMiniStatusBar()
	local StatusBar = Instance.new("TextButton")
	StatusBar.Name = "MiniStatusBar"
	StatusBar.Size = UDim2.new(0, 220, 0, 35)
	StatusBar.Position = UDim2.new(0, 15, 0, 15) -- ติดไว้มุมซ้ายบน
	StatusBar.BackgroundColor3 = Color3.fromRGB(240, 200, 50) -- สีเหลือง
	StatusBar.BorderSizePixel = 0
	StatusBar.AutoButtonColor = false
	StatusBar.Text = ""
	StatusBar.Parent = ScreenGui

	local BarCorner = Instance.new("UICorner")
	BarCorner.CornerRadius = UDim.new(1, 0) -- ทรงวงรี
	BarCorner.Parent = StatusBar

	local StatusLabel = Instance.new("TextLabel")
	StatusLabel.Size = UDim2.new(1, 0, 1, 0)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
	StatusLabel.TextSize = 12
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.Text = "⚡ YIN-YANG x KRYVEX | User: " .. Player.Name
	StatusLabel.Parent = StatusBar

	-- กล่องขยายเพิ่มเติม (ช่องที่ 2)
	local ExpandFrame = Instance.new("Frame")
	ExpandFrame.Size = UDim2.new(1, 0, 0, 90)
	ExpandFrame.Position = UDim2.new(0, 0, 1, 5)
	ExpandFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	ExpandFrame.BorderSizePixel = 0
	ExpandFrame.Visible = false
	ExpandFrame.Parent = StatusBar

	local ExpandCorner = Instance.new("UICorner")
	ExpandCorner.CornerRadius = UDim.new(0, 8)
	ExpandCorner.Parent = ExpandFrame

	local ExpandStroke = Instance.new("UIStroke")
	ExpandStroke.Color = Color3.fromRGB(240, 200, 50)
	ExpandStroke.Thickness = 1
	ExpandStroke.Parent = ExpandFrame

	local InfoText = Instance.new("TextLabel")
	InfoText.Size = UDim2.new(1, -10, 0, 40)
	InfoText.Position = UDim2.new(0, 5, 0, 5)
	InfoText.BackgroundTransparency = 1
	InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
	InfoText.TextSize = 11
	InfoText.Font = Enum.Font.Gotham
	InfoText.Text = "IP Server: " .. game.JobId:sub(1, 12) .. "... \nStatus: Connected & Protected"
	InfoText.TextWrapped = true
	InfoText.Parent = ExpandFrame

	local FollowBtn = Instance.new("TextButton")
	FollowBtn.Size = UDim2.new(1, -16, 0, 30)
	FollowBtn.Position = UDim2.new(0, 8, 1, -35)
	FollowBtn.BackgroundColor3 = Color3.fromRGB(240, 200, 50)
	FollowBtn.TextColor3 = Color3.fromRGB(30, 30, 30)
	FollowBtn.TextSize = 11
	FollowBtn.Font = Enum.Font.GothamBold
	FollowBtn.Text = "กดติดตาม / ร่วมกลุ่มชุมชน"
	FollowBtn.Parent = ExpandFrame

	local FollowCorner = Instance.new("UICorner")
	FollowCorner.CornerRadius = UDim.new(0, 6)
	FollowCorner.Parent = FollowBtn

	-- ระบบเปิด-ปิด ช่องที่ 2 เมื่อคลิก
	local isOpen = false
	StatusBar.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		if isOpen then
			ExpandFrame.Visible = true
			StatusBar.Size = UDim2.new(0, 220, 0, 130)
		else
			ExpandFrame.Visible = false
			StatusBar.Size = UDim2.new(0, 220, 0, 35)
		end
	end)
end

-- 5. ลำดับการทำงาน (Main Execution Flow)
task.spawn(function()
	-- รอ 5 วินาทีในหน้า Loading
	task.wait(5)
	isRotating = false
	LoadingFrame:Destroy()

	-- แจ้งเตือนรอบที่ 1
	CreateNotification("1/2", "ยืนยันสิทธิ์การเข้าใช้งานระบบ YIN-YANG HUB หรือไม่?", function(firstPassed)
		if not firstPassed then
			ScreenGui:Destroy()
			warn("[YIN-YANG HUB] ผู้ใช้ยกเลิกการรันสคริปต์")
			return
		end

		-- รอ 3 วินาที (ไม่ให้ซ้อนกัน)
		task.wait(3)

		-- แจ้งเตือนรอบที่ 2
		CreateNotification("2/2", "ยืนยันการเชื่อมต่อสคริปต์เพื่อปลดล็อก KRYVEX Hub หรือไม่?", function(secondPassed)
			if not secondPassed then
				ScreenGui:Destroy()
				warn("[KRYVEX Hub] ผู้ใช้ยกเลิกการรันสคริปต์")
				return
			end

			-- เมื่อยืนยันครบ 2 รอบ -> รัน KRYVEX Hub หลัก
			print("[YIN-YANG X KRYVEX] กำลังโหลดสคริปต์หลัก...")
			local success, err = pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/komayma273-cyber/Script-Evade/refs/heads/main/KRYVEX%20Hub"))()
			end)

			if not success then
				warn("เกิดข้อผิดพลาดในการรันสคริปต์ KRYVEX Hub: " .. tostring(err))
			end

			-- แสดง Mini Status Bar ทรงวงรีสีเหลืองมุมจอ
			CreateMiniStatusBar()
		end)
	end)
end)
