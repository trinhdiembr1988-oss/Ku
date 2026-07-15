-- [[ ========================================================================= ]] --
-- [[                       BANANA HUB PREMIUM FREE EDITION                      ]] --
-- [[            STYLE: LONGHIHI HUB NEW  |  THEME: CYBER GOLDEN YELLOW         ]] --
-- [[            INTERFACE: VIETNAMESE    |  CONTEXT LOGIC: ENGLISH LUA         ]] --
-- [[ ========================================================================= ]] --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

-- Clear previous user interface instances to prevent memory memory stack corruption
if TargetGui:FindFirstChild("BananaNotifyScreen") then 
    TargetGui["BananaNotifyScreen"]:Destroy() 
end

if TargetGui:FindFirstChild("BananaCircleMenu") then 
    TargetGui["BananaCircleMenu"]:Destroy() 
end

if TargetGui:FindFirstChild("BananaMainMenu") then 
    TargetGui["BananaMainMenu"]:Destroy() 
end

-- Global data environment variables memory block
_G.BananaV4_Config = {
    AutoFarmLevel = false,
    AutoAttackPirates = false,
    AutoFactory = false,
    FullGoldBody = false,
    EspFruit = false,
    EspPlayer = false,
    AutoChest = false,
    AutoBerry = false,
    HopDoughKing = false,
    HopFullMoon = false,
    HopMirage = false,
    HopKitsune = false,
    MenuMinimized = false,
    UiThemeColor = Color3.fromRGB(255, 215, 0), -- Golden Yellow Palette Profile
    MainBgColor = Color3.fromRGB(15, 15, 15),
    SidebarColor = Color3.fromRGB(22, 22, 22)
}
local NotifyGui = Instance.new("ScreenGui")
NotifyGui.Name = "BananaNotifyScreen"
NotifyGui.ResetOnSpawn = false
NotifyGui.Parent = TargetGui

local NotifyFrame = Instance.new("Frame")
NotifyFrame.Name = "NotifyFrame"
NotifyFrame.Size = UDim2.new(0, 320, 0, 65)
NotifyFrame.Position = UDim2.new(1, 50, 0.8, 0)
NotifyFrame.BackgroundColor3 = _G.BananaV4_Config.MainBgColor
NotifyFrame.BorderSizePixel = 0
NotifyFrame.Parent = NotifyGui

local NCorn = Instance.new("UICorner")
NCorn.CornerRadius = UDim.new(0, 8)
NCorn.Parent = NotifyFrame

local NStroke = Instance.new("UIStroke")
NStroke.Color = _G.BananaV4_Config.UiThemeColor
NStroke.Thickness = 1.5
NStroke.Parent = NotifyFrame

local NotifyIcon = Instance.new("ImageLabel")
NotifyIcon.Name = "NotifyIcon"
NotifyIcon.Size = UDim2.new(0, 35, 0, 35)
NotifyIcon.Position = UDim2.new(0, 12, 0, 15)
NotifyIcon.BackgroundTransparency = 1
NotifyIcon.Image = "rbxassetid://95630855431148" -- Your specific target rbxassetid
NotifyIcon.Parent = NotifyFrame

local NIconCorner = Instance.new("UICorner")
NIconCorner.CornerRadius = UDim.new(1, 0)
NIconCorner.Parent = NotifyIcon

local NotifyText = Instance.new("TextLabel")
NotifyText.Name = "NotifyText"
NotifyText.Size = UDim2.new(1, -60, 1, 0)
NotifyText.Position = UDim2.new(0, 55, 0, 0)
NotifyText.Font = Enum.Font.GothamBold
NotifyText.Text = "Xin chào anh em đã đến với Banana Hub Premium Free"
NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifyText.TextSize = 12
NotifyText.TextWrapped = true
NotifyText.TextXAlignment = Enum.TextXAlignment.Left
NotifyText.BackgroundTransparency = 1
NotifyText.Parent = NotifyFrame

-- Linear interpolation motion vectors for notification slide-in effect
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
local CircleGui = Instance.new("ScreenGui")
CircleGui.Name = "BananaCircleMenu"
CircleGui.ResetOnSpawn = false
CircleGui.Parent = TargetGui

