--[[(
☯ YIN YANG UI — Standalone UI Framework (Prototype)
Version: 0.1.0
UI-only preview: no gameplay features, remotes, executor injection, or external libraries.
Install in Roblox Studio as a LocalScript under StarterPlayer > StarterPlayerScripts.
]]
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local GUI_NAME = "YinYangUI_Prototype"
local old = playerGui:FindFirstChild(GUI_NAME)
if old then old:Destroy() end

local C = {
  bg=Color3.fromRGB(10,13,17), panel=Color3.fromRGB(17,22,27), panel2=Color3.fromRGB(23,30,36),
  hover=Color3.fromRGB(31,42,46), emerald=Color3.fromRGB(38,220,151), dark=Color3.fromRGB(20,133,96),
  mint=Color3.fromRGB(160,255,216), text=Color3.fromRGB(242,247,245), muted=Color3.fromRGB(142,158,153),
  border=Color3.fromRGB(45,66,61), white=Color3.fromRGB(255,255,255)
}
local function make(class, props, parent)
  local o=Instance.new(class); for k,v in pairs(props or {}) do o[k]=v end; o.Parent=parent; return o
end
local function round(p,r) make("UICorner",{CornerRadius=UDim.new(0,r or 10)},p) end
local function outline(p,col,tr,th) make("UIStroke",{Color=col or C.border,Transparency=tr or 0,Thickness=th or 1},p) end
local function pad(p,l,r,t,b) make("UIPadding",{PaddingLeft=UDim.new(0,l or 0),PaddingRight=UDim.new(0,r or 0),PaddingTop=UDim.new(0,t or 0),PaddingBottom=UDim.new(0,b or 0)},p) end
local function label(parent,txt,size,color,font,align)
 return make("TextLabel",{BackgroundTransparency=1,Text=txt or "",Font=font or Enum.Font.Gotham,TextSize=size or 14,TextColor3=color or C.text,TextXAlignment=align or Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,Size=UDim2.new(1,0,0,22)},parent)
end
local function tw(o,d,p) local t=TweenService:Create(o,TweenInfo.new(d or .18,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p);t:Play();return t end
local screen=make("ScreenGui",{Name=GUI_NAME,ResetOnSpawn=false,IgnoreGuiInset=true,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=30},playerGui)

-- Floating yin-yang launcher
local launcher=make("TextButton",{Name="YinYangLauncher",Text="☯",Font=Enum.Font.GothamBlack,TextSize=36,TextColor3=C.mint,BackgroundColor3=C.panel,AutoButtonColor=false,Size=UDim2.fromOffset(58,58),Position=UDim2.new(0,18,.42,0),ZIndex=20},screen)
round(launcher,30); outline(launcher,C.emerald,.1,2)
make("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.panel2),ColorSequenceKeypoint.new(1,Color3.fromRGB(8,42,32))}),Rotation=45},launcher)
local launcherScale=make("UIScale",{Scale=1},launcher)
launcher.MouseEnter:Connect(function() tw(launcherScale,.15,{Scale=1.06}) end)
launcher.MouseLeave:Connect(function() tw(launcherScale,.15,{Scale=1}) end)
do
 local dragging,dragInput,dragStart,startPos
 launcher.InputBegan:Connect(function(input)
  if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
   dragging=true;dragStart=input.Position;startPos=launcher.Position
   input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
  end
 end)
 launcher.InputChanged:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then dragInput=input end end)
 UserInputService.InputChanged:Connect(function(input)
  if dragging and (input==dragInput or input.UserInputType==Enum.UserInputType.Touch) then local d=input.Position-dragStart;launcher.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end
 end)
end

local main=make("Frame",{Name="MainWindow",BackgroundColor3=C.bg,BorderSizePixel=0,Size=UDim2.fromOffset(720,470),Position=UDim2.new(.5,-360,.5,-235),ClipsDescendants=true},screen)
round(main,16);outline(main,C.border,.15,1.2)
make("UISizeConstraint",{MinSize=Vector2.new(310,390),MaxSize=Vector2.new(900,650)},main)
local mainScale=make("UIScale",{Scale=1},main)
local top=make("Frame",{Name="TopBar",BackgroundColor3=C.panel,BorderSizePixel=0,Size=UDim2.new(1,0,0,64)},main);round(top,16)
make("Frame",{BackgroundColor3=C.panel,BorderSizePixel=0,Position=UDim2.new(0,0,1,-16),Size=UDim2.new(1,0,0,16)},top)
local logo=make("Frame",{BackgroundColor3=Color3.fromRGB(9,40,31),Size=UDim2.fromOffset(42,42),Position=UDim2.fromOffset(14,11)},top);round(logo,13);outline(logo,C.dark,0,1)
local logoText=label(logo,"☯",29,C.mint,Enum.Font.GothamBlack,Enum.TextXAlignment.Center);logoText.Size=UDim2.fromScale(1,1)
local brand=label(top,"YIN YANG UI",18,C.text,Enum.Font.GothamBold);brand.Position=UDim2.fromOffset(66,10);brand.Size=UDim2.new(0,200,0,25)
local subtitle=label(top,"STANDALONE INTERFACE  •  PROTOTYPE",9,C.emerald,Enum.Font.GothamMedium);subtitle.Position=UDim2.fromOffset(67,34);subtitle.Size=UDim2.new(0,260,0,15)
local pill=make("Frame",{BackgroundColor3=Color3.fromRGB(12,53,40),Size=UDim2.fromOffset(91,26),Position=UDim2.new(1,-145,0,19)},top);round(pill,13)
local dot=make("Frame",{BackgroundColor3=C.emerald,Size=UDim2.fromOffset(7,7),Position=UDim2.fromOffset(10,9)},pill);round(dot,5)
local status=label(pill,"UI READY",10,C.mint,Enum.Font.GothamBold);status.Position=UDim2.fromOffset(23,2);status.Size=UDim2.new(1,-27,1,-4)
local minimize=make("TextButton",{Text="—",Font=Enum.Font.GothamBold,TextSize=18,TextColor3=C.muted,BackgroundColor3=C.panel2,AutoButtonColor=false,Size=UDim2.fromOffset(30,30),Position=UDim2.new(1,-44,0,17)},top);round(minimize,9)

local sidebar=make("Frame",{Name="Sidebar",BackgroundColor3=C.panel,BorderSizePixel=0,Position=UDim2.fromOffset(12,76),Size=UDim2.new(0,174,1,-88)},main);round(sidebar,12);pad(sidebar,9,9,12,10)
local navHeader=label(sidebar,"NAVIGATION",10,C.muted,Enum.Font.GothamBold);navHeader.Size=UDim2.new(1,0,0,20);navHeader.Position=UDim2.fromOffset(3,0)
local navList=make("Frame",{BackgroundTransparency=1,Position=UDim2.fromOffset(0,28),Size=UDim2.new(1,0,1,-88)},sidebar)
make("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder},navList)
local profile=make("Frame",{Name="ProfileCard",BackgroundColor3=C.panel2,Size=UDim2.new(1,0,0,54),Position=UDim2.new(0,0,1,-54)},sidebar);round(profile,10)
local avatar=make("Frame",{BackgroundColor3=Color3.fromRGB(29,89,67),Size=UDim2.fromOffset(34,34),Position=UDim2.fromOffset(8,10)},profile);round(avatar,17)
local avatarText=label(avatar,string.sub(player.DisplayName or player.Name,1,1):upper(),16,C.mint,Enum.Font.GothamBold,Enum.TextXAlignment.Center);avatarText.Size=UDim2.fromScale(1,1)
local profileName=label(profile,player.DisplayName or player.Name,11,C.text,Enum.Font.GothamBold);profileName.Position=UDim2.fromOffset(49,8);profileName.Size=UDim2.new(1,-55,0,17)
local profileRole=label(profile,"UI PREVIEW",9,C.muted,Enum.Font.Gotham);profileRole.Position=UDim2.fromOffset(49,26);profileRole.Size=UDim2.new(1,-55,0,14)

local content=make("Frame",{Name="Content",BackgroundTransparency=1,Position=UDim2.fromOffset(198,76),Size=UDim2.new(1,-210,1,-88)},main)
local pageTitle=label(content,"Overview",22,C.text,Enum.Font.GothamBold);pageTitle.Size=UDim2.new(1,0,0,30)
local pageDesc=label(content,"A clean foundation for your own UI system.",11,C.muted,Enum.Font.Gotham);pageDesc.Position=UDim2.fromOffset(0,30);pageDesc.Size=UDim2.new(1,0,0,20)
local search=make("TextBox",{Name="Search",BackgroundColor3=C.panel,BorderSizePixel=0,PlaceholderText="⌕   Search this page...",PlaceholderColor3=C.muted,Text="",TextColor3=C.text,Font=Enum.Font.Gotham,TextSize=12,ClearTextOnFocus=false,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,0,0,36),Position=UDim2.fromOffset(0,59)},content);round(search,10);outline(search,C.border,.4,1);pad(search,12,10,0,0)
local host=make("ScrollingFrame",{Name="PageHost",BackgroundTransparency=1,BorderSizePixel=0,Position=UDim2.fromOffset(0,106),Size=UDim2.new(1,0,1,-106),CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=3,ScrollBarImageColor3=C.dark},content)
local hostLayout=make("UIListLayout",{Padding=UDim.new(0,12),SortOrder=Enum.SortOrder.LayoutOrder},host)
local pages,navButtons={},{}
local currentPage="Overview"
local toast
local function showToast(title,msg)
 if toast then toast:Destroy() end
 toast=make("Frame",{Name="Toast",BackgroundColor3=C.panel,Size=UDim2.new(0,270,0,72),Position=UDim2.new(1,-290,1,25),ZIndex=100},screen);round(toast,12);outline(toast,C.dark,0,1)
 local accent=make("Frame",{BackgroundColor3=C.emerald,Size=UDim2.new(0,3,1,-20),Position=UDim2.fromOffset(0,10),ZIndex=101},toast);round(accent,2)
 local t=label(toast,title,12,C.text,Enum.Font.GothamBold);t.Position=UDim2.fromOffset(14,10);t.Size=UDim2.new(1,-25,0,20);t.ZIndex=101
 local d=label(toast,msg,10,C.muted,Enum.Font.Gotham);d.Position=UDim2.fromOffset(14,33);d.Size=UDim2.new(1,-25,0,23);d.TextWrapped=true;d.ZIndex=101
 tw(toast,.25,{Position=UDim2.new(1,-290,1,-94)})
 task.delay(2.8,function() if toast and toast.Parent then local oldToast=toast;tw(oldToast,.2,{Position=UDim2.new(1,-290,1,25)});task.delay(.22,function()if oldToast.Parent then oldToast:Destroy()end;if toast==oldToast then toast=nil end end)end end)
end
local function clearPage() for _,v in ipairs(host:GetChildren()) do if v:IsA("GuiObject") and v~=hostLayout then v:Destroy() end end end
local function section(title,desc)
 local card=make("Frame",{Name="Section_"..title:gsub("%W",""),BackgroundColor3=C.panel,BorderSizePixel=0,Size=UDim2.new(1,0,0,desc and 58 or 40),AutomaticSize=Enum.AutomaticSize.Y},host);round(card,11);outline(card,C.border,.5,1);pad(card,13,13,10,10)
 local t=label(card,title,13,C.text,Enum.Font.GothamBold);t.Size=UDim2.new(1,0,0,20)
 if desc then local d=label(card,desc,10,C.muted,Enum.Font.Gotham);d.Position=UDim2.fromOffset(0,22);d.Size=UDim2.new(1,0,0,18)end
 local inner=make("Frame",{BackgroundTransparency=1,Position=UDim2.fromOffset(0,desc and 44 or 25),Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y},card)
 make("UIListLayout",{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},inner)
 return inner
end
local function rowBase(parent,h) local r=make("Frame",{BackgroundColor3=C.panel2,BorderSizePixel=0,Size=UDim2.new(1,0,0,h or 42)},parent);round(r,8);return r end
local function addInfo(parent,title,desc)
 local r=rowBase(parent,48);local t=label(r,title,11,C.text,Enum.Font.GothamMedium);t.Position=UDim2.fromOffset(10,5);t.Size=UDim2.new(1,-20,0,17)
 local d=label(r,desc,9,C.muted,Enum.Font.Gotham);d.Position=UDim2.fromOffset(10,23);d.Size=UDim2.new(1,-20,0,15);return r
end
local function addButton(parent,title,caption,callback)
 local r=rowBase(parent,44);local t=label(r,title,11,C.text,Enum.Font.GothamMedium);t.Position=UDim2.fromOffset(10,0);t.Size=UDim2.new(1,-112,1,0)
 local b=make("TextButton",{Text=caption or "Open",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.mint,BackgroundColor3=Color3.fromRGB(15,74,54),AutoButtonColor=false,Size=UDim2.fromOffset(82,28),Position=UDim2.new(1,-92,.5,-14)},r);round(b,8)
 b.MouseButton1Click:Connect(function()tw(b,.1,{BackgroundColor3=C.dark});task.delay(.12,function()if b.Parent then tw(b,.15,{BackgroundColor3=Color3.fromRGB(15,74,54)})end end);if callback then callback()else showToast("Prototype control",title.." is UI-only for now.")end end);return r
end
local function addToggle(parent,title,default)
 local r=rowBase(parent,42);local t=label(r,title,11,C.text,Enum.Font.GothamMedium);t.Position=UDim2.fromOffset(10,0);t.Size=UDim2.new(1,-72,1,0)
 local track=make("TextButton",{Text="",AutoButtonColor=false,BackgroundColor3=default and C.dark or Color3.fromRGB(55,64,62),Size=UDim2.fromOffset(42,23),Position=UDim2.new(1,-53,.5,-11)},r);round(track,12)
 local knob=make("Frame",{BackgroundColor3=C.white,Size=UDim2.fromOffset(17,17),Position=default and UDim2.new(1,-20,.5,-8) or UDim2.fromOffset(3,3)},track);round(knob,10)
 local enabled=default==true;track.MouseButton1Click:Connect(function()enabled=not enabled;tw(track,.15,{BackgroundColor3=enabled and C.dark or Color3.fromRGB(55,64,62)});tw(knob,.15,{Position=enabled and UDim2.new(1,-20,.5,-8) or UDim2.fromOffset(3,3)});showToast(title,enabled and "Demo toggle: ON" or "Demo toggle: OFF")end);return r
end
local function addSlider(parent,title,initial,minV,maxV)
 local r=rowBase(parent,58);local t=label(r,title,11,C.text,Enum.Font.GothamMedium);t.Position=UDim2.fromOffset(10,5);t.Size=UDim2.new(1,-80,0,17)
 local vl=label(r,tostring(initial),10,C.mint,Enum.Font.GothamBold,Enum.TextXAlignment.Right);vl.Position=UDim2.new(1,-62,0,5);vl.Size=UDim2.fromOffset(50,17)
 local track=make("Frame",{BackgroundColor3=Color3.fromRGB(48,62,58),Size=UDim2.new(1,-20,0,5),Position=UDim2.fromOffset(10,37)},r);round(track,5)
 local ratio=math.clamp((initial-minV)/(maxV-minV),0,1);local fill=make("Frame",{BackgroundColor3=C.emerald,Size=UDim2.new(ratio,0,1,0)},track);round(fill,5)
 local knob=make("TextButton",{Text="",AutoButtonColor=false,BackgroundColor3=C.mint,Size=UDim2.fromOffset(13,13),Position=UDim2.new(ratio,-6,.5,-6)},track);round(knob,7)
 local dragging=false
 local function setX(x) local w=math.max(track.AbsoluteSize.X,1);local p=math.clamp((x-track.AbsolutePosition.X)/w,0,1);local value=math.floor(minV+(maxV-minV)*p+.5);fill.Size=UDim2.new(p,0,1,0);knob.Position=UDim2.new(p,-6,.5,-6);vl.Text=tostring(value)end
 knob.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true end end)
 UserInputService.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
 UserInputService.InputChanged:Connect(function(i)if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then setX(i.Position.X)end end)
 track.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then setX(i.Position.X)end end);return r
