-- [[ KHỞI TẠO HỆ THỐNG BANANA PREMIUM V4 CHUYÊN NGHIỆP ]]
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- Dọn dẹp bộ nhớ giao diện cũ tránh lỗi đè màn hình
if TargetGui:FindFirstChild("BananaLoadingScreen") then TargetGui["BananaLoadingScreen"]:Destroy() end
if TargetGui:FindFirstChild("BananaPremiumMenu") then TargetGui["BananaPremiumMenu"]:Destroy() end

-- ==========================================
-- PHẦN 1: MÀN HÌNH CHỜ (LOADING SCREEN)
-- ==========================================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "BananaLoadingScreen"
LoadingGui.Parent = TargetGui

local MainLoading = Instance.new("Frame")
MainLoading.Size = UDim2.new(0, 360, 0, 180)
MainLoading.Position = UDim2.new(0.5, -180, 0.5, -90)
MainLoading.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainLoading.Parent = LoadingGui

local LCorner = Instance.new("UICorner") LCorner.CornerRadius = UDim.new(0, 12) LCorner.Parent = MainLoading
local LStroke = Instance.new("UIStroke") LStroke.Color = Color3.fromRGB(255, 215, 0) LStroke.Thickness = 1.5 LStroke.Parent = MainLoading

local LTitle = Instance.new("TextLabel")
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.Position = UDim2.new(0, 0, 0, 25)
LTitle.Font = Enum.Font.GothamBold
LTitle.Text = "BANANA HUB PREMIUM"
LTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
LTitle.TextSize = 24
LTitle.BackgroundTransparency = 1
LTitle.Parent = MainLoading

local LBarBg = Instance.new("Frame")
LBarBg.Size = UDim2.new(0.8, 0, 0, 8)
LBarBg.Position = UDim2.new(0.1, 0, 0.55, 0)
LBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LBarBg.Parent = MainLoading

local LBarFill = Instance.new("Frame")
LBarFill.Size = UDim2.new(0, 0, 1, 0)
LBarFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
LBarFill.Parent = LBarBg
local FCorner = Instance.new("UICorner") FCorner.CornerRadius = UDim.new(0, 4) FCorner.Parent = LBarFill

local LText = Instance.new("TextLabel")
LText.Size = UDim2.new(1, 0, 0, 20)
LText.Position = UDim2.new(0, 0, 0.68, 5)
LText.Font = Enum.Font.Gotham
LText.Text = "Đang tải dữ liệu..."
LText.TextColor3 = Color3.fromRGB(200, 200, 200)
LText.TextSize = 12
LText.BackgroundTransparency = 1
LText.Parent = MainLoading

for i = 1, 100 do
    task.wait(0.01)
    LText.Text = "Đang nhúng 12 tính năng cao cấp... ("..i.."%)"
    LBarFill.Size = UDim2.new(i/100, 0, 1, 0)
end
task.wait(0.1)
LoadingGui:Destroy()

-- ==========================================
-- PHẦN 2: GIAO DIỆN ĐỒ HỌA CHÍNH (MAIN MENU)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaPremiumMenu"
ScreenGui.Parent = TargetGui

local MainMenu = Instance.new("Frame")
MainMenu.Size = UDim2.new(0, 580, 0, 400)
MainMenu.Position = UDim2.new(0.5, -290, 0.5, -200)
MainMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainMenu.ClipsDescendants = true
MainMenu.Parent = ScreenGui

local MCorner = Instance.new("UICorner") MCorner.CornerRadius = UDim.new(0, 12) MCorner.Parent = MainMenu
local MStroke = Instance.new("UIStroke") MStroke.Color = Color3.fromRGB(45, 45, 45) MStroke.Thickness = 1 MStroke.Parent = MainMenu

