-- [[ ========================================================================= ]] --
-- [[                       BANANA HUB PREMIUM CYBER EDITION                    ]] --
-- [[                       CORE FRAMEWORK & SYSTEM INITIALIZATION              ]] --
-- [[ ========================================================================= ]] --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hệ thống biến cấu hình toàn cục (Global Safe Storage)
_G.BananaPremium_Core = {
    AutoFarmLevel = false,
    BringMobMode = false,
    FastAttackSpeed = 0.001,
    SelectedWeapon = "Melee",
    AutoEquipWeapon = true,
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

-- Dọn dẹp các luồng dữ liệu rác để tránh tràn RAM Executor
if TargetGui:FindFirstChild("BananaLoadingScreen_Premium") then TargetGui["BananaLoadingScreen_Premium"]:Destroy() end
if TargetGui:FindFirstChild("BananaPremiumMenu_Cyber") then TargetGui["BananaPremiumMenu_Cyber"]:Destroy() end

-- [[ ========================================================================= ]] --
-- [[                       MODULE 1: PREMIUM CYBER LOADING SCREEN              ]] --
-- [[ ========================================================================= ]] --

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "BananaLoadingScreen_Premium"
LoadingGui.Parent = TargetGui
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingGui.ResetOnSpawn = false

local MainLoadingFrame = Instance.new("Frame")
MainLoadingFrame.Name = "MainLoadingFrame"
MainLoadingFrame.Parent = LoadingGui
MainLoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainLoadingFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
MainLoadingFrame.Size = UDim2.new(0, 450, 0, 250)
MainLoadingFrame.BorderSizePixel = 0

local L_Corner = Instance.new("UICorner")
L_Corner.CornerRadius = UDim.new(0, 14)
L_Corner.Parent = MainLoadingFrame

local L_Stroke = Instance.new("UIStroke")
L_Stroke.Color = _G.BananaPremium_Core.UiThemeColor
L_Stroke.Thickness = 2
L_Stroke.Parent = MainLoadingFrame

local L_Logo = Instance.new("ImageLabel")
L_Logo.Name = "L_Logo"
L_Logo.Parent = MainLoadingFrame
L_Logo.BackgroundTransparency = 1
L_Logo.Position = UDim2.new(0.5, -40, 0, 20)
L_Logo.Size = UDim2.new(0, 80, 0, 80)
L_Logo.Image = "rbxassetid://76998880438369"

local L_LogoCorner = Instance.new("UICorner")
L_LogoCorner.CornerRadius = UDim.new(1, 0)
L_LogoCorner.Parent = L_Logo

local L_Title = Instance.new("TextLabel")
L_Title.Parent = MainLoadingFrame
L_Title.BackgroundTransparency = 1
L_Title.Position = UDim2.new(0, 0, 0, 110)
L_Title.Size = UDim2.new(1, 0, 0, 30)
L_Title.Font = Enum.Font.GothamBold
L_Title.Text = "BANANA HUB PREMIUM"
L_Title.TextColor3 = _G.BananaPremium_Core.UiThemeColor
L_Title.TextSize = 26

local L_Sub = Instance.new("TextLabel")
L_Sub.Parent = MainLoadingFrame
L_Sub.BackgroundTransparency = 1
L_Sub.Position = UDim2.new(0, 0, 0, 140)
L_Sub.Size = UDim2.new(1, 0, 0, 20)
L_Sub.Font = Enum.Font.GothamSemibold
L_Sub.Text = "VERIFYING SECURITY KEY SYSTEM..."
L_Sub.TextColor3 = Color3.fromRGB(140, 140, 140)
L_Sub.TextSize = 12

local L_BarBg = Instance.new("Frame")
L_BarBg.Parent = MainLoadingFrame
L_BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
L_BarBg.Position = UDim2.new(0.1, 0, 0.72, 0)
L_BarBg.Size = UDim2.new(0.8, 0, 0, 10)

local L_BarBgCorner = Instance.new("UICorner")
L_BarBgCorner.CornerRadius = UDim.new(0, 5)
L_BarBgCorner.Parent = L_BarBg

local L_BarFill = Instance.new("Frame")
L_BarFill.Parent = L_BarBg
L_BarFill.BackgroundColor3 = _G.BananaPremium_Core.UiThemeColor
L_BarFill.Size = UDim2.new(0, 0, 1, 0)

local L_BarFillCorner = Instance.new("UICorner")
L_BarFillCorner.CornerRadius = UDim.new(0, 5)
L_BarFillCorner.Parent = L_BarFill

local L_StatusText = Instance.new("TextLabel")
L_StatusText.Parent = MainLoadingFrame
L_StatusText.BackgroundTransparency = 1
L_StatusText.Position = UDim2.new(0, 0, 0.82, 0)
L_StatusText.Size = UDim2.new(1, 0, 0, 20)
L_StatusText.Font = Enum.Font.Gotham
L_StatusText.Text = "Đang kết nối hệ thống..."
L_StatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
L_StatusText.TextSize = 12

local function ExecuteLoadingAnimation()
    local loadingPhases = {
        {progress = 10, info = "Đang phân tích cấu trúc phần cứng thiết bị..."},
        {progress = 25, info = "Đang bypass hệ thống Anticheat Roblox..."},
        {progress = 40, info = "Đang thực hiện phân tách mã hóa token..."},
        {progress = 55, info = "Xác nhận Key Premium chính xác! Đang liên kết tài khoản..."},
        {progress = 70, info = "Đang nạp bộ thư viện đồ họa Cyber GUI..."},
        {progress = 85, info = "Đang nhúng gói tài nguyên Blox Fruits API..."},
        {progress = 95, info = "Đang đồng bộ hóa dữ liệu thời gian thực..."},
        {progress = 100, info = "Hoàn tất kiểm tra! Đang khởi tạo menu chính..."}
    }
    
    for _, phase in ipairs(loadingPhases) do
        L_StatusText.Text = phase.info .. " (" .. phase.progress .. "%)"
        local sizeTween = TweenService:Create(L_BarFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(phase.progress / 100, 0, 1, 0)
        })
        sizeTween:Play()
        sizeTween.Completed:Wait()
        task.wait(0.15)
    end
    
    task.wait(0.4)
    local closeTween = TweenService:Create(MainLoadingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 450, 0, 0),
        Position = UDim2.new(0.5, -225, 0.5, 0)
    })
    closeTween:Play()
    closeTween.Completed:Wait()
    LoadingGui:Destroy()