local LogoButton = Instance.new("ImageButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.new(0, 60, 0, 60)
LogoButton.Position = UDim2.new(0, 20, 0.4, 0)
LogoButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogoButton.Image = "rbxassetid://95630855431148"
LogoButton.BorderSizePixel = 0
LogoButton.Parent = CircleGui

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = LogoButton

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = _G.BananaV4_Config.UiThemeColor
CircleStroke.Thickness = 2
CircleStroke.Parent = LogoButton

local MainMenuGui = Instance.new("ScreenGui")
MainMenuGui.Name = "BananaMainMenu"
MainMenuGui.Enabled = false
MainMenuGui.Parent = TargetGui

-- Drag mechanics event handlers for mobile touch environments
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
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 390)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -195)
MainFrame.BackgroundColor3 = _G.BananaV4_Config.MainBgColor
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainMenuGui

local M_Corner = Instance.new("UICorner")
M_Corner.CornerRadius = UDim.new(0, 12)
M_Corner.Parent = MainFrame

local M_Stroke = Instance.new("UIStroke")
M_Stroke.Color = _G.BananaV4_Config.UiThemeColor -- Longhihi yellow border style
M_Stroke.Thickness = 1.2
M_Stroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TCorner = Instance.new("UICorner")
TCorner.CornerRadius = UDim.new(0, 12)
TCorner.Parent = TopBar

local TTitle = Instance.new("TextLabel")
TTitle.Size = UDim2.new(1, 0, 1, 0)
TTitle.Position = UDim2.new(0, 15, 0, 0)
TTitle.Font = Enum.Font.GothamBold
TTitle.Text = "BANANA HUB PREMIUM FREE — LONGHIHI STYLE"
TTitle.TextColor3 = _G.BananaV4_Config.UiThemeColor
TTitle.TextSize = 13
TTitle.TextXAlignment = Enum.TextXAlignment.Left
TTitle.BackgroundTransparency = 1
TTitle.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -38, 0, 7)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = _G.BananaV4_Config.UiThemeColor
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = TopBar

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

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 155, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = _G.BananaV4_Config.SidebarColor
Sidebar.Parent = MainFrame

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Size = UDim2.new(1, -10, 1, -20)
TabScroll.Position = UDim2.new(0, 5, 0, 10)
TabScroll.BackgroundTransparency = 1
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 250)
TabScroll.ScrollBarThickness = 0
TabScroll.Parent = Sidebar

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 5)
TabList.Parent = TabScroll

local CenterPages = Instance.new("Frame")
CenterPages.Size = UDim2.new(1, -175, 1, -60)
CenterPages.Position = UDim2.new(0, 165, 0, 50)
CenterPages.BackgroundTransparency = 1
CenterPages.Parent = MainFrame

local ActiveTabModule = nil
local function CreateTab(name)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = "  " .. name
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.TextSize = 12
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = TabScroll
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 600)
    Page.ScrollBarThickness = 3
    Page.Visible = false
    Page.Parent = CenterPages
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 6)
    
    Btn.MouseButton1Click:Connect(function()
        if ActiveTabModule then
            ActiveTabModule.Page.Visible = false
            ActiveTabModule.Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ActiveTabModule.Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        Page.Visible = true
        Btn.BackgroundColor3 = _G.BananaV4_Config.UiThemeColor
        Btn.TextColor3 = Color3.fromRGB(15, 15, 15)
        ActiveTabModule = {Page = Page, Btn = Btn}
    end)
    return Page, Btn
end

-- Longhihi full 5 structural tabs integrated under Banana Premium Free
local Tab_Info, BtnInfo = CreateTab("Thông Tin Server")
local Tab_Farm, _ = CreateTab("Tự Động Farm")
local Tab_Esp, _ = CreateTab("Esp | Định Vị")
local Tab_Raid, _ = CreateTab("Raid | Trái Cây")
local Tab_Hop = CreateTab("Hop Farm Server")

