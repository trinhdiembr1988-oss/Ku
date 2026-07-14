-- [[ ========================================================================= ]] --
-- [[                       BANANA HUB PREMIUM ULTIMATE EDITION                 ]] --
-- [[                MÃ NGUỒN THỦ CÔNG HOÀN TOÀN - KHÔNG DÙNG THƯ VIỆN          ]] --
-- [[ ========================================================================= ]] --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hệ thống lưu trữ trạng thái cấu hình 12 tính năng nâng cao
_G.BananaPremium_Config = {
    AutoFarmLevel = false,
    BringMobMode = false,
    FastAttack = false,
    PullLeverV4 = false,
    AutoTrialV4 = false,
    FindGearV4 = false,
    EspPlayer = false,
    EspFruit = false,
    AutoAllRaces = false,
    AutoFightingStyle = false,
    AutoChestBerry = false,
    FpsBoosterMode = false,
    MenuMinimized = false,
    UiThemeColor = Color3.fromRGB(255, 215, 0)
}

-- Dọn dẹp các GUI cũ để tránh trùng lặp
if TargetGui:FindFirstChild("BananaNotifyScreen") then TargetGui["BananaNotifyScreen"]:Destroy() end
if TargetGui:FindFirstChild("BananaLoading") then TargetGui["BananaLoading"]:Destroy() end
if TargetGui:FindFirstChild("BananaPremiumMenu_Cyber") then TargetGui["BananaPremiumMenu_Cyber"]:Destroy() end

-- ============================================================================
-- PHẦN 1: HỆ THỐNG THÔNG BÁO CHÀO MỪNG (NOTIFICATION GÓC PHẢI MÀN HÌNH)
-- ============================================================================
local NotifyGui = Instance.new("ScreenGui", TargetGui)
NotifyGui.Name = "BananaNotifyScreen"

local NotifyFrame = Instance.new("Frame", NotifyGui)
NotifyFrame.Size = UDim2.new(0, 320, 0, 65)
NotifyFrame.Position = UDim2.new(1, 50, 0.8, 0) -- Nằm ngoài rìa phải
NotifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local NCorn = Instance.new("UICorner", NotifyFrame)
NCorn.CornerRadius = UDim.new(0, 8)
local NStroke = Instance.new("UIStroke", NotifyFrame)
NStroke.Color = _G.BananaPremium_Config.UiThemeColor
NStroke.Thickness = 1.5

local NotifyIcon = Instance.new("ImageLabel", NotifyFrame)
NotifyIcon.Size = UDim2.new(0, 35, 0, 35)
NotifyIcon.Position = UDim2.new(0, 12, 0, 15)
NotifyIcon.BackgroundTransparency = 1
NotifyIcon.Image = "rbxassetid://76998880438369"
Instance.new("UICorner", NotifyIcon).CornerRadius = UDim.new(1, 0)

local NotifyText = Instance.new("TextLabel", NotifyFrame)
NotifyText.Size = UDim2.new(1, -60, 1, 0)
NotifyText.Position = UDim2.new(0, 55, 0, 0)
NotifyText.Font = Enum.Font.GothamBold
NotifyText.Text = "Xin chào anh em đã đến với banana Hub Premium"
NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifyText.TextSize = 12
NotifyText.TextWrapped = true
NotifyText.TextXAlignment = Enum.TextXAlignment.Left
NotifyText.BackgroundTransparency = 1

-- Hiệu ứng trượt thông báo vào trong màn hình
TweenService:Create(NotifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -340, 0.8, 0)
}):Play()

-- Tự ẩn sau 4 giây
task.delay(4, function()
    local SlideOut = TweenService:Create(NotifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 50, 0.8, 0)
    })
    SlideOut:Play()
    SlideOut.Completed:Wait()
    NotifyGui:Destroy()
end)

-- ============================================================================
-- PHẦN 2: MÀN HÌNH CHỜ (LOADING SCREEN % SIÊU MƯỢT)
-- ============================================================================
local LoadingGui = Instance.new("ScreenGui", TargetGui)
LoadingGui.Name = "BananaLoading"

