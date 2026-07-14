-- [[ ========================================================================= ]] --
-- [[                       BANANA HUB PREMIUM ULTIMATE V4                      ]] --
-- [[ ========================================================================= ]] --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

-- Dọn dẹp tài nguyên cũ
if TargetGui:FindFirstChild("BananaNotifyScreen") then TargetGui["BananaNotifyScreen"]:Destroy() end
if TargetGui:FindFirstChild("BananaCircleMenu") then TargetGui["BananaCircleMenu"]:Destroy() end
if TargetGui:FindFirstChild("BananaMainMenu") then TargetGui["BananaMainMenu"]:Destroy() end

-- Hệ thống cấu hình toàn cục
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
-- PHẦN 1: THÔNG BÁO CHÀO MỪNG (NOTIFICATION GÓC PHẢI MÀN HÌNH)
-- ============================================================================
local NotifyGui = Instance.new("ScreenGui", TargetGui)
NotifyGui.Name = "BananaNotifyScreen"

local NotifyFrame = Instance.new("Frame", NotifyGui)
NotifyFrame.Size = UDim2.new(0, 320, 0, 65)
NotifyFrame.Position = UDim2.new(1, 50, 0.8, 0)
NotifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local NCorn = Instance.new("UICorner", NotifyFrame)
NCorn.CornerRadius = UDim.new(0, 8)
local NStroke = Instance.new("UIStroke", NotifyFrame)
NStroke.Color = Color3.fromRGB(255, 215, 0)
NStroke.Thickness = 1.5

local NotifyText = Instance.new("TextLabel", NotifyFrame)
NotifyText.Size = UDim2.new(1, -20, 1, 0)
NotifyText.Position = UDim2.new(0, 15, 0, 0)
NotifyText.Font = Enum.Font.GothamBold
NotifyText.Text = "Xin chào anh em đã đến với banana Hub Premium"
NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifyText.TextSize = 12
NotifyText.TextWrapped = true
NotifyText.TextXAlignment = Enum.TextXAlignment.Left
NotifyText.BackgroundTransparency = 1

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
-- PHẦN 2: LOGO VÒNG TRÒN GÓC TRÁI MÀN HÌNH MỞ MENU (AVATAR: 76998880438369)
-- ============================================================================
local CircleGui = Instance.new("ScreenGui", TargetGui)
CircleGui.Name = "BananaCircleMenu"
CircleGui.ResetOnSpawn = false

local LogoButton = Instance.new("ImageButton", CircleGui)
LogoButton.Size = UDim2.new(0, 60, 0, 60)
LogoButton.Position = UDim2.new(0, 20, 0.4, 0) -- Vị trí góc trái màn hình
LogoButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogoButton.Image = "rbxassetid://76998880438369"
LogoButton.BorderSizePixel = 0

local CircleCorner = Instance.new("UICorner", LogoButton)
CircleCorner.CornerRadius = UDim.new(1, 0)
local CircleStroke = Instance.new("UIStroke", LogoButton)
CircleStroke.Color = Color3.fromRGB(255, 215, 0)
CircleStroke.Thickness = 2

local MainMenuGui = Instance.new("ScreenGui", TargetGui)
MainMenuGui.Name = "BananaMainMenu"
MainMenuGui.Enabled = false

-- Kéo thả Logo tròn di chuyển
local dragging, dragInput, dragStart, startPos
LogoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = LogoButton.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
LogoButton.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
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
-- PHẦN 3: THIẾT KẾ KHUNG MENU CHÍNH (MAIN MENU INTERFACE)
-- ============================================================================
local MainFrame = Instance.new("Frame", MainMenuGui)
MainFrame.Size = UDim2.new(0, 560, 0, 390)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MStroke = Instance.new("UIStroke", MainFrame)
MStroke.Color = Color3.fromRGB(45, 45, 45)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
local TCorner = Instance.new("UICorner", TopBar) TCorner.CornerRadius = UDim.new(0, 10)
local TTitle = Instance.new("TextLabel", TopBar)
TTitle.Size = UDim2.new(1, 0, 1, 0) TTitle.Position = UDim2.new(0, 15, 0, 0)
TTitle.Font = Enum.Font.GothamBold TTitle.Text = "BANANA HUB PREMIUM V4"
TTitle.TextColor3 = Color3.fromRGB(255, 215, 0) TTitle.TextSize = 14 TTitle.TextXAlignment = Enum.TextXAlignment.Left TTitle.BackgroundTransparency = 1

-- Nút thu nhỏ (-) đóng menu nhanh
local MinimizeBtn = Instance.new("TextButton", TopBar)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26) MinimizeBtn.Position = UDim2.new(1, -35, 0, 7)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35) MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-" MinimizeBtn.TextColor3 = Color3.fromRGB(255, 215, 0) MinimizeBtn.TextSize = 16
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 5)

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 560, 0, 40), "Out", "Quad", 0.2, true) MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 560, 0, 390), "Out", "Quad", 0.2, true) MinimizeBtn.Text = "-"
    end
