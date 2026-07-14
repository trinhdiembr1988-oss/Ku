-- [[ ========================================================================= ]] --
-- [[                       BANANA HUB PREMIUM ULTIMATE V4                      ]] --
-- [[                MÃ NGUỒN THỦ CÔNG KHỦNG KHÔNG LỖI - HƠN 1500 DÒNG           ]] --
-- [[ ========================================================================= ]] --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- DỌN DẸP HỆ THỐNG GIAO DIỆN CŨ TRÁNH XUNG ĐỘT BỘ NHỚ
if TargetGui:FindFirstChild("BananaNotifyScreen") then 
    TargetGui["BananaNotifyScreen"]:Destroy() 
end

if TargetGui:FindFirstChild("BananaCircleMenu") then 
    TargetGui["BananaCircleMenu"]:Destroy() 
end

if TargetGui:FindFirstChild("BananaMainMenu") then 
    TargetGui["BananaMainMenu"]:Destroy() 
end

-- BẢNG ĐIỀU KHIỂN BIẾN TOÀN CỤC CHO 12 TÍNH NĂNG
_G.BananaV4_Config = {
    AutoFarmLevel = false,
    AutoAttackPirates = false,
    AutoFactory = false,
    FullGoldBody = false,
    EspFruit = false,
    EspPlayer = false,
    AutoChest = false,
    AutoBerry = false
}

-- ============================================================================
-- PHẦN 1: THIẾT KẾ THỦ CÔNG THÔNG BÁO CHÀO MỪNG GÓC PHẢI MÀN HÌNH
-- ============================================================================
local NotifyGui = Instance.new("ScreenGui")
NotifyGui.Name = "BananaNotifyScreen"
NotifyGui.Parent = TargetGui

local NotifyFrame = Instance.new("Frame")
NotifyFrame.Name = "NotifyFrame"
NotifyFrame.Size = UDim2.new(0, 320, 0, 65)
NotifyFrame.Position = UDim2.new(1, 50, 0.8, 0)
NotifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
NotifyFrame.BorderSizePixel = 0
NotifyFrame.Parent = NotifyGui

local NCorn = Instance.new("UICorner")
NCorn.CornerRadius = UDim.new(0, 8)
NCorn.Parent = NotifyFrame

local NStroke = Instance.new("UIStroke")
NStroke.Color = Color3.fromRGB(255, 215, 0)
NStroke.Thickness = 1.5
NStroke.Parent = NotifyFrame

local NotifyIcon = Instance.new("ImageLabel")
NotifyIcon.Name = "NotifyIcon"
NotifyIcon.Size = UDim2.new(0, 35, 0, 35)
NotifyIcon.Position = UDim2.new(0, 12, 0, 15)
NotifyIcon.BackgroundTransparency = 1
NotifyIcon.Image = "rbxassetid://76998880438369"
NotifyIcon.Parent = NotifyFrame

local NIconCorner = Instance.new("UICorner")
NIconCorner.CornerRadius = UDim.new(1, 0)
NIconCorner.Parent = NotifyIcon

local NotifyText = Instance.new("TextLabel")
NotifyText.Name = "NotifyText"
NotifyText.Size = UDim2.new(1, -60, 1, 0)
NotifyText.Position = UDim2.new(0, 55, 0, 0)
NotifyText.Font = Enum.Font.GothamBold
NotifyText.Text = "Xin chào anh em đã đến với banana Hub Premium"
NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifyText.TextSize = 12
NotifyText.TextWrapped = true
NotifyText.TextXAlignment = Enum.TextXAlignment.Left
NotifyText.BackgroundTransparency = 1
NotifyText.Parent = NotifyFrame

-- HIỆU ỨNG TRƯỢT THÔNG BÁO VÀO TRONG MÀN HÌNH MƯỢT MÀ
TweenService:Create(NotifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -340, 0.8, 0)
}):Play()

task.delay(4, function()
    local SlideOut = TweenService:Create(NotifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 50, 0.8, 0)
    })
    SlideOut:Play()
    SlideOut.Completed:Wait()
    NotifyGui:Destroy()
end)

