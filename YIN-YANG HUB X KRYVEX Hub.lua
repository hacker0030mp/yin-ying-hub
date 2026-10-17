--[================================================================--
--    YIN-YANG HUB X KRYVEX Hub | Ultimate Combined Edition        --
--[================================================================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ลบ UI เก่าออกหากมีการรันซ้ำ
if PlayerGui:FindFirstChild("YinYangKryvexGui") then
	PlayerGui.YinYangKryvexGui:Destroy()
end

-- ลิงก์สคริปต์ KRYVEX Hub หลัก
local KRYVEX_HUB_URL = "https://raw.githubusercontent.com/komayma273-cyber/Script-Evade/refs/heads/main/KRYVEX%20Hub"

-- ตัวแปรระบบ Farm
local IsFarming = false
local FarmThread = nil
local FarmWindowFrame = nil

-- 1. สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YinYangKryvexGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 2. สร้างหน้าต่าง Loading (ธีม Yin-Yang ขาว-ดำ)
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 260, 0, 260)
LoadingFrame.Position = UDim2.new(0.5, -130, 0.5, -130)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.ClipsDescendants = true
LoadingFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = LoadingFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 2
UIStroke.Parent = LoadingFrame

-- ภาพพื้นหลัง & ไอคอน
local BgImage = Instance.new("ImageLabel")
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = "https://cdn.phototourl.com/member/2026-10-17-2545d7f4-4fbc-44a1-950e-07523e72296c.png"
BgImage.ImageTransparency = 0.7
BgImage.Parent = LoadingFrame

local IconImage = Instance.new("ImageLabel")
IconImage.Size = UDim2.new(0, 100, 0, 100)
IconImage.Position = UDim2.new(0.5, -50, 0.3, -50)
IconImage.BackgroundTransparency = 1
IconImage.Image = "https://cdn.phototourl.com/member/2026-10-16-c8fd00c7-3c45-446d-bf02-956f9ca17068.jpg"
IconImage.Parent = LoadingFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 0, 30)
TitleText.Position = UDim2.new(0, 0, 0.72, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "YIN-YANG HUB X KRYVEX Hub"
TitleText.Parent = LoadingFrame

-- ระบบหมุนไอคอนอัตโนมัติ
local isRotating = true
task.spawn(function()
	while isRotating and LoadingFrame.Parent do
		IconImage.Rotation = (IconImage.Rotation + 3) % 360
		task.wait(0.01)
	end
end)

-- 3. ฟังก์ชัน Pop-up แจ้งเตือน
local function CreateNotification(stepText, descText, callback)
	local NotifFrame = Instance.new("Frame")
	NotifFrame.Size = UDim2.new(0, 340, 0, 160)
	NotifFrame.Position = UDim2.new(0.5, -170, 0.5, -80)
	NotifFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	NotifFrame.BorderSizePixel = 0
	NotifFrame.ClipsDescendants = true
	NotifFrame.Parent = ScreenGui

	local NotifBg = Instance.new("ImageLabel")
	NotifBg.Size = UDim2.new(1, 0, 1, 0)
	NotifBg.BackgroundTransparency = 1
	NotifBg.Image = "https://cdn.phototourl.com/member/2026-10-17-2545d7f4-4fbc-44a1-950e-07523e72296c.png"
	NotifBg.ImageTransparency = 0.85
	NotifBg.Parent = NotifFrame

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
	HeaderLabel.Text = "YIN-YANG HUB X KRYVEX (" .. stepText .. ")"
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
	CancelBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	CancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CancelBtn.TextSize = 13
	CancelBtn.Font = Enum.Font.GothamBold
	CancelBtn.Text = "ไม่ยืนยัน"
	CancelBtn.Parent = NotifFrame

	local CancelStroke = Instance.new("UIStroke")
	CancelStroke.Color = Color3.fromRGB(255, 255, 255)
	CancelStroke.Thickness = 1
	CancelStroke.Parent = CancelBtn

	local CancelCorner = Instance.new("UICorner")
	CancelCorner.CornerRadius = UDim.new(0, 8)
	CancelCorner.Parent = CancelBtn

	-- ปุ่ม [ยืนยัน]
	local ConfirmBtn = Instance.new("TextButton")
	ConfirmBtn.Size = UDim2.new(0, 140, 0, 35)
	ConfirmBtn.Position = UDim2.new(1, -158, 1, -48)
	ConfirmBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
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

-- 4. ฟังก์ชันจัดการระบบ Farm (เข้าถึงลิงก์ KRYVEX Hub เมื่อกดคลิก พร้อมปุ่มกากบาท [✕] รีเซ็ต)
local function StopFarmSystem()
	IsFarming = false
	if FarmThread then
		task.cancel(FarmThread)
		FarmThread = nil
	end
	if FarmWindowFrame then
		FarmWindowFrame:Destroy()
		FarmWindowFrame = nil
	end
	print("[YIN-YANG System] ปิดระบบฟาร์ม และรีเซ็ตสถานะเรียบร้อย")
end

local function StartFarmSystem()
	StopFarmSystem()
	IsFarming = true

	FarmWindowFrame = Instance.new("Frame")
	FarmWindowFrame.Name = "FarmFunctionWindow"
	FarmWindowFrame.Size = UDim2.new(0, 220, 0, 110)
	FarmWindowFrame.Position = UDim2.new(0.5, -110, 0.4, -55)
	FarmWindowFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	FarmWindowFrame.BorderSizePixel = 0
	FarmWindowFrame.Parent = ScreenGui

	local WindowCorner = Instance.new("UICorner")
	WindowCorner.CornerRadius = UDim.new(0, 10)
	WindowCorner.Parent = FarmWindowFrame

	local WindowStroke = Instance.new("UIStroke")
	WindowStroke.Color = Color3.fromRGB(255, 255, 255)
	WindowStroke.Thickness = 1.5
	WindowStroke.Parent = FarmWindowFrame

	-- ปุ่มกากบาท [X] สี่เหลี่ยมสำหรับปิดและเริ่มใหม่
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 26, 0, 26)
	CloseBtn.Position = UDim2.new(1, -30, 0, 6)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.TextSize = 12
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.Text = "✕"
	CloseBtn.Parent = FarmWindowFrame

	local CloseStroke = Instance.new("UIStroke")
	CloseStroke.Color = Color3.fromRGB(255, 255, 255)
	CloseStroke.Thickness = 1
	CloseStroke.Parent = CloseBtn

	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 4)
	CloseCorner.Parent = CloseBtn

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -40, 0, 30)
	Title.Position = UDim2.new(0, 10, 0, 5)
	Title.BackgroundTransparency = 1
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 12
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Text = "⚙️ FUNCTION FARM"
	Title.Parent = FarmWindowFrame

	local StatusTxt = Instance.new("TextLabel")
	StatusTxt.Size = UDim2.new(1, -20, 0, 60)
	StatusTxt.Position = UDim2.new(0, 10, 0, 38)
	StatusTxt.BackgroundTransparency = 1
	StatusTxt.TextColor3 = Color3.fromRGB(200, 200, 200)
	StatusTxt.TextSize = 10
	StatusTxt.Font = Enum.Font.Gotham
	StatusTxt.TextWrapped = true
	StatusTxt.Text = "• Accessing KRYVEX Hub...\n• Status: Farming Active\n[กด ✕ เพื่อปิด/เริ่มฟาร์มใหม่]"
	StatusTxt.Parent = FarmWindowFrame

	CloseBtn.MouseButton1Click:Connect(function()
		StopFarmSystem()
	end)

	FarmThread = task.spawn(function()
		print("[Function Farm] กำลังเรียกใช้งานลิงก์ KRYVEX Hub...")
		local success, err = pcall(function()
			loadstring(game:HttpGet(KRYVEX_HUB_URL))()
		end)

		if not success then
			warn("[Function Farm Error]: " .. tostring(err))
			if StatusTxt then
				StatusTxt.Text = "❌ เกิดข้อผิดพลาดในการเข้าถึงลิงก์"
			end
		end
	end)