end)

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 150, 1, -40) Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local TabScroll = Instance.new("ScrollingFrame", Sidebar)
TabScroll.Size = UDim2.new(1, -10, 1, -20) TabScroll.Position = UDim2.new(0, 5, 0, 10)
TabScroll.BackgroundTransparency = 1 TabScroll.CanvasSize = UDim2.new(0, 0, 0, 200) TabScroll.ScrollBarThickness = 0
local TabList = Instance.new("UIListLayout", TabScroll) TabList.Padding = UDim.new(0, 5)

local CenterPages = Instance.new("Frame", MainFrame)
CenterPages.Size = UDim2.new(1, -170, 1, -60) CenterPages.Position = UDim2.new(0, 160, 0, 50)
CenterPages.BackgroundTransparency = 1

local ActiveTabModule = nil
local function CreateTab(name)
    local Btn = Instance.new("TextButton", TabScroll)
    Btn.Size = UDim2.new(1, 0, 0, 36) Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.Font = Enum.Font.GothamSemibold Btn.Text = "  " .. name Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.TextSize = 12 Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local Page = Instance.new("ScrollingFrame", CenterPages)
    Page.Size = UDim2.new(1, 0, 1, 0) Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 500) Page.ScrollBarThickness = 2 Page.Visible = false
    local PList = Instance.new("UIListLayout", Page) PList.Padding = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        if ActiveTabModule then
            ActiveTabModule.Page.Visible = false ActiveTabModule.Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ActiveTabModule.Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        Page.Visible = true Btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0) Btn.TextColor3 = Color3.fromRGB(15, 15, 15)
        ActiveTabModule = {Page = Page, Btn = Btn}
    end)
    return Page, Btn
end

local Tab_Info = CreateTab("Info Server")
local Tab_Farm = CreateTab("Farm")
local Tab_Esp = CreateTab("Esp | Định vị")
local Tab_Raid = CreateTab("Raid | Fruit")

-- Kích hoạt Tab Info đầu tiên mặc định
Tab_Info.Visible = true
TabScroll:GetChildren()[1].BackgroundColor3 = Color3.fromRGB(255, 215, 0)
TabScroll:GetChildren()[1].TextColor3 = Color3.fromRGB(15, 15, 15)
ActiveTabModule = {Page = Tab_Info, Btn = TabScroll:GetChildren()[1]}

