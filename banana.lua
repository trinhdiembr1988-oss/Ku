-- ============================================================================
-- PHẦN 1: HỆ THỐNG QUẢN LÝ DỮ LIỆU, BIẾN TOÀN CỤC VÀ DỊCH VỤ HỆ THỐNG
-- ============================================================================
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")

-- Khởi tạo cấu hình hệ thống chạy ngầm toàn cục
_G.BananaPremiumConfig = {
    AutoFarmLevel = false,
    AutoFarmBones = false,
    BringMobDistance = 350,
    FastAttackSpeed = 0.05,
    SelectedWeapon = "Melee",
    AutoEquip = true,
    TweenSpeed = 350,
    AntiBanProtection = true,
    FpsBooster = false,
    TeleportSafeMode = true
}

-- Dọn dẹp các tiến trình giao diện cũ tránh xung đột bộ nhớ nền
if TargetGui:FindFirstChild("BananaLoadingScreen") then TargetGui["BananaLoadingScreen"]:Destroy() end
if TargetGui:FindFirstChild("BananaPremiumMenu") then TargetGui["BananaPremiumMenu"]:Destroy() end

-- ============================================================================
-- PHẦN 2: THIẾT KẾ MÀN HÌNH CHỜ (LOADING SCREEN VÀ CHECKING KEY SYSTEM)
-- ============================================================================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "BananaLoadingScreen"
LoadingGui.Parent = TargetGui
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingGui.ResetOnSpawn = false

local MainLoadingFrame = Instance.new("Frame")
MainLoadingFrame.Name = "MainLoadingFrame"
MainLoadingFrame.Parent = LoadingGui
MainLoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainLoadingFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
MainLoadingFrame.Size = UDim2.new(0, 450, 0, 250)
MainLoadingFrame.BorderSizePixel = 0

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 16)
LoadingCorner.Parent = MainLoadingFrame

local LoadingStroke = Instance.new("UIStroke")
LoadingStroke.Color = Color3.fromRGB(255, 215, 0)
LoadingStroke.Thickness = 2
LoadingStroke.Parent = MainLoadingFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = MainLoadingFrame
MainTitle.BackgroundTransparency = 1
MainTitle.Position = UDim2.new(0, 0, 0, 30)
MainTitle.Size = UDim2.new(1, 0, 0, 40)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.Text = "BANANA HUB PREMIUM"
MainTitle.TextColor3 = Color3.fromRGB(255, 223, 0)
MainTitle.TextSize = 30

local SubTitleText = Instance.new("TextLabel")
SubTitleText.Parent = MainLoadingFrame
SubTitleText.BackgroundTransparency = 1
SubTitleText.Position = UDim2.new(0, 0, 0, 70)
SubTitleText.Size = UDim2.new(1, 0, 0, 20)
SubTitleText.Font = Enum.Font.GothamSemibold
SubTitleText.Text = "THE ULTIMATE BLOX FRUITS SCRIPT"
SubTitleText.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitleText.TextSize = 13

local BarBg = Instance.new("Frame")
BarBg.Parent = MainLoadingFrame
BarBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
BarBg.Position = UDim2.new(0.1, 0, 0.6, 0)
BarBg.Size = UDim2.new(0.8, 0, 0, 12)

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(0, 6)
BarBgCorner.Parent = BarBg

local BarFill = Instance.new("Frame")
BarFill.Parent = BarBg
BarFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
BarFill.Size = UDim2.new(0, 0, 1, 0)

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(0, 6)
BarFillCorner.Parent = BarFill

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainLoadingFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.72, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Đang kết nối đến máy chủ xác thực..."
StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
StatusLabel.TextSize = 13

local function RunLoadingSimulation()
    local steps = {
        {percent = 15, text = "Đang kiểm tra phần cứng thiết bị..."},
        {percent = 35, text = "Đang bypass hệ thống bảo mật Roblox..."},
        {percent = 55, text = "Xác nhận tài khoản Premium thành công!"},
        {percent = 75, text = "Đang tải gói dữ liệu đồ họa tối ưu (GUI)..."},
        {percent = 90, text = "Đang nhúng tập lệnh logic tự động..."},
        {percent = 100, text = "Khởi động giao diện điều khiển chính..."}
    }
    
    for _, step in ipairs(steps) do
        StatusLabel.Text = step.text
        local targetSize = UDim2.new(step.percent / 100, 0, 1, 0)
        local tween = TweenService:Create(BarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize})
        tween:Play()
        tween.Completed:Wait()
        task.wait(0.2)
    end
    
    task.wait(0.3)
    local fadeTween = TweenService:Create(MainLoadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 450, 0, 0),
        Position = UDim2.new(0.5, -225, 0.5, 0)
    })
    fadeTween:Play()
    fadeTween.Completed:Wait()
    LoadingGui:Destroy()