local LFrame = Instance.new("Frame", LoadingGui)
LFrame.Size = UDim2.new(0, 340, 0, 160)
LFrame.Position = UDim2.new(0.5, -170, 0.5, -80)
LFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local LCorner = Instance.new("UICorner", LFrame)
local LStroke = Instance.new("UIStroke", LFrame)
LStroke.Color = _G.BananaPremium_Config.UiThemeColor

local LTitle = Instance.new("TextLabel", LFrame)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.Position = UDim2.new(0, 0, 0, 15)
LTitle.Font = Enum.Font.GothamBold
LTitle.Text = "BANANA HUB PREMIUM"
LTitle.TextColor3 = _G.BananaPremium_Config.UiThemeColor
LTitle.TextSize = 22
LTitle.BackgroundTransparency = 1

local LBarBg = Instance.new("Frame", LFrame)
LBarBg.Size = UDim2.new(0.8, 0, 0, 6)
LBarBg.Position = UDim2.new(0.1, 0, 0.55, 0)
LBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local LBarFill = Instance.new("Frame", LBarBg)
LBarFill.Size = UDim2.new(0, 0, 1, 0)
LBarFill.BackgroundColor3 = _G.BananaPremium_Config.UiThemeColor

local LText = Instance.new("TextLabel", LFrame)
LText.Size = UDim2.new(1, 0, 0, 20)
LText.Position = UDim2.new(0, 0, 0.65, 5)
LText.Font = Enum.Font.Gotham
LText.Text = "Đang kết nối... 0%"
LText.TextColor3 = Color3.fromRGB(200, 200, 200)
LText.TextSize = 12
LText.BackgroundTransparency = 1

for i = 1, 100 do
    task.wait(0.012)
    LText.Text = "Đang giải mã 12 tính năng Premium... ("..i.."%)"
    LBarFill.Size = UDim2.new(i/100, 0, 1, 0)
end
LoadingGui:Destroy()

-- ============================================================================
-- PHẦN 3: GIAO DIỆN CHÍNH THIẾT KẾ THỦ CÔNG (MAIN MENU CYBER GUI)
-- ============================================================================
local ScreenGui = Instance.new("ScreenGui", TargetGui)
ScreenGui.Name = "BananaPremiumMenu_Cyber"

local MainMenuFrame = Instance.new("Frame", ScreenGui)
MainMenuFrame.Name = "MainMenuFrame"
MainMenuFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
MainMenuFrame.Position = UDim2.new(0.5, -290, 0.5, -200)
MainMenuFrame.Size = UDim2.new(0, 580, 0, 400)
MainMenuFrame.BorderSizePixel = 0
MainMenuFrame.ClipsDescendants = true

local M_Corner = Instance.new("UICorner", MainMenuFrame)
M_Corner.CornerRadius = UDim.new(0, 12)
local M_Stroke = Instance.new("UIStroke", MainMenuFrame)
M_Stroke.Color = Color3.fromRGB(40, 40, 40)
M_Stroke.Thickness = 1.2

-- Thanh điều khiển phía trên (Top Bar)
local TopBarFrame = Instance.new("Frame", MainMenuFrame)
TopBarFrame.Size = UDim2.new(1, 0, 0, 45)
TopBarFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBarFrame.BorderSizePixel = 0

local TopBarTitle = Instance.new("TextLabel", TopBarFrame)
TopBarTitle.BackgroundTransparency = 1
TopBarTitle.Position = UDim2.new(0, 15, 0, 0)
TopBarTitle.Size = UDim2.new(0.6, 0, 1, 0)
TopBarTitle.Font = Enum.Font.GothamBold
TopBarTitle.Text = "BANANA HUB PREMIUM V4 — CYBER"
TopBarTitle.TextColor3 = _G.BananaPremium_Config.UiThemeColor
TopBarTitle.TextSize = 13
TopBarTitle.TextXAlignment = Enum.TextXAlignment.Left

