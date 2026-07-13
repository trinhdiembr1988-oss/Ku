-- ====================================================================
-- NO-KEY FREE PREMIUM HUB - FLUENT UI EDITION
-- Tính năng: Khởi chạy trực tiếp, Không cần Key, Tự động gom quái
-- ====================================================================

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Khởi tạo bảng lưu trữ trạng thái cấu hình hệ thống
getgenv().FreeHubConfig = {
    AutoFarm = false,
    MobMagnet = false,
    FastAttack = false,
    SelectedWeapon = "Melee",
    CurrentTargetEnemy = nil
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- 1. HÀM DI CHUYỂN TWEEN MƯỢT MÀ CHỐNG HỆ THỐNG KICK VĂNG
local function SmoothTween(targetCFrame)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local speed = 300 -- Tốc độ bay tối ưu để bảo vệ tài khoản
    local duration = distance / speed

    local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, info, {CFrame = targetCFrame})
    
    -- Vô hiệu hóa trọng lực tạm thời bằng lực đẩy vật lý để giữ nhân vật thăng bằng khi bay
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent = hrp

    tween:Play()
    tween.Completed:Connect(function()
        if bv then bv:Destroy() end
    end)
    return tween
end

-- 2. THUẬT TOÁN GOM QUÁI VẬT TỰ ĐỘNG (MOB MAGNET)
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().FreeHubConfig.MobMagnet and getgenv().FreeHubConfig.AutoFarm then
            pcall(function()
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not myRoot then return end

                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        -- Tắt va chạm vật lý của quái vật để có thể kéo tụ tụ lại một điểm
                        enemy.HumanoidRootPart.CanCollide = false
                        -- Đưa toàn bộ quái vật ra vị trí cố định trước mặt người chơi 4 mét để dễ đánh trúng
                        enemy.HumanoidRootPart.CFrame = myRoot.CFrame * CFrame.new(0, 0, -4)
                    end
                end
            end)
        end
    end
end)

-- 3. HÀM TỰ ĐỘNG TRANG BỊ VŨ KHÍ VÀ TẤN CÔNG (AUTO ATTACK)
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().FreeHubConfig.FastAttack and getgenv().FreeHubConfig.AutoFarm then
            pcall(function()
                local character = LocalPlayer.Character
                local backpack = LocalPlayer.Backpack
                -- Tìm công cụ chiến đấu dựa trên lựa chọn trong túi đồ hoặc trên tay nhân vật
                local tool = backpack:FindFirstChild(getgenv().FreeHubConfig.SelectedWeapon) or character:FindFirstChild(getgenv().FreeHubConfig.SelectedWeapon)
                
                if tool and character:FindFirstChild("Humanoid") then
                    character.Humanoid:EquipTool(tool)
                    -- Giả lập thao tác nhấp chuột ảo liên tục từ hệ thống
                    local vu = game:GetService("VirtualUser")
                    vu:CaptureController()
                    vu:ClickButton1(Vector2.new(0, 0))
                end
            end)
        end
    end
end)

-- 4. KHỞI CHẠY TRỰC TIẾP GIAO DIỆN HACK CHÍNH (DIRECT INITIALIZATION)
local Fluent = loadstring(game:HttpGet("https://github.com"))()

local Window = Fluent:CreateWindow({
    Title = "FREE BANANA HUB 🌟",
    SubTitle = "Phiên Bản Không Cần Key",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 440),
    Acrylic = true, -- Hiệu ứng mờ nhám nền kính cao cấp
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tạo các danh mục lựa chọn (Tabs)
local Tabs = {
    Main = Window:AddTab({ Title = "Chức Năng Farm", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Cấu Hình Hệ Thống", Icon = "settings" })
}

-- Thêm các nút tương tác vào Giao diện
Tabs.Main:AddToggle("MainFarmToggle", {
    Title = "Bật Auto Farm Cày Cấp",
    Default = false,
    Callback = function(Value)
        getgenv().FreeHubConfig.AutoFarm = Value
        getgenv().FreeHubConfig.MobMagnet = Value
        getgenv().FreeHubConfig.FastAttack = Value
    end
})

Tabs.Main:AddDropdown("WeaponSelect", {
    Title = "Lựa Chọn Vũ Khí Chiến Đấu",
    Values = {"Melee", "Sword", "Fruit"}, "Guns"}
    Default = "Melee",
    Callback = function(Value)
        getgenv().FreeHubConfig.SelectedWeapon = Value
    end
})

Tabs.Settings:AddButton({
    Title = "Bật Chế Độ Giảm Tải Treo Máy",
    Description = "Tắt kết xuất đồ họa 3D để giảm tình trạng nóng máy và lag",
    Callback = function()
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    end
})

-- Mặc định chọn hiển thị Tab đầu tiên khi khởi động
Fluent:SelectTab(1)