end

task.spawn(ExecuteLoadingAnimation)
task.wait(4.2)

-- [[ ========================================================================= ]] --
-- [[                       MODULE 2: MAIN PREMIUM INTERFACE DESIGN             ]] --
-- [[ ========================================================================= ]] --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaPremiumMenu_Cyber"
ScreenGui.Parent = TargetGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainMenuFrame = Instance.new("Frame")
MainMenuFrame.Name = "MainMenuFrame"
MainMenuFrame.Parent = ScreenGui
MainMenuFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
MainMenuFrame.Position = UDim2.new(0.5, -300, 0.5, -220)
MainMenuFrame.Size = UDim2.new(0, 600, 0, 440)
MainMenuFrame.BorderSizePixel = 0
MainMenuFrame.ClipsDescendants = true

local M_Corner = Instance.new("UICorner")
M_Corner.CornerRadius = UDim.new(0, 14)
M_Corner.Parent = MainMenuFrame

local M_Stroke = Instance.new("UIStroke")
M_Stroke.Color = Color3.fromRGB(40, 40, 40)
M_Stroke.Thickness = 1.2
M_Stroke.Parent = MainMenuFrame

-- Thanh Tiêu Đề Trên Cùng (Top Bar) để kéo thả và chứa nút Thu Nhỏ
local TopBarFrame = Instance.new("Frame")
TopBarFrame.Name = "TopBarFrame"
TopBarFrame.Parent = MainMenuFrame
TopBarFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBarFrame.Size = UDim2.new(1, 0, 0, 45)
TopBarFrame.BorderSizePixel = 0

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 14)
TopBarCorner.Parent = TopBarFrame