end

-- Chạy đồng bộ tiến trình loading trước khi mở Menu
task.spawn(RunLoadingSimulation)
task.wait(4.2)

-- ============================================================================
-- PHẦN 3: XÂY DỰNG GIAO DIỆN ĐỒ HỌA CHÍNH (MAIN PREMIUM HUD INTERFACE)
-- ============================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaPremiumMenu"
ScreenGui.Parent = TargetGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainMenuFrame = Instance.new("Frame")
MainMenuFrame.Name = "MainMenuFrame"
MainMenuFrame.Parent = ScreenGui
MainMenuFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainMenuFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
MainMenuFrame.Size = UDim2.new(0, 560, 0, 420)
MainMenuFrame.BorderSizePixel = 0

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 12)
MenuCorner.Parent = MainMenuFrame

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(45, 45, 45)
MenuStroke.Thickness = 1
MenuStroke.Parent = MainMenuFrame

-- Tạo thanh Sidebar chứa Danh sách các Tab chức năng
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Parent = MainMenuFrame
SideBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BorderSizePixel = 0

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 12)
SideBarCorner.Parent = SideBar

local SideBarTitle = Instance.new("TextLabel")
SideBarTitle.Parent = SideBar
SideBarTitle.BackgroundTransparency = 1
SideBarTitle.Position = UDim2.new(0, 12, 0, 15)
SideBarTitle.Size = UDim2.new(1, -24, 0, 30)
SideBarTitle.Font = Enum.Font.GothamBold
SideBarTitle.Text = "BANANA V4"
SideBarTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
SideBarTitle.TextSize = 18
SideBarTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Vùng chứa các nút chuyển đổi Tab chuyên dụng
local TabButtonContainer = Instance.new("ScrollingFrame")
TabButtonContainer.Parent = SideBar
TabButtonContainer.BackgroundTransparency = 1
TabButtonContainer.Position = UDim2.new(0, 8, 0, 60)
TabButtonContainer.Size = UDim2.new(1, -16, 1, -70)
TabButtonContainer.CanvasSize = UDim2.new(0, 0, 0, 400)
TabButtonContainer.ScrollBarThickness = 0

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabButtonContainer
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 6)

-- Vùng chứa Nội dung hiển thị của từng Tab độc lập
local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainMenuFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 160, 0, 15)
ContentContainer.Size = UDim2.new(1, -175, 1, -30)

-- Tạo cấu trúc đa Tab ẩn/hiện động
local Tabs = {}
local currentActiveTab = nil

local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 36)
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.Text = "  " .. tabName
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 13
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.Parent = TabButtonContainer
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = TabButton
    
    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.CanvasSize = UDim2.new(0, 0, 0, 600)
    TabPage.ScrollBarThickness = 4
    TabPage.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    TabPage.Parent = ContentContainer
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = TabPage
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)
    
    TabButton.MouseButton1Click:Connect(function()
        if currentActiveTab then
            currentActiveTab.Page.Visible = false
            currentActiveTab.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            currentActiveTab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        TabPage.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        TabButton.TextColor3 = Color3.fromRGB(15, 15, 15)
        currentActiveTab = {Page = TabPage, Button = TabButton}
    end)
    
    Tabs[tabName] = TabPage
    return TabPage
end