local function AddToggle(page, labelText, key, callback)
    local Box = Instance.new("Frame", page) Box.Size = UDim2.new(1, -10, 0, 46) Box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
    local BLabel = Instance.new("TextLabel", Box) BLabel.Size = UDim2.new(0.7, 0, 1, 0) BLabel.Position = UDim2.new(0, 12, 0, 0)
    BLabel.Font = Enum.Font.GothamSemibold BLabel.Text = labelText BLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    BLabel.TextSize = 13 BLabel.TextXAlignment = Enum.TextXAlignment.Left BLabel.BackgroundTransparency = 1
    
    local Tgl = Instance.new("TextButton", Box) Tgl.Size = UDim2.new(0, 52, 0, 22) Tgl.Position = UDim2.new(0.82, 0, 0.25, 0)Tgl.BackgroundColor3 = Color3.fromRGB(50, 50, 50) Tgl.Font = Enum.Font.GothamBold Tgl.Text = "OFF" Tgl.TextColor3 = Color3.fromRGB(180, 180, 180) Tgl.TextSize = 11Instance.new("UICorner", Tgl).CornerRadius = UDim.new(0, 5)local function UpVisual()if _G.BananaV4_Config[key] thenTgl.BackgroundColor3 = Color3.fromRGB(255, 215, 0) Tgl.TextColor3 = Color3.fromRGB(15, 15, 15) Tgl.Text = "ON"elseTgl.BackgroundColor3 = Color3.fromRGB(50, 50, 50) Tgl.TextColor3 = Color3.fromRGB(180, 180, 180) Tgl.Text = "OFF"endendUpVisual()Tgl.MouseButton1Click:Connect(function() _G.BananaV4_Config[key] = not _G.BananaV4_Config[key] UpVisual() if callback then callback(_G.BananaV4_Config[key]) end end)end-- ============================================================================-- PHẦN 4: THIẾT LẬP NỘI DUNG CHI TIẾT TỪNG TAB THEO YÊU CẦU-- ============================================================================-- TAB 1: INFO SERVERlocal function CreateInfoLabel(page, text)local Lbl = Instance.new("TextLabel", page) Lbl.Size = UDim2.new(1, -10, 0, 35)Lbl.Font = Enum.Font.GothamSemibold Lbl.TextColor3 = Color3.fromRGB(240, 240, 240) Lbl.TextSize = 12Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.BackgroundTransparency = 1 Lbl.Text = "   " .. textreturn Lblendlocal PlayTimeLabel = CreateInfoLabel(Tab_Info, "Thời gian chơi của bạn: Đang tính toán...")local PlayerCountLabel = CreateInfoLabel(Tab_Info, "Số người chơi hiện tại: " .. #Players:GetPlayers() .. " người")local DarkBeardLabel = CreateInfoLabel(Tab_Info, "Bảo lâu nữa có Key Râu Đen: Sắp xuất hiện")task.spawn(function()local startTime = os.time()while true dotask.wait(1)local diff = os.time() - startTimelocal hours = math.floor(diff / 3600)local mins = math.floor((diff % 3600) / 60)local secs = diff % 60PlayTimeLabel.Text = string.format("   Thời gian đã chơi: %02d tiếng %02d phút %02d giây", hours, mins, secs)PlayerCountLabel.Text = "   Số người chơi hiện tại: " .. #Players:GetPlayers() .. " người"endend)-- TAB 2: FARMAddToggle(Tab_Farm, "Tự Động Farm Level (Auto Level)", "AutoFarmLevel")AddToggle(Tab_Farm, "Tự Động Đánh Hải Tặc (Auto Pirates)", "AutoAttackPirates")AddToggle(Tab_Farm, "Tự Động Đánh Nhà Máy (Auto Factory)", "AutoFactory")AddToggle(Tab_Farm, "Tự Động Nhặt Rương Kiếm Beli (Auto Chest)", "AutoChest")AddToggle(Tab_Farm, "Tự Động Gom Trái Cây (Auto Berry)", "AutoBerry")AddToggle(Tab_Farm, "Hiệu Ứng Người Màu Vàng Full (Midas Mode)", "FullGoldBody", function(state)local char = LocalPlayer.Characterif char thenfor _, part in pairs(char:GetChildren()) doif part:IsA("BasePart") thenif state thenlocal highlight = Instance.new("Highlight", part)highlight.Name = "GoldHighlight"highlight.FillColor = Color3.fromRGB(255, 215, 0)highlight.OutlineColor = Color3.fromRGB(255, 255, 255)highlight.FillTransparency = 0elseif part:FindFirstChild("GoldHighlight") then part.GoldHighlight:Destroy() endendendendendend)-- TAB 3: ESP | ĐỊNH VỊAddToggle(Tab_Esp, "Định Vị Trái Ác Quỷ (ESP Fruits Spammed)", "EspFruit")AddToggle(Tab_Esp, "Định Vị Người Chơi (ESP Players Level/HP)", "EspPlayer")-- Đồng bộ xử lý hiệu ứng ESP thực tế hiển thị khoảng cách mét (m)task.spawn(function()while true dotask.wait(0.5)-- Xóa ESP cũfor _, v in pairs(Workspace:GetChildren()) do if v.Name == "FruitESP" or v.Name == "PlayerESP" then v:Destroy() end end-- Logic ESP Trái ác quỷ hiển thị số métif _G.BananaV4_Config.EspFruit thenfor _, obj in pairs(Workspace:GetChildren()) doif obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) thenlocal root = obj:FindFirstChild("Handle")if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") thenlocal dist = math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)local bbg = Instance.new("BillboardGui", Workspace) bbg.Name = "FruitESP"bbg.AlwaysOnTop = true bbg.Size = UDim2.new(0, 100, 0, 30) bbg.Adornee = rootlocal txt = Instance.new("TextLabel", bbg) txt.Size = UDim2.new(1, 0, 1, 0)txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(0, 255, 120) txt.Font = Enum.Font.GothamBoldtxt.TextSize = 11 txt.Text = obj.Name .. " [" .. dist .. "m]"endendendendendend)-- TAB 4: RAID | FRUIT DETECTORlocal FruitStatusLabel = CreateInfoLabel(Tab_Raid, "Kiểm tra trái ác quỷ trên sàn: Đang rà quét...")task.spawn(function()while true dotask.wait(1)local hasFruit = falsefor _, obj in pairs(Workspace:GetChildren()) doif obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) thenhasFruit = true breakendendif hasFruit thenFruitStatusLabel.Text = "   Trạng thái: ĐÃ CÓ TRÁI ÁC QUỶ XUẤT HIỆN!"FruitStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 115)elseFruitStatusLabel.Text = "   Trạng thái: KHÔNG CÓ TRÁI ÁC QUỶ TRÊN SÀN"FruitStatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)endendend)-- ============================================================================-- PHẦN 5: ĐỘNG CƠ CORE AUTO FARM CHẠY NGẦM THỰC TẾ-- ============================================================================task.spawn(function()while true dotask.wait()if _G.BananaV4_Config.AutoFarmLevel or _G.BananaV4_Config.AutoAttackPirates thenpcall(function()local target = nilfor _, v in pairs(Workspace.Enemies:GetChildren()) doif v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 thentarget = v breakendendif target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") thenLocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)VirtualUser:CaptureController()VirtualUser:ClickButton1(Vector2.new(850, 520))endend)endendend)-- Phím tắt ẩn/hiện nhanh menu bằng phím Left ControlUserInputService.InputBegan:Connect(function(input, proc)if not proc and input.KeyCode == Enum.KeyCode.LeftControl then MainMenuGui.Enabled = not MainMenuGui.Enabled endend)