end
local function addNav(name,icon,order)
 local b=make("TextButton",{Name="Nav_"..name,Text="",BackgroundColor3=name==currentPage and Color3.fromRGB(13,69,51) or C.panel,AutoButtonColor=false,Size=UDim2.new(1,0,0,39),LayoutOrder=order},navList);round(b,9)
 local ic=label(b,icon,15,name==currentPage and C.mint or C.muted,Enum.Font.GothamBold,Enum.TextXAlignment.Center);ic.Position=UDim2.fromOffset(4,0);ic.Size=UDim2.fromOffset(28,39)
 local tx=label(b,name,11,name==currentPage and C.mint or C.muted,Enum.Font.GothamMedium);tx.Position=UDim2.fromOffset(36,0);tx.Size=UDim2.new(1,-42,1,0)
 navButtons[name]={button=b,icon=ic,label=tx}
 b.MouseButton1Click:Connect(function()
  currentPage=name;for n,d in pairs(navButtons)do local sel=n==name;tw(d.button,.12,{BackgroundColor3=sel and Color3.fromRGB(13,69,51) or C.panel});d.icon.TextColor3=sel and C.mint or C.muted;d.label.TextColor3=sel and C.mint or C.muted end
  pageTitle.Text=name;pageDesc.Text=({Overview="A clean foundation for your own UI system.",Components="Reusable visual controls and component samples.",Layout="Window, navigation, spacing, and responsive layout.",Appearance="Theme tokens and visual style preview.",Settings="Prototype preferences. No game systems are connected."})[name] or "UI prototype page"
  clearPage();if pages[name]then pages[name]()end;search.Text="";showToast("Page changed",name.." opened.")
 end)