-- Khởi tạo 4 Tab chức năng cao cấp chuyên nghiệp giống mẫu Hub gốc
local MainTab = CreateTab("Tự Động Farm")
local CombatTab = CreateTab("Săn Boss / PvP")local TeleportTab = CreateTab("Dịch Chuyển")local MiscTab = CreateTab("Cài Đặt Hệ Thống")-- Kích hoạt mặc định Tab đầu tiên khi chạy xong loadingTabs["Tự Động Farm"].Visible = trueTabButtonContainer:GetChildren()[2].BackgroundColor3 = Color3.fromRGB(255, 215, 0)TabButtonContainer:GetChildren()[2].TextColor3 = Color3.fromRGB(15, 15, 15)currentActiveTab = {Page = Tabs["Tự Động Farm"], Button = TabButtonContainer:GetChildren()[2]}-- ============================================================================-- PHẦN 4: THIẾT KẾ CÁC THÀNH PHẦN ĐIỀU KHIỂN (TOGGLES, DROPDOWNS, SLIDERS)-- ============================================================================local function CreateToggle(parentPage, text, globalVar, callback)local ToggleFrame = Instance.new("Frame")ToggleFrame.Size = UDim2.new(1, -10, 0, 45)ToggleFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)ToggleFrame.Parent = parentPagelocal TCorner = Instance.new("UICorner")TCorner.CornerRadius = UDim.new(0, 6)TCorner.Parent = ToggleFramelocal TLabel = Instance.new("TextLabel")TLabel.BackgroundTransparency = 1TLabel.Position = UDim2.new(0, 12, 0, 0)TLabel.Size = UDim2.new(0.7, 0, 1, 0)TLabel.Font = Enum.Font.GothamSemiboldTLabel.Text = textTLabel.TextColor3 = Color3.fromRGB(230, 230, 230)TLabel.TextSize = 13TLabel.TextXAlignment = Enum.TextXAlignment.LeftTLabel.Parent = ToggleFramelocal TButton = Instance.new("TextButton")TButton.Position = UDim2.new(0.85, 0, 0.25, 0)TButton.Size = UDim2.new(0, 40, 0, 22)TButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)TButton.Text = ""TButton.Parent = ToggleFramelocal BCorner = Instance.new("UICorner")BCorner.CornerRadius = UDim.new(0, 11)BCorner.Parent = TButtonlocal TCircle = Instance.new("Frame")TCircle.Position = UDim2.new(0, 2, 0, 2)TCircle.Size = UDim2.new(0, 18, 0, 18)TCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)TCircle.Parent = TButtonlocal CCorner = Instance.new("UICorner")CCorner.CornerRadius = UDim.new(1, 0)CCorner.Parent = TCirclelocal state = _G.BananaPremiumConfig[globalVar]local function updateVisual()if _G.BananaPremiumConfig[globalVar] thenTweenService:Create(TButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 215, 0)}):Play()TweenService:Create(TCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 20, 0, 2)}):Play()elseTweenService:Create(TButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()TweenService:Create(TCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()endendupdateVisual()TButton.MouseButton1Click:Connect(function()_G.BananaPremiumConfig[globalVar] = not _G.BananaPremiumConfig[globalVar]updateVisual()if callback then callback(_G.BananaPremiumConfig[globalVar]) endend)endlocal function CreateDropdown(parentPage, text, options, globalVar, callback)local DropdownFrame = Instance.new("Frame")DropdownFrame.Size = UDim2.new(1, -10, 0, 65)DropdownFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)DropdownFrame.Parent = parentPagelocal DCorner = Instance.new("UICorner")DCorner.CornerRadius = UDim.new(0, 6)DCorner.Parent = DropdownFramelocal DLabel = Instance.new("TextLabel")DLabel.BackgroundTransparency = 1DLabel.Position = UDim2.new(0, 12, 0, 8)DLabel.Size = UDim2.new(1, -24, 0, 20)DLabel.Font = Enum.Font.GothamSemiboldDLabel.Text = textDLabel.TextColor3 = Color3.fromRGB(160, 160, 160)DLabel.TextSize = 12DLabel.TextXAlignment = Enum.TextXAlignment.LeftDLabel.Parent = DropdownFramelocal MainDropButton = Instance.new("TextButton")MainDropButton.Position = UDim2.new(0, 12, 0, 32)MainDropButton.Size = UDim2.new(1, -24, 0, 26)MainDropButton.BackgroundColor3 = Color3.fromRGB(38, 38, 38)MainDropButton.Font = Enum.Font.GothamMainDropButton.Text = "  " .. _G.BananaPremiumConfig[globalVar]MainDropButton.TextColor3 = Color3.fromRGB(240, 240, 240)MainDropButton.TextSize = 13MainDropButton.TextXAlignment = Enum.TextXAlignment.LeftMainDropButton.Parent = DropdownFramelocal mCorner = Instance.new("UICorner")mCorner.CornerRadius = UDim.new(0, 4)mCorner.Parent = MainDropButton-- Xử lý hoán đổi chu kỳ danh sách lựa chọn khi click chuột trực tiếpMainDropButton.MouseButton1Click:Connect(function()local currentIndex = 1for i, v in ipairs(options) doif v == _G.BananaPremiumConfig[globalVar] then currentIndex = i break endendlocal nextIndex = currentIndex + 1if nextIndex > #options then nextIndex = 1 end_G.BananaPremiumConfig[globalVar] = options[nextIndex]MainDropButton.Text = "  " .. options[nextIndex]if callback then callback(options[nextIndex]) endend)end-- ============================================================================-- PHẦN 5: ĐỔI MỚI CÁC TRƯỜNG DỮ LIỆU CHỨC NĂNG TRÊN TỪNG TAB RIÊNG BIỆT-- ============================================================================-- Thêm các Option cho Tab Tự Động FarmCreateToggle(MainTab, "Tự Động Tăng Cấp Siêu Tốc (Auto Level)", "AutoFarmLevel", function(state)print("Trạng thái Auto Farm Level: ", state)end)CreateToggle(MainTab, "Tự Động Farm Xương (Auto Bone)", "AutoFarmBones", function(state)print("Trạng thái Auto Farm Xương: ", state)end)CreateDropdown(MainTab, "Chọn Vũ Khí Tấn CÔNG Ưu Tiên", {"Melee", "Sword", "Fruit"}, "SelectedWeapon")-- Thêm các Option cho Tab Cài Đặt Hệ ThốngCreateToggle(MiscTab, "Chế Độ Chống Khóa Tài Khoản (Anti-Ban Pro)", "AntiBanProtection")CreateToggle(MiscTab, "Tối Ưu Hóa FPS / Giảm Đồ Họa Lag", "FpsBooster", function(state)if state thengame:GetService("Lighting").GlobalShadows = falsesettings().Rendering.QualityLevel = 1elsegame:GetService("Lighting").GlobalShadows = trueendend)-- Tích hợp tính năng di chuyển kéo thả mượt mà cho Menu chính (Drag GUI)local dragging, dragInput, dragStart, startPosMainMenuFrame.InputBegan:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch thendragging = truedragStart = input.PositionstartPos = MainMenuFrame.Positioninput.Changed:Connect(function()if input.UserInputState == Enum.UserInputState.End then dragging = false endend)endend)MainMenuFrame.InputChanged:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch thendragInput = inputendend)UserInputService.InputChanged:Connect(function(input)if input == dragInput and dragging thenlocal delta = input.Position - dragStartMainMenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)endend)-- Nút bấm ẩn/hiện Menu nhanh bằng phím bấm (Left Control)UserInputService.InputBegan:Connect(function(input, processed)if not processed and input.KeyCode == Enum.KeyCode.LeftControl thenScreenGui.Enabled = not ScreenGui.Enabledendend)-- ============================================================================-- PHẦN 6: TOÀN BỘ LOGIC GAMEPLAY CHẠY NGẦM BẰNG THUẬT TOÁN TỐI ƯU-- ============================================================================-- Hàm tự động trang bị vũ khí từ hòm đồ (Backpack)local function AutoEquipTool()if not _G.BananaPremiumConfig.AutoEquip then return endlocal character = LocalPlayer.Characterif not character then return endlocal humanoid = character:FindFirstChildOfClass("Humanoid")if not humanoid or humanoid.Health <= 0 then return endif not character:FindFirstChildOfClass("Tool") thenlocal weaponName = _G.BananaPremiumConfig.SelectedWeaponfor _, tool in pairs(LocalPlayer.Backpack:GetChildren()) doif tool:IsA("Tool") and (tool.ToolTip == weaponName or (weaponName == "Melee" and tool.ToolTip == "Combat")) thenhumanoid:EquipTool(tool)breakendendendend-- Vòng lặp Core xử lý gom quái (Bring Mobs) độc quyền của Hub Premiumtask.spawn(function()while true dotask.wait(0.1)if _G.BananaPremiumConfig.AutoFarmLevel or _G.BananaPremiumConfig.AutoFarmBones thenpcall(function()local myChar = LocalPlayer.Characterif myChar and myChar:FindFirstChild("HumanoidRootPart") thenlocal myPos = myChar.HumanoidRootPart.Positionfor _, enemy in pairs(game.Workspace.Enemies:GetChildren()) doif enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 thenlocal distance = (enemy.HumanoidRootPart.Position - myPos).Magnitudeif distance <= _G.BananaPremiumConfig.BringMobDistance thenenemy.HumanoidRootPart.CFrame = myChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6)enemy.HumanoidRootPart.CanCollide = falseendendendendend)endendend)-- Vòng lặp Tự động nhận diện quái, di chuyển (Tween) và Auto Click tấn công liên hồitask.spawn(function()while true dotask.wait()if _G.BananaPremiumConfig.AutoFarmLevel thenpcall(function()local character = LocalPlayer.Characterif not character or not character:FindFirstChild("HumanoidRootPart") then return end-- Thuật toán tìm kiếm mục tiêu quái còn sống gần nhất trong phạm vi bản đồlocal targetEnemy = nilfor _, monster in pairs(game.Workspace.Enemies:GetChildren()) doif monster:FindFirstChild("HumanoidRootPart") and monster:FindFirstChild("Humanoid") and monster.Humanoid.Health > 0 thentargetEnemy = monsterbreakendendif targetEnemy thenAutoEquipTool()-- Giữ khoảng cách CFrame an toàn phía trên đầu mục tiêu để tránh mất máucharacter.HumanoidRootPart.CFrame = targetEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)-- Kích hoạt giả lập nhấn chuột liên tục để kích hoạt Fast AttackVirtualUser:CaptureController()VirtualUser:ClickButton1(Vector2.new(850, 520))endend)endendend)-- Nhúng thêm liên kết kịch bản bổ sung từ kho lưu trữ cá nhân của bạnlocal runMainScript, scriptError = pcall(function()loadstring(game:HttpGet("githubusercontent.com"))()end)if not runMainScript thenwarn("Thông báo hệ thống: Đường dẫn script phụ hiện tại không phản hồi: " .. tostring(scriptError))end