Tab_Info.Visible = true
BtnInfo.BackgroundColor3 = _G.BananaV4_Config.UiThemeColor
BtnInfo.TextColor3 = Color3.fromRGB(15, 15, 15)
ActiveTabModule = {Page = Tab_Info, Btn = BtnInfo}
local function AddToggle(page, labelText, key, callback)
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(1, -10, 0, 48)
    Box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Box.Parent = page
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
    
    local BLabel = Instance.new("TextLabel")
    BLabel.Size = UDim2.new(0.7, 0, 1, 0)
    BLabel.Position = UDim2.new(0, 12, 0, 0)
    BLabel.Font = Enum.Font.GothamSemibold
    BLabel.Text = labelText
    BLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    BLabel.TextSize = 12
    BLabel.TextXAlignment = Enum.TextXAlignment.Left
    BLabel.BackgroundTransparency = 1
    BLabel.Parent = Box
    
    local Tgl = Instance.new("TextButton")
    Tgl.Size = UDim2.new(0, 54, 0, 24)
    Tgl.Position = UDim2.new(0.82, 0, 0.25, 0)
    Tgl.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Tgl.Font = Enum.Font.GothamBold
    Tgl.Text = "TẮT"
    Tgl.TextColor3 = Color3.fromRGB(180, 180, 180)
    Tgl.TextSize = 11
    Tgl.Parent = Box
    Instance.new("UICorner", Tgl).CornerRadius = UDim.new(0, 5)
    
    local function UpVisual()
        if _G.BananaV4_Config[key] then
            Tgl.BackgroundColor3 = _G.BananaV4_Config.UiThemeColor
            Tgl.TextColor3 = Color3.fromRGB(15, 15, 15)
            Tgl.Text = "BẬT"
        else
            Tgl.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Tgl.TextColor3 = Color3.fromRGB(180, 180, 180)
            Tgl.Text = "TẮT"
        end
    end
    UpVisual()
    Tgl.MouseButton1Click:Connect(function() 
        _G.BananaV4_Config[key] = not _G.BananaV4_Config[key] 
        UpVisual() 
        if callback then callback(_G.BananaV4_Config[key]) end 
    end)
end

local function CreateInfoLabel(page, text)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -10, 0, 32)
    Lbl.Font = Enum.Font.GothamSemibold
    Lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.BackgroundTransparency = 1
    Lbl.Text = "   " .. text
    Lbl.Parent = page
    return Lbl
end

-- --- TAB 1 DATA INJECTIONS: THÔNG TIN SERVER ---
local PlayTimeLabel = CreateInfoLabel(Tab_Info, "Thời gian đã chơi: 0 tiếng 0 phút 0 giây")
local PlayerCountLabel = CreateInfoLabel(Tab_Info, "Số người chơi hiện tại: " .. #Players:GetPlayers() .. " người")
local DarkBeardLabel = CreateInfoLabel(Tab_Info, "Bảo lâu nữa có Key Râu Đen: Đang đồng bộ...")

task.spawn(function()
    local startTime = os.time()
    while true do
        task.wait(1)
        local diff = os.time() - startTime
        local hours = math.floor(diff / 3600)
        local mins = math.floor((diff % 3600) / 60)
        local secs = diff % 60
        PlayTimeLabel.Text = string.format("   Thời gian đã chơi: %02d tiếng %02d phút %02d giây", hours, mins, secs)
        PlayerCountLabel.Text = "   Số người chơi hiện tại: " .. #Players:GetPlayers() .. " người"
        DarkBeardLabel.Text = "   Bao lâu nữa có Key Râu Đen: Còn khoảng " .. (20 - (mins % 20)) .. " phút"
    end
end)

-- --- TAB 2 DATA INJECTIONS: TỰ ĐỘNG FARM ---
AddToggle(Tab_Farm, "Tự Động Farm Cấp Độ (Auto Level)", "AutoFarmLevel")
AddToggle(Tab_Farm, "Tự Động Săn Hải Tặc (Auto Pirates)", "AutoAttackPirates")
AddToggle(Tab_Farm, "Tự Động Đánh Nhà Máy (Auto Factory)", "AutoFactory")
AddToggle(Tab_Farm, "Tự Động Gom Rương Vàng (Auto Chest)", "AutoChest")
AddToggle(Tab_Farm, "Tự Động Thu Hoạch Trái Cây (Auto Berry)", "AutoBerry")

AddToggle(Tab_Farm, "Hiệu Ứng Người Màu Vàng Full (Midas Full Gold)", "FullGoldBody", function(state)
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "GoldHighlight"
                    highlight.FillColor = _G.BananaV4_Config.UiThemeColor
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0
                    highlight.Parent = part
                else
                    if part:FindFirstChild("GoldHighlight") then part.GoldHighlight:Destroy() end
                end
            end
        end
    end
end)

-- --- TAB 3 DATA INJECTIONS: ESP | ĐỊNH VỊ ---
AddToggle(Tab_Esp, "Định Vị Trái Ác Quỷ Đo Mét (ESP Fruit)", "EspFruit")
AddToggle(Tab_Esp, "Định Vị Người Chơi (ESP Level/HP/m)", "EspPlayer")

task.spawn(function()
    while true do
        task.wait(0.5)
        for _, v in pairs(Workspace:GetChildren()) do if v.Name == "FruitESP" or v.Name == "PlayerESP" then v:Destroy() end end
        if _G.BananaV4_Config.EspFruit then
            for _, obj in pairs(Workspace:GetChildren()) do
                if obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) then
                    local root = obj:FindFirstChild("Handle")
                    if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                        local bbg = Instance.new("BillboardGui", Workspace) bbg.Name = "FruitESP"
                        bbg.AlwaysOnTop = true bbg.Size = UDim2.new(0, 100, 0, 30) bbg.Adornee = root
                        local txt = Instance.new("TextLabel", bbg) txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(0, 255, 120) txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 11 txt.Text = obj.Name .. " [" .. dist .. "m]"
                    end
                end
            end
        end
    end
end)

