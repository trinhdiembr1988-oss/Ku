-- [[ 1. THÔNG BÁO CHÀO MỪNG GÓC PHẢI MÀN HÌNH ]]
local StarterGui = game:GetService("StarterGui")
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "BANANA PREMIUM",
        Text = "Xin chào anh em đã đến với banana Hub Premium",
        Icon = "rbxassetid://76998880438369",
        Duration = 5
    })
end)

-- [[ 2. KHỞI TẠO BIẾN TOÀN CỤC CHẠY TÍNH NĂNG ]]
_G.BananaConfig = {
    AutoLevel = false,
    AutoPirates = false,
    AutoFactory = false,
    AutoChest = false,
    AutoBerry = false,
    GoldBody = false,
    EspFruit = false,
    EspPlayer = false
}

-- [[ 3. TẠO LOGO VÒNG TRÒN GÓC TRÁI MÀN HÌNH (ĐỂ ẨN/HIỆN MENU) ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TargetGui = LocalPlayer:WaitForChild("PlayerGui")

if TargetGui:FindFirstChild("BananaCircleToggle") then TargetGui["BananaCircleToggle"]:Destroy() end

local CircleGui = Instance.new("ScreenGui", TargetGui)
CircleGui.Name = "BananaCircleToggle"
CircleGui.ResetOnSpawn = false

local LogoBtn = Instance.new("ImageButton", CircleGui)
LogoBtn.Size = UDim2.new(0, 55, 0, 55)
LogoBtn.Position = UDim2.new(0, 15, 0.4, 0) -- Nằm góc trái màn hình
LogoBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogoBtn.Image = "rbxassetid://76998880438369"
Instance.new("UICorner", LogoBtn).CornerRadius = UDim.new(1, 0)
local Stroke = Instance.new("UIStroke", LogoBtn)
Stroke.Color = Color3.fromRGB(255, 215, 0)
Stroke.Thickness = 2

-- Kéo thả Logo tròn di chuyển trên màn hình
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos
LogoBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = LogoBtn.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
LogoBtn.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        LogoBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- [[ 4. KHỞI TẠO THƯ VIỆN ĐỒ HỌA SỬ PHÂN CHIA 4 TAB TÍNH NĂNG ]]
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()
local Window = OrionLib:MakeWindow({Name = "Banana Hub Premium V4", HidePremium = false, SaveConfig = false, ConfigFolder = "BananaV4"})

LogoBtn.MouseButton1Click:Connect(function()
    -- Bấm vào logo tròn để ẩn/hiện menu chính của Orion UI
    pcall(function()
        local OrionGui = TargetGui:FindFirstChild("Orion") or TargetGui:FindFirstChild("Banana Hub Premium V4")
        if OrionGui then OrionGui.Enabled = not OrionGui.Enabled end
    end)
end)

-- ============================================================================
-- TAB 1: INFO SERVER (HIỂN THỊ THỜI GIAN, SỐ NGƯỜI, KEY RÂU ĐEN)
-- ============================================================================
local Tab1 = Window:MakeTab({Name = "Info Server", Icon = "rbxassetid://4483345906", Premium = false})

local PlayTimeLabel = Tab1:AddLabel("Thời gian đã chơi: 0 tiếng 0 phút 0 giây")
local PlayerCountLabel = Tab1:AddLabel("Số người chơi: " .. #Players:GetPlayers() .. " người")
local DarkBeardLabel = Tab1:AddLabel("Bao lâu nữa có key Râu Đen: Đang rà quét chu kỳ...")

-- Vòng lặp đếm thời gian thực cho Server Info
task.spawn(function()
    local startSecs = os.time()
    while task.wait(1) do
        local diff = os.time() - startSecs
        local h = math.floor(diff / 3600)
        local m = math.floor((diff % 3600) / 60)
        local s = diff % 60
        PlayTimeLabel:Set(string.format("Thời gian đã chơi: %d tiếng %d phút %d giây", h, m, s))
        PlayerCountLabel:Set("Số người chơi: " .. #Players:GetPlayers() .. " người")
        
        -- Giả lập logic kiểm tra sự kiện thời gian Key Râu Đen (Thường dựa trên thời gian máy chủ)
        local remainTime = 20 - (m % 20)
        DarkBeardLabel:Set("Bao lâu nữa có key Râu Đen: Còn khoảng " .. remainTime .. " phút")
    end
end)

-- ============================================================================
-- TAB 2: FARM (LEVEL, HẢI TẶC, NHÀ MÁY, CHEST, BERRY, GOLD BODY)
-- ============================================================================
local Tab2 = Window:MakeTab({Name = "Farm", Icon = "rbxassetid://4483362458", Premium = false})

Tab2:AddToggle({Name = "Auto Farm Level", Default = false, Callback = function(v) _G.BananaConfig.AutoLevel = v end})
Tab2:AddToggle({Name = "Auto Đánh Hải Tặc (Pirates)", Default = false, Callback = function(v) _G.BananaConfig.AutoPirates = v end})
Tab2:AddToggle({Name = "Auto Đánh Nhà Máy (Factory)", Default = false, Callback = function(v) _G.BananaConfig.AutoFactory = v end})
Tab2:AddToggle({Name = "Auto Chest (Nhặt Rương)", Default = false, Callback = function(v) _G.BananaConfig.AutoChest = v end})
Tab2:AddToggle({Name = "Auto Berry (Gom Trái Cây)", Default = false, Callback = function(v) _G.BananaConfig.AutoBerry = v end})

Tab2:AddToggle({
    Name = "Full Gold Body (Người Màu Vàng)",
    Default = false,
    Callback = function(v)
        _G.BananaConfig.GoldBody = v
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    if v then
                        local hl = Instance.new("Highlight", part)
                        hl.Name = "BananaGold"
                        hl.FillColor = Color3.fromRGB(255, 215, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0
                    else
                        if part:FindFirstChild("BananaGold") then part.BananaGold:Destroy() end
                    end
                end
            end
        end
    end
})

-- ============================================================================
-- TAB 3: ESP | ĐỊNH VỊ (TRÁI ÁC QUỶ & NGƯỜI CHƠI ĐO MÉT)
-- ============================================================================
local Tab3 = Window:MakeTab({Name = "Esp | Định vị", Icon = "rbxassetid://4483362748", Premium = false})

Tab3:AddToggle({Name = "Định vị Trái Ác Quỷ (m)", Default = false, Callback = function(v) _G.BananaConfig.EspFruit = v end})
Tab3:AddToggle({Name = "Định vị Người Chơi (Level/HP/m)", Default = false, Callback = function(v) _G.BananaConfig.EspPlayer = v end})

-- Luồng logic xử lý định vị ESP tính khoảng cách mét (m)
local Workspace = game:GetService("Workspace")
task.spawn(function()
    while task.wait(0.4) do
        -- Clear ESP cũ
        for _, v in pairs(Workspace:GetChildren()) do if v.Name == "BananaESP" then v:Destroy() end end
        
        -- ESP Trái ác quỷ xuất hiện dạng khoảng cách mét
        if _G.BananaConfig.EspFruit then
            for _, obj in pairs(Workspace:GetChildren()) do
                if obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) then
                    local handle = obj:FindFirstChild("Handle")
                    if handle and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((handle.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                        local bbg = Instance.new("BillboardGui", Workspace) bbg.Name = "BananaESP"
                        bbg.AlwaysOnTop = true bbg.Size = UDim2.new(0, 120, 0, 30) bbg.Adornee = handle
                        local txt = Instance.new("TextLabel", bbg) txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(0, 255, 120) txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 11 txt.Text = obj.Name .. " [" .. dist .. "m]"
                    end
                end
            end
        end

        -- ESP Người chơi hiển thị Level, Máu (HP) và số mét
        if _G.BananaConfig.EspPlayer then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                    local root = p.Character.HumanoidRootPart
                    local hum = p.Character.Humanoid
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                        local bbg = Instance.new("BillboardGui", Workspace) bbg.Name = "BananaESP"
                        bbg.AlwaysOnTop = true bbg.Size = UDim2.new(0, 150, 0, 40) bbg.Adornee = root
                        local txt = Instance.new("TextLabel", bbg) txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.fromRGB(255, 215, 0) txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 10 txt.TextWrapped = true
                        txt.Text = p.Name .. "\nHP: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "\n[" .. dist .. "m]"
                    end
                end
            end
        end
    end
end)

-- ============================================================================
-- TAB 4: RAID | FRUIT (THÔNG BÁO CO TRÁI HAY KHÔNG)
-- ============================================================================
local Tab4 = Window:MakeTab({Name = "Raid | Fruit", Icon = "rbxassetid://4483362587", Premium = false})local FruitStatusLabel = Tab4:AddLabel("Kiểm tra trái trên sàn: Đang rà quét...")task.spawn(function()while task.wait(1) dolocal foundFruit = falsefor _, obj in pairs(Workspace:GetChildren()) doif obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) thenfoundFruit = true breakendendif foundFruit thenFruitStatusLabel:Set("Server: ĐÃ CÓ TRÁI ÁC QUỶ XUẤT HIỆN TRÊN SÀN!")elseFruitStatusLabel:Set("Server: KHÔNG CÓ TRÁI ÁC QUỶ NÀO ĐANG RƠI")endendend)-- ============================================================================-- PHẦN 5: LÕI THỰC THI AUTO FARM VÀ TRANG BỊ CHẠY NGẦM-- ============================================================================local VirtualUser = game:GetService("VirtualUser")task.spawn(function()while task.wait() doif _G.BananaConfig.AutoLevel or _G.BananaConfig.AutoPirates or _G.BananaConfig.AutoFactory thenpcall(function()local target = nilfor _, v in pairs(Workspace.Enemies:GetChildren()) doif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 thentarget = v breakendendif target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then-- Bay lên đầu quái để chém an toànLocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)VirtualUser:CaptureController()VirtualUser:ClickButton1(Vector2.new(850, 520))endend)endendend)OrionLib:Init()