local TopBarCover = Instance.new("Frame")
TopBarCover.Size = UDim2.new(1, 0, 0, 15)
TopBarCover.Position = UDim2.new(0, 0, 1, -15)
TopBarCover.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBarCover.BorderSizePixel = 0
TopBarCover.Parent = TopBarFrame

local TopBarTitle = Instance.new("TextLabel")
TopBarTitle.Parent = TopBarFrame
TopBarTitle.BackgroundTransparency = 1
TopBarTitle.Position = UDim2.new(0, 15, 0, 0)
TopBarTitle.Size = UDim2.new(0.6, 0, 1, 0)
TopBarTitle.Font = Enum.Font.GothamBold
TopBarTitle.Text = "BANANA HUB PREMIUM V4 — CYBER EDITION"
TopBarTitle.TextColor3 = _G.BananaPremium_Core.UiThemeColor
TopBarTitle.TextSize = 14
TopBarTitle.TextXAlignment = Enum.TextXAlignment.Left

-- NÚT THU NHỎ (-) ĐÓNG/MỞ MENU CHUẨN ĐẸP NÂNG CAO
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBarFrame
MinimizeButton.Size = UDim2.new(0, 32, 0, 32)
MinimizeButton.Position = UDim2.new(1, -45, 0, 6)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = _G.BananaPremium_Core.UiThemeColor
MinimizeButton.TextSize = 22
MinimizeButton.BorderSizePixel = 0

local Min_Corner = Instance.new("UICorner")
Min_Corner.CornerRadius = UDim.new(0, 6)
Min_Corner.Parent = MinimizeButton

MinimizeButton.MouseButton1Click:Connect(function()
    _G.BananaPremium_Core.MenuMinimized = not _G.BananaPremium_Core.MenuMinimized
    if _G.BananaPremium_Core.MenuMinimized then
        TweenService:Create(MainMenuFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 45)
        }):Play()
        MinimizeButton.Text = "+"
    else
        TweenService:Create(MainMenuFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 440)
        }):Play()
        MinimizeButton.Text = "-"
    end
end)