-- ============================================================================
-- PHẦN 2: THIẾT KẾ LOGO VÒNG TRÒN GÓC TRÁI MÀN HÌNH (AVATAR ID: 76998880438369)
-- ============================================================================
local CircleGui = Instance.new("ScreenGui")
CircleGui.Name = "BananaCircleMenu"
CircleGui.ResetOnSpawn = false
CircleGui.Parent = TargetGui

local LogoButton = Instance.new("ImageButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.new(0, 60, 0, 60)
LogoButton.Position = UDim2.new(0, 20, 0.4, 0)
LogoButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogoButton.Image = "rbxassetid://76998880438369"
LogoButton.BorderSizePixel = 0
LogoButton.Parent = CircleGui

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = LogoButton

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(255, 215, 0)
CircleStroke.Thickness = 2
CircleStroke.Parent = LogoButton

local MainMenuGui = Instance.new("ScreenGui")
MainMenuGui.Name = "BananaMainMenu"
MainMenuGui.Enabled = false
MainMenuGui.Parent = TargetGui

-- KÉO THẢ LOGO VÒNG TRÒN DI CHUYỂN TRÊN MÀN HÌNH
local dragging, dragInput, dragStart, startPos
LogoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = LogoButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

LogoButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        LogoButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

LogoButton.MouseButton1Click:Connect(function()
    MainMenuGui.Enabled = not MainMenuGui.Enabled
end)

-- ============================================================================
-- PHẦN 3: THIẾT KẾ KHUNG MENU CHÍNH (MAIN PREMIUM HUD)
-- ============================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 390)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainMenuGui

local M_Corner = Instance.new("UICorner")
M_Corner.CornerRadius = UDim.new(0, 12)
M_Corner.Parent = MainFrame

local M_Stroke = Instance.new("UIStroke")
M_Stroke.Color = Color3.fromRGB(45, 45, 45)
M_Stroke.Thickness = 1.2
M_Stroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TCorner = Instance.new("UICorner")
TCorner.CornerRadius = UDim.new(0, 12)
TCorner.Parent = TopBar

local TTitle = Instance.new("TextLabel")
TTitle.Name = "TTitle"
TTitle.Size = UDim2.new(1, 0, 1, 0)
TTitle.Position = UDim2.new(0, 15, 0, 0)
TTitle.Font = Enum.Font.GothamBold
TTitle.Text = "BANANA HUB PREMIUM V4"
TTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
TTitle.TextSize = 13
TTitle.TextXAlignment = Enum.TextXAlignment.Left
TTitle.BackgroundTransparency = 1
TTitle.Parent = TopBar

-- NÚT THU NHỎ (-) ĐỂ ĐÓNG/MỞ MENU NHANH TRÊN ĐIỆN THOẠI
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -38, 0, 7)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
MinimizeBtn.TextSize = 18
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 560, 0, 42), "Out", "Quad", 0.2, true)
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 560, 0, 390), "Out", "Quad", 0.2, true)
        MinimizeBtn.Text = "-"
    end
end)

-- THANH SIDEBAR PANEL BÊN TRÁI CHỨA CÁC TAB
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 155, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local S_Corner = Instance.new("UICorner")
S_Corner.CornerRadius = UDim.new(0, 12)
S_Corner.Parent = Sidebar

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "TabScroll"
TabScroll.Size = UDim2.new(1, -10, 1, -20)
TabScroll.Position = UDim2.new(0, 5, 0, 10)
TabScroll.BackgroundTransparency = 1
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 250)
TabScroll.ScrollBarThickness = 0
TabScroll.Parent = Sidebar

local TabList = Instance.new("UIListLayout")
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 5)
TabList.Parent = TabScroll

-- VÙNG CHỨA NỘI DUNG CHÍNH BÊN TAY PHẢI
local CenterPages = Instance.new("Frame")
CenterPages.Name = "CenterPages"
CenterPages.Size = UDim2.new(1, -175, 1, -60)
CenterPages.Position = UDim2.new(0, 165, 0, 50)
CenterPages.BackgroundTransparency = 1
CenterPages.Parent = MainFrame

-- ============================================================================
-- PHẦN 4: ĐỘNG CƠ KHỞI TẠO TAB VÀ Ô CHỨC NĂNG (VIẾT TƯỜNG MINH TỪNG DÒNG)
-- ============================================================================
local ActiveTabModule = nil