end

pages.Overview=function()
 local hero=make("Frame",{Name="WelcomeCard",BackgroundColor3=Color3.fromRGB(11,49,37),BorderSizePixel=0,Size=UDim2.new(1,0,0,112)},host);round(hero,13);outline(hero,C.dark,.1,1)
 local ht=label(hero,"Balance in every detail.",18,C.text,Enum.Font.GothamBold);ht.Position=UDim2.fromOffset(16,16);ht.Size=UDim2.new(1,-32,0,26)
 local hd=label(hero,"A fresh UI foundation inspired by yin-yang balance.",10,C.mint,Enum.Font.Gotham);hd.Position=UDim2.fromOffset(16,44);hd.Size=UDim2.new(1,-32,0,20)
 local hb=make("TextButton",{Text="Explore components  →",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=C.text,BackgroundColor3=C.dark,AutoButtonColor=false,Size=UDim2.fromOffset(155,28),Position=UDim2.fromOffset(16,72)},hero);round(hb,8);hb.MouseButton1Click:Connect(function()if navButtons.Components then navButtons.Components.button:Activate()end end)
 local stats=make("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,74)},host);make("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder},stats)
 for i,it in ipairs({{"05","UI PAGES"},{"08+","CONTROLS"},{"100%","PROTOTYPE"}})do local card=make("Frame",{BackgroundColor3=C.panel,BorderSizePixel=0,Size=UDim2.new(1/3,-6,1,0),LayoutOrder=i},stats);round(card,10);outline(card,C.border,.6,1);local v=label(card,it[1],18,C.mint,Enum.Font.GothamBold,Enum.TextXAlignment.Center);v.Position=UDim2.fromOffset(0,10);v.Size=UDim2.new(1,0,0,24);local cap=label(card,it[2],8,C.muted,Enum.Font.GothamBold,Enum.TextXAlignment.Center);cap.Position=UDim2.fromOffset(0,38);cap.Size=UDim2.new(1,0,0,16)end
 local inner=section("Quick preview","Sample controls only — not connected to gameplay.");addInfo(inner,"Standalone interface","Runs locally in your own Roblox Studio project.");addButton(inner,"Preview notification","Show",function()showToast("Yin Yang UI","This is a visual-only notification sample.")end);addToggle(inner,"Sample switch",false)