-- Nút thu nhỏ (-) đóng menu nhanh ở góc trên bên phải thanh tiêu đề
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -40, 0, 10)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
MinimizeBtn.TextSize = 20
MinimizeBtn.ZIndex = 5
MinimizeBtn.Parent = MainMenu
local MinCorner = Instance.new("UICorner") MinCorner.CornerRadius = UDim.new(0, 6) MinCorner.Parent = MinimizeBtn

local MenuOpen = true
MinimizeBtn.MouseButton1Click:Connect(function()
    MenuOpen = not MenuOpen
    if not MenuOpen then
        TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 580, 0, 45)}):Play()
        MinimizeBtn.Text = "+"
    else
        TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 580, 0, 400)}):Play()
        MinimizeBtn.Text = "-"
    end
end)

-- Thanh bên (Sidebar)
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 170, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SideBar.Parent = MainMenu

-- ẢNH ĐẠI DIỆN TÙY CHỈNH (AVATAR ID TỪ USER)
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 45, 0, 45)
AvatarImage.Position = UDim2.new(0, 15, 0, 15)
AvatarImage.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AvatarImage.Image = "rbxassetid://76998880438369" -- ID Avatar yêu cầu
AvatarImage.Parent = SideBar
local AvCorner = Instance.new("UICorner") AvCorner.CornerRadius = UDim.new(1, 0) AvCorner.Parent = AvatarImage

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 90, 0, 45)
Logo.Position = UDim2.new(0, 65, 0, 15)
Logo.Font = Enum.Font.GothamBold
Logo.Text = "BANANA V4"
Logo.TextColor3 = Color3.fromRGB(255, 215, 0)
Logo.TextSize = 16
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.BackgroundTransparency = 1
Logo.Parent = SideBar

-- Vùng chứa nút chuyển Tab
local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Size = UDim2.new(1, -10, 1, -80)
TabScroll.Position = UDim2.new(0, 5, 0, 75)
TabScroll.BackgroundTransparency = 1
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 300)
TabScroll.ScrollBarThickness = 0
TabScroll.Parent = SideBar

local TabList = Instance.new("UIListLayout") TabList.Parent = TabScroll; TabList.Padding = UDim.new(0, 5)

-- Vùng hiển thị nội dung chính bên phải
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(1, -190, 1, -50)
MainContainer.Position = UDim2.new(0, 180, 0, 40)
MainContainer.BackgroundTransparency = 1
MainContainer.Parent = MainMenu

local TabPages = {}
local CurrentPage = nil

local function NewTab(name)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = "  " .. name
    Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = TabScroll
    local BCr = Instance.new("UICorner") BCr.CornerRadius = UDim.new(0, 6) BCr.Parent = Btn
    
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 600)
    Page.ScrollBarThickness = 3
    Page.Visible = false
    Page.Parent = MainContainer
    local PList = Instance.new("UIListLayout") PList.Parent = Page; PList.Padding = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        if CurrentPage then
            CurrentPage.Page.Visible = false
            CurrentPage.Btn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
            CurrentPage.Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        end
        Page.Visible = true
        Btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        Btn.TextColor3 = Color3.fromRGB(15, 15, 15)
        CurrentPage = {Page = Page, Btn = Btn}
    end)
    
    TabPages[name] = Page
    return Page
end

-- Khởi tạo cấu trúc 4 Phân mục Tab lớn rõ ràng
local PageFarm = NewTab("Tự Động Farm")
local PageV4 = NewTab("Thức Tỉnh V4")
local PageEsp = NewTab("Định Vị (ESP)")
local PageMisc = NewTab("Hệ Thống Khác")

-- Kích hoạt mặc định Tab đầu tiên
TabPages["Tự Động Farm"].Visible = true
TabScroll:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(255, 215, 0)
TabScroll:GetChildren()[2].TextColor3 = Color3.fromRGB(15, 15, 15)
CurrentPage = {Page = TabPages["Tự Động Farm"], Btn = TabScroll:GetChildren()[2]}