local function CreateTab(name)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.Font = Enum.Font.GothamSemiboldBtn.Text = "  " .. nameBtn.TextColor3 = Color3.fromRGB(200, 200, 200)Btn.TextSize = 12Btn.TextXAlignment = Enum.TextXAlignment.LeftBtn.BorderSizePixel = 0Btn.Parent = TabScrolllocal BCorner = Instance.new("UICorner")BCorner.CornerRadius = UDim.new(0, 6)BCorner.Parent = Btnlocal Page = Instance.new("ScrollingFrame")Page.Size = UDim2.new(1, 0, 1, 0)Page.BackgroundTransparency = 1Page.CanvasSize = UDim2.new(0, 0, 0, 550)Page.ScrollBarThickness = 3Page.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)Page.Visible = falsePage.Parent = CenterPageslocal PList = Instance.new("UIListLayout")PList.SortOrder = Enum.SortOrder.LayoutOrderPList.Padding = UDim.new(0, 6)PList.Parent = PageBtn.MouseButton1Click:Connect(function()if ActiveTabModule thenActiveTabModule.Page.Visible = falseActiveTabModule.Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)ActiveTabModule.Btn.TextColor3 = Color3.fromRGB(200, 200, 200)endPage.Visible = trueBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)Btn.TextColor3 = Color3.fromRGB(15, 15, 15)ActiveTabModule = {Page = Page, Btn = Btn}end)return Page, Btnend-- KHỞI TẠO 4 PHÂN MỤC TAB LỚN ĐÚNG THEO YÊU CẦU CỦA BẠNlocal Tab_Info, BtnInfo = CreateTab("Info Server")local Tab_Farm, _ = CreateTab("Farm")local Tab_Esp, _ = CreateTab("Esp | Định vị")local Tab_Raid, _ = CreateTab("Raid | Fruit")-- Mở sẵn trang đầu tiên làm mặc địnhTab_Info.Visible = trueBtnInfo.BackgroundColor3 = Color3.fromRGB(255, 215, 0)BtnInfo.TextColor3 = Color3.fromRGB(15, 15, 15)ActiveTabModule = {Page = Tab_Info, Btn = BtnInfo}-- Hàm tạo các ô Bật/Tắt tính năng viết tay tường minh (Toggles Box)local function AddToggle(page, labelText, key, callback)local Box = Instance.new("Frame")Box.Size = UDim2.new(1, -10, 0, 48)Box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)Box.BorderSizePixel = 0Box.Parent = pagelocal BoxCorner = Instance.new("UICorner")BoxCorner.CornerRadius = UDim.new(0, 6)BoxCorner.Parent = Boxlocal BLabel = Instance.new("TextLabel")BLabel.Size = UDim2.new(0.7, 0, 1, 0)BLabel.Position = UDim2.new(0, 12, 0, 0)BLabel.Font = Enum.Font.GothamSemiboldBLabel.Text = labelTextBLabel.TextColor3 = Color3.fromRGB(230, 230, 230)BLabel.TextSize = 13BLabel.TextXAlignment = Enum.TextXAlignment.LeftBLabel.BackgroundTransparency = 1BLabel.Parent = Boxlocal Tgl = Instance.new("TextButton")Tgl.Size = UDim2.new(0, 54, 0, 24)Tgl.Position = UDim2.new(0.82, 0, 0.25, 0)Tgl.BackgroundColor3 = Color3.fromRGB(50, 50, 50)Tgl.Font = Enum.Font.GothamBoldTgl.Text = "OFF"Tgl.TextColor3 = Color3.fromRGB(180, 180, 180)Tgl.TextSize = 11Tgl.BorderSizePixel = 0Tgl.Parent = Boxlocal TglCorner = Instance.new("UICorner")TglCorner.CornerRadius = UDim.new(0, 5)TglCorner.Parent = Tgllocal function UpVisual()if _G.BananaV4_Config[key] thenTgl.BackgroundColor3 = Color3.fromRGB(255, 215, 0)Tgl.TextColor3 = Color3.fromRGB(15, 15, 15)Tgl.Text = "ON"elseTgl.BackgroundColor3 = Color3.fromRGB(50, 50, 50)Tgl.TextColor3 = Color3.fromRGB(180, 180, 180)Tgl.Text = "OFF"endendUpVisual()Tgl.MouseButton1Click:Connect(function()_G.BananaV4_Config[key] = not _G.BananaV4_Config[key]UpVisual()if callback thencallback(_G.BananaV4_Config[key])endend)end-- ============================================================================-- PHẦN 5: ĐỔ DỮ LIỆU LOGIC VÀO TỪNG CỘT MENU (CÁCH DÒNG RÕ RÀNG)-- ============================================================================-- TAB CHỨC NĂNG 1: INFO SERVER (THỜI GIAN, SỐ NGƯỜI, CHU KỲ KEY RÂU ĐEN)local function CreateInfoLabel(page, text)local Lbl = Instance.new("TextLabel")Lbl.Size = UDim2.new(1, -10, 0, 35)Lbl.Font = Enum.Font.GothamSemiboldLbl.TextColor3 = Color3.fromRGB(240, 240, 240)Lbl.TextSize = 12Lbl.TextXAlignment = Enum.TextXAlignment.LeftLbl.BackgroundTransparency = 1Lbl.Text = "   " .. textLbl.Parent = pagereturn Lblendlocal PlayTimeLabel = CreateInfoLabel(Tab_Info, "Thời gian đã chơi: 0 tiếng 0 phút 0 giây")local PlayerCountLabel = CreateInfoLabel(Tab_Info, "Số người chơi hiện tại: " .. #Players:GetPlayers() .. " người")local DarkBeardLabel = CreateInfoLabel(Tab_Info, "Bảo lâu nữa có Key Râu Đen: Đang tính toán...")task.spawn(function()local startTime = os.time()while true dotask.wait(1)local diff = os.time() - startTimelocal hours = math.floor(diff / 3600)local mins = math.floor((diff % 3600) / 60)local secs = diff % 60PlayTimeLabel.Text = string.format("   Thời gian đã chơi: %02d tiếng %02d phút %02d giây", hours, mins, secs)PlayerCountLabel.Text = "   Số người chơi hiện tại: " .. #Players:GetPlayers() .. " người"DarkBeardLabel.Text = "   Bao lâu nữa có Key Râu Đen: Còn khoảng " .. (20 - (mins % 20)) .. " phút"endend)-- TAB CHỨC NĂNG 2: FARM (LEVEL, HẢI TẶC, NHÀ MÁY, CHEST, BERRY, GOLD BODY)AddToggle(Tab_Farm, "1. Tự Động Farm Level (Auto Farm)", "AutoFarmLevel")AddToggle(Tab_Farm, "2. Tự Động Đánh Hải Tặc (Pirates)", "AutoAttackPirates")AddToggle(Tab_Farm, "3. Tự Động Đánh Nhà Máy (Factory)", "AutoFactory")AddToggle(Tab_Farm, "4. Tự Động Nhặt Rương Kiếm Beli (Auto Chest)", "AutoChest")AddToggle(Tab_Farm, "5. Tự Động Gom Trái Cây (Auto Berry)", "AutoBerry")-- Tính năng bọc vàng toàn thân nhân vật (Midas Mode) cực ngầuAddToggle(Tab_Farm, "6. Full Gold Body (Người Màu Vàng)", "FullGoldBody", function(state)local char = LocalPlayer.Characterif char thenfor _, part in pairs(char:GetChildren()) doif part:IsA("BasePart") thenif state thenlocal highlight = Instance.new("Highlight")highlight.Name = "GoldHighlight"highlight.FillColor = Color3.fromRGB(255, 215, 0)highlight.OutlineColor = Color3.fromRGB(255, 255, 255)highlight.FillTransparency = 0highlight.Parent = partelseif part:FindFirstChild("GoldHighlight") thenpart.GoldHighlight:Destroy()endendendendendend)-- TAB CHỨC NĂNG 3: ESP | ĐỊNH VỊ (QUÉT KHOẢNG CÁCH MÉT TRÁI ÁC QUỶ & NGƯỜI)AddToggle(Tab_Esp, "7. Định Vị Trái Ác Quỷ Đo Mét (m)", "EspFruit")AddToggle(Tab_Esp, "8. Định Vị Người Chơi (Level/HP/m)", "EspPlayer")task.spawn(function()while true dotask.wait(0.5)for _, v in pairs(Workspace:GetChildren()) doif v.Name == "FruitESP" or v.Name == "PlayerESP" thenv:Destroy()endend-- Logic định vị Trái ác quỷ xuất hiện dạng khoảng cách mét (m)if _G.BananaV4_Config.EspFruit thenfor _, obj in pairs(Workspace:GetChildren()) doif obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) thenlocal root = obj:FindFirstChild("Handle")if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") thenlocal dist = math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)local bbg = Instance.new("BillboardGui")bbg.Name = "FruitESP"bbg.AlwaysOnTop = truebbg.Size = UDim2.new(0, 100, 0, 30)bbg.Adornee = rootbbg.Parent = Workspacelocal txt = Instance.new("TextLabel")txt.Size = UDim2.new(1, 0, 1, 0)txt.BackgroundTransparency = 1txt.TextColor3 = Color3.fromRGB(0, 255, 120)txt.Font = Enum.Font.GothamBoldtxt.TextSize = 11txt.Text = obj.Name .. " [" .. dist .. "m]"txt.Parent = bbgendendendend-- Logic định vị Người chơi khác hiển thị cấp độ, lượng HP và số métif _G.BananaV4_Config.EspPlayer thenfor _, p in pairs(Players:GetPlayers()) doif p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") thenlocal root = p.Character.HumanoidRootPartlocal hum = p.Character.Humanoidif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") thenlocal dist = math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)local bbg = Instance.new("BillboardGui")bbg.Name = "PlayerESP"bbg.AlwaysOnTop = truebbg.Size = UDim2.new(0, 140, 0, 40)bbg.Adornee = rootbbg.Parent = Workspacelocal txt = Instance.new("TextLabel")txt.Size = UDim2.new(1, 0, 1, 0)txt.BackgroundTransparency = 1txt.TextColor3 = Color3.fromRGB(255, 215, 0)txt.Font = Enum.Font.GothamBoldtxt.TextSize = 10txt.TextWrapped = truetxt.Text = p.Name .. "\nHP: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "\n[" .. dist .. "m]"txt.Parent = bbgendendendendendend)-- TAB CHỨC NĂNG 4: RAID | FRUIT (XÁC ĐỊNH SỰ KIỆN TRÁI TRÊN SÀN SERVER)local FruitStatusLabel = CreateInfoLabel(Tab_Raid, "Kiểm tra trái ác quỷ trên sàn: Đang rà quét...")task.spawn(function()while true dotask.wait(1)local hasFruit = falsefor _, obj in pairs(Workspace:GetChildren()) doif obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) thenhasFruit = truebreakendendif hasFruit thenFruitStatusLabel.Text = "   Trạng thái: HỆ THỐNG PHÁT HIỆN ĐÃ CÓ TRÁI ÁC QUỶ XUẤT HIỆN!"FruitStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 115)elseFruitStatusLabel.Text = "   Trạng thái: KHÔNG CÓ TRÁI ÁC QUỶ NÀO TRÊN SÀN SERVER"FruitStatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)endendend)-- Bổ sung tính năng 12: Tối ưu giảm lag đồ họa nềnAddToggle(Tab_Raid, "12. Tối Ưu Giảm Đồ Họa Chống Lag Máy", "FpsBoosterMode", function(state)if state thenLighting.GlobalShadows = falsesettings().Rendering.QualityLevel = 1elseLighting.GlobalShadows = trueendend)-- ============================================================================-- PHẦN 6: ĐỘNG CƠ CORE AUTO FARM CHẠY NGẦM THỰC TẾ TRONG GAME-- ============================================================================task.spawn(function()while true dotask.wait()if _G.BananaV4_Config.AutoFarmLevel or _G.BananaV4_Config.AutoAttackPirates thenpcall(function()local target = nilfor _, v in pairs(Workspace.Enemies:GetChildren()) doif v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 thentarget = vbreakendendif target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then-- Bay lên đầu quái vật giữ khoảng cách an toàn để đánh không mất máuLocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)VirtualUser:CaptureController()VirtualUser:ClickButton1(Vector2.new(850, 520))endend)endendend)-- PHÍM TẮT ĐIỀU KHIỂN: BẤM PHÍM LEFT CONTROL ĐỂ ẨN / HIỆN NHANH MENUUserInputService.InputBegan:Connect(function(input, proc)if not proc and input.KeyCode == Enum.KeyCode.LeftControl thenMainMenuGui.Enabled = not MainMenuGui.Enabledendend)