end
pages.Components=function()local a=section("Buttons & switches","Reusable controls for future UI pages.");addButton(a,"Primary action","Click me");addButton(a,"Secondary action","Preview");addToggle(a,"Example toggle",true);addToggle(a,"Another toggle",false);local b=section("Sliders","Visual value controls.");addSlider(b,"Intensity",65,0,100);addSlider(b,"Scale",80,25,150);local c=section("Information rows","Compact title and description components.");addInfo(c,"Component label","Small helper text appears here.")end
pages.Layout=function()local a=section("Window layout","Core structure and spacing samples.");addInfo(a,"Top bar","Brand, status indicator, and minimize control.");addInfo(a,"Sidebar","Navigation list and profile card.");addInfo(a,"Content area","Page title, search field, and scrollable cards.");addInfo(a,"Floating launcher","Drag the ☯ icon around the screen.");addButton(a,"Show layout note","Show",function()showToast("Layout","This page is a layout reference only.")end)end
pages.Appearance=function()local a=section("Emerald night","Yin Yang UI's initial color palette.");for _,it in ipairs({{"Background",C.bg},{"Panel",C.panel},{"Emerald",C.emerald},{"Mint",C.mint},{"Muted text",C.muted}})do local r=rowBase(a,35);local n=label(r,it[1],10,C.text,Enum.Font.GothamMedium);n.Position=UDim2.fromOffset(10,0);n.Size=UDim2.new(1,-58,1,0);local sw=make("Frame",{BackgroundColor3=it[2],Size=UDim2.fromOffset(30,19),Position=UDim2.new(1,-41,.5,-9)},r);round(sw,6);outline(sw,C.white,.8,1)end;local b=section("Effects","Small interactions used across the interface.");addToggle(b,"Hover feedback (preview)",true);addToggle(b,"Rounded corners",true);addToggle(b,"Emerald outlines",true)end
pages.Settings=function()local a=section("Interface preferences","These controls demonstrate the settings layout only.");addToggle(a,"Open with launcher",true);addToggle(a,"Compact spacing",false);addToggle(a,"Show status badge",true);addSlider(a,"UI opacity",100,40,100);addSlider(a,"UI scale",100,75,125);addButton(a,"Reset demo preferences","Reset",function()showToast("Preferences","Demo preferences reset (visual prototype).")end);local b=section("About this build","No game logic or external libraries are loaded.");addInfo(b,"Version","Yin Yang UI 0.1.0");addInfo(b,"Integration","Connect your own authorized systems later.")end