-- NÚT THU NHỎ (-) ĐỂ ĐÓNG/MỞ MENU NHANH TRÊN ĐIỆN THOẠI
local MinimizeButton = Instance.new("TextButton", TopBarFrame)
MinimizeButton.Size = UDim2.new(0, 32, 0, 32)
MinimizeButton.Position = UDim2.new(1, -45, 0, 6)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = _G.BananaPremium_Config.UiThemeColor
MinimizeButton.TextSize = 20
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

MinimizeButton.MouseButton1Click:Connect(function()
    _G.BananaPremium_Config.MenuMinimized = not _G.BananaPremium_Config.MenuMinimized
    if _G.BananaPremium_Config.MenuMinimized then
        TweenService:Create(MainMenuFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 580, 0, 45)}):Play()
        MinimizeButton.Text = "+"
    else
        TweenService:Create(MainMenuFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 580, 0, 400)}):Play()
        MinimizeButton.Text = "-"
    end
end)

-- Thanh Sidebar Bên Trái
local LeftSidebar = Instance.new("Frame", MainMenuFrame)
LeftSidebar.Size = UDim2.new(0, 175, 1, -45)
LeftSidebar.Position = UDim2.new(0, 0, 0, 45)
LeftSidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
LeftSidebar.BorderSizePixel = 0

-- KHU VỰC AVATAR THEO ID YÊU CẦU ĐỘC QUYỀN (ID: 76998880438369)
local UserFrame = Instance.new("Frame", LeftSidebar)
UserFrame.Size = UDim2.new(1, -20, 0, 55)
UserFrame.Position = UDim2.new(0, 10, 0, 15)
UserFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", UserFrame).CornerRadius = UDim.new(0, 8)

local AvatarImg = Instance.new("ImageLabel", UserFrame)
AvatarImg.Size = UDim2.new(0, 38, 0, 38)
AvatarImg.Position = UDim2.new(0, 8, 0, 8)
AvatarImg.Image = "rbxassetid://76998880438369" -- ID Avatar của bạn
AvatarImg.BackgroundTransparency = 1
Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1, 0)

local UName = Instance.new("TextLabel", UserFrame)
UName.Size = UDim2.new(1, -55, 0, 16)
UName.Position = UDim2.new(0, 52, 0, 10)
UName.Font = Enum.Font.GothamBold
UName.Text = "BANANA USER"
UName.TextColor3 = Color3.fromRGB(240, 240, 240)
UName.TextSize = 11
UName.TextXAlignment = Enum.TextXAlignment.Left
UName.BackgroundTransparency = 1

local UStatus = Instance.new("TextLabel", UserFrame)
UStatus.Size = UDim2.new(1, -55, 0, 16)
UStatus.Position = UDim2.new(0, 52, 0, 26)
UStatus.Font = Enum.Font.GothamSemibold
UStatus.Text = "Rank: Premium"
UStatus.TextColor3 = Color3.fromRGB(0, 215, 115)
UStatus.TextSize = 10
UStatus.TextXAlignment = Enum.TextXAlignment.Left
UStatus.BackgroundTransparency = 1