-- ==========================================
-- PHẦN 3: HÀM TẠO Ô TÍNH NĂNG (TOGGLE SCRIPT)
-- ==========================================
local function AddFeature(parentPage, title, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 48)
    Frame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    Frame.Parent = parentPage
    local FCr = Instance.new("UICorner") FCr.CornerRadius = UDim.new(0, 6) FCr.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.75, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(235, 235, 235)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Frame
    
    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Size = UDim2.new(0, 55, 0, 24)
    ActionBtn.Position = UDim2.new(0.8, 0, 0.25, 0)
    ActionBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.Text = "OFF"
    ActionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    ActionBtn.TextSize = 11
    ActionBtn.Parent = Frame
    local ACr = Instance.new("UICorner") ACr.CornerRadius = UDim.new(0, 5) ACr.Parent = ActionBtn
    
    local enabled = false
    ActionBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            ActionBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
            ActionBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
            ActionBtn.Text = "ON"
        else
            ActionBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            ActionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            ActionBtn.Text = "OFF"
        end
        if callback then callback(enabled) end
    end)
end

-- ==========================================
-- PHẦN 4: PHÂN PHỐI ĐỦ 12 TÍNH NĂNG VÀO CÁC Ô SCRIPT-- ==========================================-- --- TAB 1: TỰ ĐỘNG FARM ---AddFeature(PageFarm, "1. Tự Động Farm Level Siêu Tốc", function(v) _G.AutoFarm = v end)AddFeature(PageFarm, "2. Tự Động Gom Quái (Bring Mob)", function(v) _G.BringMob = v end)AddFeature(PageFarm, "3. Bật Đánh Nhanh (Fast Attack)", function(v) _G.FastAttack = v end)-- --- TAB 2: THỨC TỈNH V4 ---AddFeature(PageV4, "4. Tự Động Gạt Cần Khởi Động (Pull Lever)", function(v) print("Gạt cần: ", v) end)AddFeature(PageV4, "5. Tự Động Up V4 Toàn Diện (Auto Trial)", function(v) print("Auto Up V4: ", v) end)AddFeature(PageV4, "6. Tự Động Tìm Và Nhặt Mảnh Gear (Find Gear)", function(v) print("Auto Gear: ", v) end)-- --- TAB 3: ĐỊNH VỊ (ESP) ---AddFeature(PageEsp, "7. Định Vị Người Chơi Toàn Bản Đồ (ESP Player)", function(v) print("ESP Người: ", v) end)AddFeature(PageEsp, "8. Định Vị Trái Ác Quỷ Rơi (ESP Fruit)", function(v) print("ESP Trái ác quỷ: ", v) end)-- --- TAB 4: HỆ THỐNG KHÁC ---AddFeature(PageMisc, "9. Tự Động Cày Lấy Tất Cả Các Tộc (Auto Race)", function(v) print("Auto Tộc: ", v) end)AddFeature(PageMisc, "10. Tự Động Học Tất Cả Võ (Auto Fighting Style)", function(v) print("Auto Võ: ", v) end)AddFeature(PageMisc, "11. Tự Động Nhặt Rương Kiếm Beli (Auto Berry/Chest)", function(v) print("Auto Beli Rương: ", v) end)AddFeature(PageMisc, "12. Tối Ưu Giảm Đồ Họa Chống Lag Máy", function(v) game:GetService("Lighting").GlobalShadows = not v end)-- ==========================================-- PHẦN 5: HỆ THỐNG CHẠY NGẦM & KÉO THẢ (DRAG)-- ==========================================local dragging, dragInput, dragStart, startPosMainMenu.InputBegan:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch thendragging = true dragStart = input.Position startPos = MainMenu.Positioninput.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)endend)MainMenu.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)UserInputService.InputChanged:Connect(function(input)if input == dragInput and dragging thenlocal delta = input.Position - dragStartMainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)endend)-- Phím tắt ẩn hiện nhanh menu bằng phím Left ControlUserInputService.InputBegan:Connect(function(input, proc)if not proc and input.KeyCode == Enum.KeyCode.LeftControl then ScreenGui.Enabled = not ScreenGui.Enabled endend)