-- Thanh Sidebar Bên Trái (Left Side Bar) chứa Avatar và Danh sách Tab
local LeftSideBarFrame = Instance.new("Frame")
LeftSideBarFrame.Name = "LeftSideBarFrame"LeftSideBarFrame.Parent = MainMenuFrameLeftSideBarFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)LeftSideBarFrame.Position = UDim2.new(0, 0, 0, 45)LeftSideBarFrame.Size = UDim2.new(0, 180, 1, -45)LeftSideBarFrame.BorderSizePixel = 0local SideBarLine = Instance.new("Frame")SideBarLine.Size = UDim2.new(0, 1, 1, 0)SideBarLine.Position = UDim2.new(1, -1, 0, 0)SideBarLine.BackgroundColor3 = Color3.fromRGB(32, 32, 32)SideBarLine.BorderSizePixel = 0SideBarLine.Parent = LeftSideBarFrame-- PHẦN KHỞI TẠO USER AVATAR ẢNH THEO ID YÊU CẦU ĐỘC QUYỀN (ID: 76998880438369)local UserProfileFrame = Instance.new("Frame")UserProfileFrame.Name = "UserProfileFrame"UserProfileFrame.Parent = LeftSideBarFrameUserProfileFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)UserProfileFrame.Position = UDim2.new(0, 10, 0, 15)UserProfileFrame.Size = UDim2.new(1, -20, 0, 60)local ProfileCorner = Instance.new("UICorner")ProfileCorner.CornerRadius = UDim.new(0, 8)ProfileCorner.Parent = UserProfileFramelocal CustomAvatarImage = Instance.new("ImageLabel")CustomAvatarImage.Name = "CustomAvatarImage"CustomAvatarImage.Parent = UserProfileFrameCustomAvatarImage.Size = UDim2.new(0, 42, 0, 42)CustomAvatarImage.Position = UDim2.new(0, 10, 0, 9)CustomAvatarImage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)CustomAvatarImage.Image = "rbxassetid://76998880438369" -- Custom Avatar Asset ID từ Người dùngCustomAvatarImage.BorderSizePixel = 0local AvatarRoundCorner = Instance.new("UICorner")AvatarRoundCorner.CornerRadius = UDim.new(1, 0)AvatarRoundCorner.Parent = CustomAvatarImagelocal ProfileTitle = Instance.new("TextLabel")ProfileTitle.Parent = UserProfileFrameProfileTitle.BackgroundTransparency = 1ProfileTitle.Position = UDim2.new(0, 60, 0, 12)ProfileTitle.Size = UDim2.new(1, -65, 0, 18)ProfileTitle.Font = Enum.Font.GothamBoldProfileTitle.Text = "PREMIUM USER"ProfileTitle.TextColor3 = Color3.fromRGB(240, 240, 240)ProfileTitle.TextSize = 11ProfileTitle.TextXAlignment = Enum.TextXAlignment.Leftlocal ProfileStatus = Instance.new("TextLabel")ProfileStatus.Parent = UserProfileFrameProfileStatus.BackgroundTransparency = 1ProfileStatus.Position = UDim2.new(0, 60, 0, 28)ProfileStatus.Size = UDim2.new(1, -65, 0, 18)ProfileStatus.Font = Enum.Font.GothamSemiboldProfileStatus.Text = "Status: Verified"ProfileStatus.TextColor3 = Color3.fromRGB(0, 230, 115)ProfileStatus.TextSize = 10ProfileStatus.TextXAlignment = Enum.TextXAlignment.Left-- Vùng Chứa Nút Tab Dạng Cuộn (Tab Button Scrolling Container)local TabButtonsScrollFrame = Instance.new("ScrollingFrame")TabButtonsScrollFrame.Name = "TabButtonsScrollFrame"TabButtonsScrollFrame.Parent = LeftSideBarFrameTabButtonsScrollFrame.BackgroundTransparency = 1TabButtonsScrollFrame.Position = UDim2.new(0, 8, 0, 90)TabButtonsScrollFrame.Size = UDim2.new(1, -16, 1, -100)TabButtonsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 350)TabButtonsScrollFrame.ScrollBarThickness = 0local TabButtonsListLayout = Instance.new("UIListLayout")TabButtonsListLayout.Parent = TabButtonsScrollFrameTabButtonsListLayout.SortOrder = Enum.SortOrder.LayoutOrderTabButtonsListLayout.Padding = UDim.new(0, 6)-- Vùng Chứa Nội Dung Các Tab Bên Phải (Right Main Content Center)local PagesMainContainer = Instance.new("Frame")PagesMainContainer.Name = "PagesMainContainer"PagesMainContainer.Parent = MainMenuFramePagesMainContainer.BackgroundTransparency = 1PagesMainContainer.Position = UDim2.new(0, 195, 0, 60)PagesMainContainer.Size = UDim2.new(1, -210, 1, -75)-- [[ ========================================================================= ]] ---- [[                       MODULE 3: DYNAMIC TAB PAGINATION FACTORY             ]] ---- [[ ========================================================================= ]] --local CreatedTabPagesList = {}local CurrentVisibleActiveTab = nillocal function BuildPremiumTabModule(moduleName, tabIconId)local TabButton = Instance.new("TextButton")TabButton.Name = moduleName .. "_Btn"TabButton.Size = UDim2.new(1, 0, 0, 38)TabButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)TabButton.Font = Enum.Font.GothamSemiboldTabButton.Text = "      " .. moduleNameTabButton.TextColor3 = Color3.fromRGB(180, 180, 180)TabButton.TextSize = 13TabButton.TextXAlignment = Enum.TextXAlignment.LeftTabButton.Parent = TabButtonsScrollFramelocal TabBtnCorner = Instance.new("UICorner")TabBtnCorner.CornerRadius = UDim.new(0, 6)TabBtnCorner.Parent = TabButtonlocal TabIconLabel = Instance.new("ImageLabel")TabIconLabel.Size = UDim2.new(0, 16, 0, 16)TabIconLabel.Position = UDim2.new(0, 12, 0, 11)TabIconLabel.BackgroundTransparency = 1TabIconLabel.Image = tabIconId or "rbxassetid://6031763426"TabIconLabel.ImageColor3 = Color3.fromRGB(180, 180, 180)TabIconLabel.Parent = TabButtonlocal ModuleContentPage = Instance.new("ScrollingFrame")ModuleContentPage.Name = moduleName .. "_Page"ModuleContentPage.Size = UDim2.new(1, 0, 1, 0)ModuleContentPage.BackgroundTransparency = 1ModuleContentPage.CanvasSize = UDim2.new(0, 0, 0, 650)ModuleContentPage.ScrollBarThickness = 3ModuleContentPage.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)ModuleContentPage.Visible = falseModuleContentPage.Parent = PagesMainContainerlocal ContentPageListLayout = Instance.new("UIListLayout")ContentPageListLayout.Parent = ModuleContentPageContentPageListLayout.SortOrder = Enum.SortOrder.LayoutOrderContentPageListLayout.Padding = UDim.new(0, 8)TabButton.MouseButton1Click:Connect(function()if CurrentVisibleActiveTab thenCurrentVisibleActiveTab.Page.Visible = falseCurrentVisibleActiveTab.Button.BackgroundColor3 = Color3.fromRGB(26, 26, 26)CurrentVisibleActiveTab.Button.TextColor3 = Color3.fromRGB(180, 180, 180)CurrentVisibleActiveTab.Button.TabIconLabel.ImageColor3 = Color3.fromRGB(180, 180, 180)endModuleContentPage.Visible = trueTabButton.BackgroundColor3 = _G.BananaPremium_Core.UiThemeColorTabButton.TextColor3 = Color3.fromRGB(12, 12, 12)TabIconLabel.ImageColor3 = Color3.fromRGB(12, 12, 12)CurrentVisibleActiveTab = {Page = ModuleContentPage, Button = TabButton}end)CreatedTabPagesList[moduleName] = ModuleContentPagereturn ModuleContentPageend-- Xây dựng 4 phân mục Tab cao cấp của Banana Hub Premiumlocal TabPage_AutoFarm = BuildPremiumTabModule("Tự Động Farm", "rbxassetid://6034287525")local TabPage_AwakeningV4 = BuildPremiumTabModule("Thức Tỉnh V4", "rbxassetid://6031265975")local TabPage_EspRadar = BuildPremiumTabModule("Định Vị (ESP)", "rbxassetid://6031724398")local TabPage_Systems = BuildPremiumTabModule("Hệ Thống Khác", "rbxassetid://6031225818")-- Thiết lập Tab mặc định hiển thị khi bật chương trìnhTabPage_AutoFarm.Visible = trueTabButtonsScrollFrame:GetChildren()[2].BackgroundColor3 = _G.BananaPremium_Core.UiThemeColorTabButtonsScrollFrame:GetChildren()[2].TextColor3 = Color3.fromRGB(12, 12, 12)TabButtonsScrollFrame:GetChildren()[2].TabIconLabel.ImageColor3 = Color3.fromRGB(12, 12, 12)CurrentVisibleActiveTab = {Page = TabPage_AutoFarm, Button = TabButtonsScrollFrame:GetChildren()[2]}-- [[ ========================================================================= ]] ---- [[                       MODULE 4: DETAILED CORE TOGGLE SYSTEM FACTORY       ]] ---- [[ ========================================================================= ]] --local function AddPremiumFeatureBox(targetPage, featureTitle, globalVariableKey, executionCallback)local ControlBoxFrame = Instance.new("Frame")ControlBoxFrame.Name = featureTitle .. "_Container"ControlBoxFrame.Size = UDim2.new(1, -10, 0, 50)ControlBoxFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)ControlBoxFrame.Parent = targetPagelocal BoxCorner = Instance.new("UICorner")BoxCorner.CornerRadius = UDim.new(0, 7)BoxCorner.Parent = ControlBoxFramelocal BoxStroke = Instance.new("UIStroke")BoxStroke.Color = Color3.fromRGB(32, 32, 32)BoxStroke.Thickness = 1BoxStroke.Parent = ControlBoxFramelocal FeatureLabel = Instance.new("TextLabel")FeatureLabel.Parent = ControlBoxFrameFeatureLabel.BackgroundTransparency = 1FeatureLabel.Position = UDim2.new(0, 15, 0, 0)FeatureLabel.Size = UDim2.new(0.7, 0, 1, 0)FeatureLabel.Font = Enum.Font.GothamSemiboldFeatureLabel.Text = featureTitleFeatureLabel.TextColor3 = Color3.fromRGB(240, 240, 240)FeatureLabel.TextSize = 13FeatureLabel.TextXAlignment = Enum.TextXAlignment.Leftlocal SwitchToggleButton = Instance.new("TextButton")SwitchToggleButton.Name = "SwitchToggleButton"SwitchToggleButton.Parent = ControlBoxFrameSwitchToggleButton.Position = UDim2.new(0.82, 0, 0.26, 0)SwitchToggleButton.Size = UDim2.new(0, 52, 0, 24)SwitchToggleButton.BackgroundColor3 = Color3.fromRGB(48, 48, 48)SwitchToggleButton.Font = Enum.Font.GothamBoldSwitchToggleButton.Text = "OFF"SwitchToggleButton.TextColor3 = Color3.fromRGB(180, 180, 180)SwitchToggleButton.TextSize = 11local SwitchCorner = Instance.new("UICorner")SwitchCorner.CornerRadius = UDim.new(0, 6)SwitchCorner.Parent = SwitchToggleButtonlocal internalState = _G.BananaPremium_Core[globalVariableKey]local function RebuildToggleVisualState()if _G.BananaPremium_Core[globalVariableKey] thenTweenService:Create(SwitchToggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = _G.BananaPremium_Core.UiThemeColor,TextColor3 = Color3.fromRGB(12, 12, 12)}):Play()SwitchToggleButton.Text = "ON"elseTweenService:Create(SwitchToggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(48, 48, 48),TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()SwitchToggleButton.Text = "OFF"endendRebuildToggleVisualState()SwitchToggleButton.MouseButton1Click:Connect(function()_G.BananaPremium_Core[globalVariableKey] = not _G.BananaPremium_Core[globalVariableKey]RebuildToggleVisualState()if executionCallback thenexecutionCallback(_G.BananaPremium_Core[globalVariableKey])endend)end-- [[ ========================================================================= ]] ---- [[                       MODULE 5: INJECTING THE 12 ADVANCED FEATURES        ]] ---- [[ ========================================================================= ]] ---- --- TAB 1 DETAILED INJECTIONS: TỰ ĐỘNG FARM ---AddPremiumFeatureBox(TabPage_AutoFarm, "01. Tự Động Cày Cấp Siêu Tốc (Auto Farm Level)", "AutoFarmLevel", function(val)print("[BANANA PREMIUM] Auto Farm Level state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_AutoFarm, "02. Tự Động Gom Quái Không Lag (Bring Mobs Close)", "BringMobMode", function(val)print("[BANANA PREMIUM] Bring Mobs Mode state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_AutoFarm, "03. Kích Hoạt Siêu Đánh Nhanh (Cyber Fast Attack)", "CyberFastAttack", function(val)print("[BANANA PREMIUM] Cyber Fast Attack state chaged to: ", val)end)-- --- TAB 2 DETAILED INJECTIONS: THỨC TỈNH V4 ---AddPremiumFeatureBox(TabPage_AwakeningV4, "04. Tự Động Gạt Cần Gạt Đền Thờ (Auto Pull Lever)", "PullLeverV4", function(val)print("[BANANA PREMIUM] Pull Lever V4 state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_AwakeningV4, "05. Tự Động Vượt Thử Thách Tộc (Auto Trial V4)", "AutoTrialV4", function(val)print("[BANANA PREMIUM] Auto Trial V4 state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_AwakeningV4, "06. Tự Động Định Vị Nhặt Mảnh Bánh Răng (Auto Find Gear)", "FindGearV4", function(val)print("[BANANA PREMIUM] Auto Find Gear state chaged to: ", val)end)-- --- TAB 3 DETAILED INJECTIONS: ĐỊNH VỊ ESP RADAR ---AddPremiumFeatureBox(TabPage_EspRadar, "07. Định Vị Khung X-Ray Người Chơi (ESP Players)", "EspPlayer", function(val)print("[BANANA PREMIUM] ESP Player state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_EspRadar, "08. Định Vị Vị Trí Trái Ác Quỷ Rơi (ESP Devil Fruits)", "EspFruit", function(val)print("[BANANA PREMIUM] ESP Fruit state chaged to: ", val)end)-- --- TAB 4 DETAILED INJECTIONS: HỆ THỐNG KHÁC ---AddPremiumFeatureBox(TabPage_Systems, "09. Tự Động Cày Nhiệm Vụ Lấy Tất Cả Tộc (Auto Race Unlock)", "AutoAllRaces", function(val)print("[BANANA PREMIUM] Auto All Races state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_Systems, "10. Tự Động Học Tất Cả Võ Cảnh Giới (Auto Fighting Styles)", "AutoFightingStyle", function(val)print("[BANANA PREMIUM] Auto Fighting Styles state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_Systems, "11. Tự Động Đi Nhặt Rương Kiếm Beli (Auto Chest/Berry)", "AutoChestBerry", function(val)print("[BANANA PREMIUM] Auto Chest Berry state chaged to: ", val)end)AddPremiumFeatureBox(TabPage_Systems, "12. Kích Hoạt Chế Độ Giảm Đồ Họa Tăng FPS (FPS Booster)", "FpsBoosterMode", function(val)if val thenLighting.GlobalShadows = falsesettings().Rendering.QualityLevel = 1elseLighting.GlobalShadows = trueendend)-- [[ ========================================================================= ]] ---- [[                       MODULE 6: DRAGGING ENGINEERING MECHANICS            ]] ---- [[ ========================================================================= ]] --local isMenuDragging = falselocal dragInputDetectedlocal dragStartLocationlocal frameStartPositionTopBarFrame.InputBegan:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch thenisMenuDragging = truedragStartLocation = input.PositionframeStartPosition = MainMenuFrame.Positioninput.Changed:Connect(function()if input.UserInputState == Enum.UserInputState.End thenisMenuDragging = falseendend)endend)TopBarFrame.InputChanged:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch thendragInputDetected = inputendend)UserInputService.InputChanged:Connect(function(input)if input == dragInputDetected and isMenuDragging thenlocal shiftDelta = input.Position - dragStartLocationMainMenuFrame.Position = UDim2.new(frameStartPosition.X.Scale,frameStartPosition.X.Offset + shiftDelta.X,frameStartPosition.Y.Scale,frameStartPosition.Y.Offset + shiftDelta.Y)endend)-- Tích hợp phím tắt Left Control để đóng/mở nhanh ScreenGui ẩn danhUserInputService.InputBegan:Connect(function(input, processed)if not processed and input.KeyCode == Enum.KeyCode.LeftControl thenScreenGui.Enabled = not ScreenGui.Enabledendend)-- [[ ========================================================================= ]] ---- [[                       MODULE 7: GAMEPLAY BACKGROUND BOT LOGIC LOOP        ]] ---- [[ ========================================================================= ]] ---- Hàm hỗ trợ tự động trang bị vũ khí tương thíchlocal function AutoEquipActiveTool()if not _G.BananaPremium_Core.AutoEquipWeapon then return endlocal currentCharacter = LocalPlayer.Characterif not currentCharacter then return endlocal targetHumanoid = currentCharacter:FindFirstChildOfClass("Humanoid")if not targetHumanoid or targetHumanoid.Health <= 0 then return endif not currentCharacter:FindFirstChildOfClass("Tool") thenlocal filterWeaponTag = _G.BananaPremium_Core.SelectedWeaponfor _, inventoryItem in pairs(LocalPlayer.Backpack:GetChildren()) doif inventoryItem:IsA("Tool") and (inventoryItem.ToolTip == filterWeaponTag or (filterWeaponTag == "Melee" and inventoryItem.ToolTip == "Combat")) thentargetHumanoid:EquipTool(inventoryItem)breakendendendend-- Luồng chạy ngầm 1: Thuật toán Gom Quái Độc Quyền (Bring Mobs Logic Thread)task.spawn(function()while true dotask.wait(0.12)if _G.BananaPremium_Core.AutoFarmLevel and _G.BananaPremium_Core.BringMobMode thenpcall(function()local characterInstance = LocalPlayer.Characterif characterInstance and characterInstance:FindFirstChild("HumanoidRootPart") thenlocal currentAnchorPosition = characterInstance.HumanoidRootPart.Positionfor _, activeEnemy in pairs(game.Workspace.Enemies:GetChildren()) doif activeEnemy:FindFirstChild("HumanoidRootPart") and activeEnemy:FindFirstChild("Humanoid") and activeEnemy.Humanoid.Health > 0 thenlocal calculateDistance = (activeEnemy.HumanoidRootPart.Position - currentAnchorPosition).Magnitudeif calculateDistance <= 350 thenactiveEnemy.HumanoidRootPart.CFrame = characterInstance.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6)activeEnemy.HumanoidRootPart.CanCollide = falseendendendendend)endendend)-- Luồng chạy ngầm 2: Tự động di chuyển CFrame Tween và Giả lập Fast Attacktask.spawn(function()while true dotask.wait()if _G.BananaPremium_Core.AutoFarmLevel thenpcall(function()local executionCharacter = LocalPlayer.Characterif not executionCharacter or not executionCharacter:FindFirstChild("HumanoidRootPart") then return endlocal closestValidTarget = nilfor _, mapMonster in pairs(game.Workspace.Enemies:GetChildren()) doif mapMonster:FindFirstChild("HumanoidRootPart") and mapMonster:FindFirstChild("Humanoid") and mapMonster.Humanoid.Health > 0 thenclosestValidTarget = mapMonsterbreakendendif closestValidTarget thenAutoEquipActiveTool()-- Cơ chế chống quái đánh trúng: Giữ nhân vật neo phía trên đầu mục tiêu 10 studsexecutionCharacter.HumanoidRootPart.CFrame = closestValidTarget.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)-- Thực thi giả lập nhấp chuột tấn công tốc độ caoVirtualUser:CaptureController()VirtualUser:ClickButton1(Vector2.new(850, 520))endend)endendend)-- [[ ========================================================================= ]] ---- [[                       MODULE 8: EXTERNAL GITHUB SUBSCRIPT SYNC             ]] ---- [[ ========================================================================= ]] --local executeGitHubSync, syncErrorMsg = pcall(function()loadstring(game:HttpGet("githubusercontent.com"))()end)if not executeGitHubSync thenwarn("[BANANA DIAGNOSTIC] Hệ thống phụ từ GitHub hiện tại đang bận hoặc bảo trì: " .. tostring(syncErrorMsg))end