addNav("Overview","⌂",1);addNav("Components","▦",2);addNav("Layout","▤",3);addNav("Appearance","◐",4);addNav("Settings","⚙",5)
local function openPage(name)
 currentPage=name;for n,d in pairs(navButtons)do local s=n==name;d.button.BackgroundColor3=s and Color3.fromRGB(13,69,51) or C.panel;d.icon.TextColor3=s and C.mint or C.muted;d.label.TextColor3=s and C.mint or C.muted end
 pageTitle.Text=name;pageDesc.Text=({Overview="A clean foundation for your own UI system.",Components="Reusable visual controls and component samples.",Layout="Window, navigation, spacing, and responsive layout.",Appearance="Theme tokens and visual style preview.",Settings="Prototype preferences. No game systems are connected."})[name] or "UI prototype page";clearPage();if pages[name]then pages[name]()end
end
openPage("Overview")
launcher.MouseButton1Click:Connect(function()main.Visible=not main.Visible;if main.Visible then tw(mainScale,.18,{Scale=1})end end)
minimize.MouseButton1Click:Connect(function()main.Visible=false end)
-- Drag the main window from the top bar.
do local dragging,dragStart,startPos;top.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true;dragStart=i.Position;startPos=main.Position;i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dragging=false end end)end end);UserInputService.InputChanged:Connect(function(i)if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-dragStart;main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)end end)end
local function responsive()
 local cam=workspace.CurrentCamera;if not cam then return end;local v=cam.ViewportSize;local w=math.max(310,math.min(720,v.X-24));local h=math.max(390,math.min(470,v.Y-40));main.Size=UDim2.fromOffset(w,h);main.Position=UDim2.new(.5,-w/2,.5,-h/2);mainScale.Scale=math.clamp(math.min(v.X/760,v.Y/510),.78,1)
 if w<520 then sidebar.Size=UDim2.new(0,105,1,-88);sidebar.Position=UDim2.fromOffset(8,76);content.Position=UDim2.fromOffset(121,76);content.Size=UDim2.new(1,-129,1,-88);for _,d in pairs(navButtons)do d.label.Visible=false;d.icon.Position=UDim2.new(.5,-14,0,0)end;profile.Visible=false;navHeader.Text="MENU"
 else sidebar.Size=UDim2.new(0,174,1,-88);sidebar.Position=UDim2.fromOffset(12,76);content.Position=UDim2.fromOffset(198,76);content.Size=UDim2.new(1,-210,1,-88);for _,d in pairs(navButtons)do d.label.Visible=true;d.icon.Position=UDim2.fromOffset(4,0)end;profile.Visible=true;navHeader.Text="NAVIGATION" end
end
if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(responsive)end;responsive()
search:GetPropertyChangedSignal("Text"):Connect(function()
 local q=string.lower(search.Text or "")
 for _,child in ipairs(host:GetChildren())do if child:IsA("Frame") and child~=hostLayout then local hay=string.lower(child.Name);for _,d in ipairs(child:GetDescendants())do if d:IsA("TextLabel") or d:IsA("TextButton")then hay=hay.." "..string.lower(d.Text)end end;child.Visible=q=="" or string.find(hay,q,1,true)~=nil end end
end)
showToast("Yin Yang UI","Standalone UI prototype loaded.")