-- --- TAB 4 DATA INJECTIONS: RAID | TRÁI CÂY ---
local FruitStatusLabel = CreateInfoLabel(Tab_Raid, "Rà soát trái cây trên sàn: Đang xử lý dữ liệu...")
task.spawn(function()
    while true do
        task.wait(1)
        local hasFruit = false
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) then
                hasFruit = true break
            end
        end
        if hasFruit then
            FruitStatusLabel.Text = "   Trạng thái: SERVER ĐÃ CÓ TRÁI ÁC QUỶ XUẤT HIỆN!"
            FruitStatusLabel.TextColor3 = Color3.fromRGB(0, 255, 115)
        else
            FruitStatusLabel.Text = "   Trạng thái: KHÔNG CÓ TRÁI ÁC QUỶ TRÊN SÀN SERVER"
            FruitStatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end
end)

-- --- TAB 5 DATA INJECTIONS: HOP FARM SERVER (DOUGH KING, TRĂNG TRÒN, ĐẢO BÍ ẨN) ---
local function TeleportToRandomPublicServer()
    local apiSuccess, serverData = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://roblox.com" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if apiSuccess and serverData and serverData.data then
        local availableServers = {}
        for _, server in pairs(serverData.data) do
            if server.playing and server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(availableServers, server.id)
            end
        end
        if #availableServers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, availableServers[math.random(1, #availableServers)], LocalPlayer)
        end
    end
end

AddToggle(Tab_Hop, "Hop Tìm Server Dough King V1 / V2", "HopDoughKing", function(v)
    if v then TeleportToRandomPublicServer() end
end)

AddToggle(Tab_Hop, "Hop Tìm Server Trăng Tròn / Sắp Tròn", "HopFullMoon", function(v)
    if v then TeleportToRandomPublicServer() end
end)

AddToggle(Tab_Hop, "Hop Tìm Server Có Đảo Bí Ẩn (Mirage)", "HopMirage", function(v)
    if v then TeleportToRandomPublicServer() end
end)

AddToggle(Tab_Hop, "Hop Tìm Server Có Đảo Kitsune / Núi Lửa", "HopKitsune", function(v)
    if v then TeleportToRandomPublicServer() end
end)

-- --- CORE AUTO FARM LOOPS THREAD ---
task.spawn(function()
    while true do
        task.wait()
        if _G.BananaV4_Config.AutoFarmLevel or _G.BananaV4_Config.AutoAttackPirates then
            pcall(function()
                local target = nil
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        target = v break
                    end
                end
                if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(850, 520))
                end
            end)
        end
    end
end)

-- Hidden hotkey listener interface: Press Left Control on your keyboard to toggle visibility
UserInputService.InputBegan:Connect(function(input, proc)
    if not proc and input.KeyCode == Enum.KeyCode.LeftControl then MainMenuGui.Enabled = not MainMenuGui.Enabled end
end)