-- Khu vực chứa nút chuyển đổi Tab dạng cuộn
local TabScroll = Instance.new("ScrollingFrame", LeftSidebar)
TabScroll.Size = UDim2.new(1, -12, 1, -90)
TabScroll.Position = UDim2.new(0, 6, 0, 80)
TabScroll.BackgroundTransparency = 1
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 250)
TabScroll.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabScroll)
TabListLayout.Padding = UDim.new(0, 5)-- Vùng chứa các trang nội dung bên phảilocal PagesContainer = Instance.new("Frame", MainMenuFrame)PagesContainer.Size = UDim2.new(1, -195, 1, -65)PagesContainer.Position = UDim2.new(0, 185, 0, 55)PagesContainer.BackgroundTransparency = 1-- ============================================================================-- PHẦN 4: HÀM TẠO TAB VÀ Ô TÍNH NĂNG (XÂY DỰNG CHI TIẾT TỪNG DÒNG)-- ============================================================================local CurrentActiveTab = nillocal function BuildTab(name)local Btn = Instance.new("TextButton", TabScroll)Btn.Size = UDim2.new(1, 0, 0, 36)Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)Btn.Font = Enum.Font.GothamSemiboldBtn.Text = "   " .. nameBtn.TextColor3 = Color3.fromRGB(180, 180, 180)Btn.TextSize = 12Btn.TextXAlignment = Enum.TextXAlignment.LeftInstance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)local Page = Instance.new("ScrollingFrame", PagesContainer)Page.Size = UDim2.new(1, 0, 1, 0)Page.BackgroundTransparency = 1Page.CanvasSize = UDim2.new(0, 0, 0, 500)Page.ScrollBarThickness = 2Page.Visible = falselocal PList = Instance.new("UIListLayout", Page)PList.Padding = UDim.new(0, 6)Btn.MouseButton1Click:Connect(function()if CurrentActiveTab thenCurrentActiveTab.Page.Visible = falseCurrentActiveTab.Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)CurrentActiveTab.Btn.TextColor3 = Color3.fromRGB(180, 180, 180)endPage.Visible = trueBtn.BackgroundColor3 = _G.BananaPremium_Config.UiThemeColorBtn.TextColor3 = Color3.fromRGB(15, 15, 15)CurrentActiveTab = {Page = Page, Btn = Btn}end)return Page, Btnend-- Tạo 4 Trang Tablocal PageFarm, BtnFarm = BuildTab("Tự Động Farm")local PageV4, _ = BuildTab("Thức Tỉnh V4")local PageEsp, _ = BuildTab("Định Vị (ESP)")local PageMisc, _ = BuildTab("Hệ Thống Khác")-- Kích hoạt Tab đầu tiên mặc địnhPageFarm.Visible = trueBtnFarm.BackgroundColor3 = _G.BananaPremium_Config.UiThemeColorBtnFarm.TextColor3 = Color3.fromRGB(15, 15, 15)CurrentActiveTab = {Page = PageFarm, Btn = BtnFarm}-- Hàm tạo các ô Bật/Tắt tính năng viết tay tường minh (Toggles Box)local function CreateFeatureBox(targetPage, text, key, callback)local Box = Instance.new("Frame", targetPage)Box.Size = UDim2.new(1, -10, 0, 46)Box.BackgroundColor3 = Color3.fromRGB(22, 22, 22)Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)local BStroke = Instance.new("UIStroke", Box)BStroke.Color = Color3.fromRGB(32, 32, 32)local Label = Instance.new("TextLabel", Box)Label.Size = UDim2.new(0.75, 0, 1, 0)Label.Position = UDim2.new(0, 12, 0, 0)Label.Font = Enum.Font.GothamSemiboldLabel.Text = textLabel.TextColor3 = Color3.fromRGB(230, 230, 230)Label.TextSize = 13Label.TextXAlignment = Enum.TextXAlignment.LeftLabel.BackgroundTransparency = 1local Toggle = Instance.new("TextButton", Box)Toggle.Size = UDim2.new(0, 50, 0, 22)Toggle.Position = UDim2.new(0.82, 0, 0.25, 0)Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)Toggle.Font = Enum.Font.GothamBoldToggle.Text = "OFF"Toggle.TextColor3 = Color3.fromRGB(180, 180, 180)Toggle.TextSize = 11Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 5)local function ToggleVisual()if _G.BananaPremium_Config[key] thenTweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = _G.BananaPremium_Config.UiThemeColor, TextColor3 = Color3.fromRGB(15, 15, 15)}):Play()Toggle.Text = "ON"elseTweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50), TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()Toggle.Text = "OFF"endendToggleVisual()Toggle.MouseButton1Click:Connect(function()_G.BananaPremium_Config[key] = not _G.BananaPremium_Config[key]ToggleVisual()if callback then callback(_G.BananaPremium_Config[key]) endend)end-- ============================================================================-- PHẦN 5: KHỞI TẠO ĐẦY ĐỦ 12 Ô CHỨC NĂNG SCRIPT CHI TIẾT VÀO TỪNG TAB-- ============================================================================-- --- TAB 1: TỰ ĐỘNG FARM (CHẠY THỰC TẾ) ---CreateFeatureBox(PageFarm, "1. Tự Động Farm Level Siêu Tốc", "AutoFarmLevel")CreateFeatureBox(PageFarm, "2. Tự Động Gom Quái (Bring Mob)", "BringMobMode")CreateFeatureBox(PageFarm, "3. Bật Đánh Siêu Nhanh (Fast Attack)", "FastAttack")-- --- TAB 2: THỨC TỈNH V4 ---CreateFeatureBox(PageV4, "4. Tự Động Gạt Cần Khởi Động Đền Thờ", "PullLeverV4")CreateFeatureBox(PageV4, "5. Tự Động Up V4 Vượt Thử Thách", "AutoTrialV4")CreateFeatureBox(PageV4, "6. Tự Động Đi Tìm Nhặt Mảnh Bánh Răng", "FindGearV4")-- --- TAB 3: ĐỊNH VỊ (ESP) ---CreateFeatureBox(PageEsp, "7. Định Vị Khung Nhìn Người Chơi", "EspPlayer")CreateFeatureBox(PageEsp, "8. Định Vị Vị Trí Trái Ác Quỷ Rơi", "EspFruit")-- --- TAB 4: HỆ THỐNG KHÁC ---CreateFeatureBox(PageMisc, "9. Tự Động Cày Làm Q Đổi Tất Cả Tộc", "AutoAllRaces")CreateFeatureBox(PageMisc, "10. Tự Động Học Tất Cả Các Loại Võ", "AutoFightingStyle")CreateFeatureBox(PageMisc, "11. Tự Động Đi Nhặt Rương Kiếm Beli", "AutoChestBerry")CreateFeatureBox(PageMisc, "12. Tối Ưu Giảm Đồ Họa Chống Lag Máy", "FpsBoosterMode", function(v)Lighting.GlobalShadows = not vif v then settings().Rendering.QualityLevel = 1 endend)-- ============================================================================-- PHẦN 6: HỆ THỐNG KÉO THẢ MENU (DRAG GUI MECHANICS)-- ============================================================================local dragging, dragInput, dragStart, startPosTopBarFrame.InputBegan:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch thendragging = true dragStart = input.Position startPos = MainMenuFrame.Positioninput.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)endend)TopBarFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)UserInputService.InputChanged:Connect(function(input)if input == dragInput and dragging thenlocal delta = input.Position - dragStartMainMenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)endend)-- Phím tắt Left Control để ẩn/hiện nhanh menu trên bàn phímUserInputService.InputBegan:Connect(function(input, proc)if not proc and input.KeyCode == Enum.KeyCode.LeftControl then ScreenGui.Enabled = not ScreenGui.Enabled endend)-- ============================================================================-- PHẦN 7: LOGIC HOẠT ĐỘNG CHẠY NGẦM CỦA AUTO FARM VÀ GOM QUÁI-- ============================================================================task.spawn(function()while true dotask.wait()if _G.BananaPremium_Config.AutoFarmLevel thenpcall(function()local target = nilfor _, v in pairs(game.Workspace.Enemies:GetChildren()) doif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 thentarget = v breakendendif target then-- Gom quái nếu bật Bring Mobif _G.BananaPremium_Config.BringMobMode thenfor _, enemy in pairs(game.Workspace.Enemies:GetChildren()) doif enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 thenif (enemy.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude < 250 thenenemy.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrameenemy.HumanoidRootPart.CanCollide = falseendendendend-- Di chuyển nhân vật lên đầu quái để chém không mất máuLocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)-- Tự động click đánh quáiVirtualUser:CaptureController()VirtualUser:ClickButton1(Vector2.new(850, 520))endend)endendend)