end

-- 5. Mini Status Bar (มีหมวดหมู่ Function Farm เมื่อกดคลิกจะเปิดหน้าต่างฟาร์ม)
local function CreateMiniStatusBar()
	local StatusBar = Instance.new("TextButton")
	StatusBar.Name = "MiniStatusBar"
	StatusBar.Size = UDim2.new(0, 240, 0, 36)
	StatusBar.Position = UDim2.new(0, 15, 0, 15)
	StatusBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	StatusBar.BorderSizePixel = 0
	StatusBar.AutoButtonColor = false
	StatusBar.Text = ""
	StatusBar.ClipsDescendants = true
	StatusBar.Parent = ScreenGui

	local BarStroke = Instance.new("UIStroke")
	BarStroke.Color = Color3.fromRGB(255, 255, 255)
	BarStroke.Thickness = 1.5
	BarStroke.Parent = StatusBar

	local BarCorner = Instance.new("UICorner")
	BarCorner.CornerRadius = UDim.new(1, 0)
	BarCorner.Parent = StatusBar

	local StatusLabel = Instance.new("TextLabel")
	StatusLabel.Size = UDim2.new(1, 0, 1, 0)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	StatusLabel.TextSize = 11
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.Text = "☯️ YIN-YANG x KRYVEX | FPS: --"
	StatusLabel.Parent = StatusBar

	-- คำนวณ FPS Real-time
	local frameCount = 0
	local lastTime = os.clock()
	RunService.RenderStepped:Connect(function()
		frameCount = frameCount + 1
		local currentTime = os.clock()
		if currentTime - lastTime >= 1 then
			local fps = math.floor(frameCount / (currentTime - lastTime))
			StatusLabel.Text = "☯️ YIN-YANG | FPS: " .. tostring(fps) .. " | " .. Player.Name
			frameCount = 0
			lastTime = currentTime
		end
	end)

	-- กล่องขยายเพิ่มเติม (ช่องที่ 2)
	local ExpandFrame = Instance.new("Frame")
	ExpandFrame.Size = UDim2.new(1, 0, 0, 130)
	ExpandFrame.Position = UDim2.new(0, 0, 1, 5)
	ExpandFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	ExpandFrame.BorderSizePixel = 0
	ExpandFrame.Visible = false
	ExpandFrame.Parent = StatusBar

	local ExpandCorner = Instance.new("UICorner")
	ExpandCorner.CornerRadius = UDim.new(0, 10)
	ExpandCorner.Parent = ExpandFrame

	local ExpandStroke = Instance.new("UIStroke")
	ExpandStroke.Color = Color3.fromRGB(255, 255, 255)
	ExpandStroke.Thickness = 1
	ExpandStroke.Parent = ExpandFrame

	-- ปุ่มคลิกในหมวดหมู่ "FUNCTION FARM"
	local FarmCategoryBtn = Instance.new("TextButton")
	FarmCategoryBtn.Size = UDim2.new(1, -16, 0, 32)
	FarmCategoryBtn.Position = UDim2.new(0, 8, 0, 8)
	FarmCategoryBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FarmCategoryBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	FarmCategoryBtn.TextSize = 11
	FarmCategoryBtn.Font = Enum.Font.GothamBold
	FarmCategoryBtn.Text = "▶ หมวดหมู่: FUNCTION FARM (คลิกเพื่อรัน)"
	FarmCategoryBtn.Parent = ExpandFrame

	local FarmCorner = Instance.new("UICorner")
	FarmCorner.CornerRadius = UDim.new(0, 6)
	FarmCorner.Parent = FarmCategoryBtn

	-- ปุ่ม คัดลอกชุมชน
	local FollowBtn = Instance.new("TextButton")
	FollowBtn.Size = UDim2.new(0.5, -10, 0, 28)
	FollowBtn.Position = UDim2.new(0, 8, 0, 48)
	FollowBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	FollowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	FollowBtn.TextSize = 10
	FollowBtn.Font = Enum.Font.GothamBold
	FollowBtn.Text = "คัดลอกชุมชน"
	FollowBtn.Parent = ExpandFrame

	local FollowStroke = Instance.new("UIStroke")
	FollowStroke.Color = Color3.fromRGB(255, 255, 255)
	FollowStroke.Thickness = 1
	FollowStroke.Parent = FollowBtn

	local FollowCorner = Instance.new("UICorner")
	FollowCorner.CornerRadius = UDim.new(0, 6)
	FollowCorner.Parent = FollowBtn

	-- ปุ่ม Rejoin
	local RejoinBtn = Instance.new("TextButton")
	RejoinBtn.Size = UDim2.new(0.5, -10, 0, 28)
	RejoinBtn.Position = UDim2.new(0.5, 2, 0, 48)
	RejoinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	RejoinBtn.TextSize = 10
	RejoinBtn.Font = Enum.Font.GothamBold
	RejoinBtn.Text = "Rejoin Server"
	RejoinBtn.Parent = ExpandFrame

	local RejoinStroke = Instance.new("UIStroke")
	RejoinStroke.Color = Color3.fromRGB(255, 255, 255)
	RejoinStroke.Thickness = 1
	RejoinStroke.Parent = RejoinBtn

	local RejoinCorner = Instance.new("UICorner")
	RejoinCorner.CornerRadius = UDim.new(0, 6)
	RejoinCorner.Parent = RejoinBtn

	-- เครดิต / IP
	local InfoText = Instance.new("TextLabel")
	InfoText.Size = UDim2.new(1, -10, 0, 40)
	InfoText.Position = UDim2.new(0, 5, 0, 82)
	InfoText.BackgroundTransparency = 1
	InfoText.TextColor3 = Color3.fromRGB(180, 180, 180)
	InfoText.TextSize = 9
	InfoText.Font = Enum.Font.Gotham
	InfoText.Text = "Server ID: " .. game.JobId:sub(1, 12) .. "...\nPowered by YIN-YANG X KRYVEX"
	InfoText.TextWrapped = true
	InfoText.Parent = ExpandFrame

	-- เปิด-ปิด กล่องย่อย
	local isOpen = false
	StatusBar.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		if isOpen then
			ExpandFrame.Visible = true
			StatusBar.Size = UDim2.new(0, 240, 0, 175)
		else
			ExpandFrame.Visible = false
			StatusBar.Size = UDim2.new(0, 240, 0, 36)
		end
	end)

	-- กดคลิกเพื่อรันระบบฟาร์ม
	FarmCategoryBtn.MouseButton1Click:Connect(function()
		StartFarmSystem()
	end)

	FollowBtn.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard("https://discord.gg/yin-yang-hub")
			FollowBtn.Text = "คัดลอกแล้ว!"
			task.wait(2)
			FollowBtn.Text = "คัดลอกชุมชน"
		end
	end)

	RejoinBtn.MouseButton1Click:Connect(function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
	end)
end

-- 6. ลำดับการทำงานหลัก (Main Flow)
task.spawn(function()
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

		-- รอ 3 วินาที
		task.wait(3)

		-- แจ้งเตือนรอบที่ 2
		CreateNotification("2/2", "ยืนยันการเชื่อมต่อสคริปต์เพื่อปลดล็อก KRYVEX Hub หรือไม่?", function(secondPassed)
			if not secondPassed then
				ScreenGui:Destroy()
				warn("[KRYVEX Hub] ผู้ใช้ยกเลิกการรันสคริปต์")
				return
			end

			-- โหลดสคริปต์หลัก KRYVEX Hub เบื้องต้น
			print("[YIN-YANG X KRYVEX] เชื่อมต่อ KRYVEX Hub สำเร็จ...")
			pcall(function()
				loadstring(game:HttpGet(KRYVEX_HUB_URL))()
			end)

			-- แสดง Mini Status Bar ทรงวงรีสีขาว-ดำ
			CreateMiniStatusBar()
		end)
	end)
end)
