-- [[ KHỞI TẠO THƯ VIỆN GIAO DIỆN CHUYÊN NGHIỆP ]]
local Fluent = loadstring(game:HttpGet("https://github.com"))()
local SaveManager = loadstring(game:HttpGet("https://githubusercontent.com"))()
local InterfaceManager = loadstring(game:HttpGet("https://githubusercontent.com"))()

-- [[ CẤU HÌNH CỬA SỔ MENU ]]
local Window = Fluent:CreateWindow({
    Title = "Banana Hub Premium Edition",
    SubTitle = "by AI Developer",
    TabWidth = 160,
    Size = Vector2.new(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- [[ KHỞI TẠO CÁC TAB CHỨC NĂNG ]]
local Tabs = {
    Main = Window:AddTab({ Title = "Tự Động (Main)", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Chiến Đấu (Combat)", Icon = "swords" }),
    Settings = Window:AddTab({ Title = "Cài Đặt", Icon = "settings" })
}

-- [[ BIẾN TOÀN CỤC ĐIỀU KHIỂN CHỨC NĂNG ]]
_G.AutoFarm = false
_G.BringMob = false
_G.SelectWeapon = "Melee"

-- [[ TÍNH NĂNG 1: BẬT/TẮT AUTO FARM QUÁI ]]
local ToggleFarm = Tabs.Main:AddToggle("AutoFarmToggle", {Title = "Tự Động Farm Quái (Auto Farm)", Default = false})
ToggleFarm:OnChanged(function(Value)
    _G.AutoFarm = Value
end)

-- [[ TÍNH NĂNG 2: GOM QUÁI LẠI MỘT CHỖ ]]
local ToggleBring = Tabs.Main:AddToggle("BringMobToggle", {Title = "Gom Quái Lại Gần (Bring Mob)", Default = false})
ToggleBring:OnChanged(function(Value)
    _G.BringMob = Value
end)

-- [[ LỰA CHỌN VŨ KHÍ TẤN CÔNG ]]
local DropdownWeapon = Tabs.Main:AddDropdown("WeaponSelect", {
    Title = "Chọn Vũ Khí Sử Dụng",
    Values = {"Melee", "Sword", "Devil Fruit"},
    CurrentValue = "Melee",
    Multi = false,
})
DropdownWeapon:OnChanged(function(Value)
    _G.SelectWeapon = Value
end)

-- [[ HÀM KIỂM TRA VÀ TRANG BỊ VŨ KHÍ ]]
function EquipWeapon()
    local p = game.Players.LocalPlayer
    local bp = p.Backpack
    local char = p.Character
    if char and not char:FindFirstChildOfClass("Tool") then
        for _, tool in pairs(bp:GetChildren()) do
            if tool:IsA("Tool") and (tool.ToolTip == _G.SelectWeapon or _G.SelectWeapon == "Melee" and tool.ToolTip == "Combat") then
                char.Humanoid:EquipTool(tool)
                break
            end
        end
    end
end

-- [[ LOGIC CHẠY NGẦM: TỰ ĐỘNG GOM QUÁI ]]
spawn(function()
    while task.wait(0.1) do
        if _G.BringMob and _G.AutoFarm then
            pcall(function()
                local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        if (enemy.HumanoidRootPart.Position - playerPos).Magnitude < 300 then
                            enemy.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                            enemy.HumanoidRootPart.CanCollide = false
                            if enemy.Humanoid.Health <= 0 then enemy:Destroy() end
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ LOGIC CHẠY NGẦM: TỰ ĐỘNG DI CHUYỂN & TẤN CÔNG ]]
spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                -- Tìm mục tiêu quái gần nhất trong Workspace
                local target = nil
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        target = v
                        break
                    end
                end
                
                -- Nếu tìm thấy quái, tiến hành di chuyển và tấn công
                if target then
                    EquipWeapon()
                    -- Giữ nhân vật bay phía trên đầu quái để tránh mất máu
                    char.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                    
                    -- Kích hoạt click chuột để đánh
                    local VirtualUser = game:GetService("VirtualUser")
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(850, 520))
                end
            end)
        end
    end
end)

-- [[ QUẢN LÝ CẤU HÌNH HỆ THỐNG ]]
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("BananaHubPremium")
SaveManager:SetFolder("BananaHubPremium/configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
Fluent:Notify({
    Title = "Banana Hub",
    Content = "Script đã kích hoạt thành công!",
    Duration = 5
})
SaveManager:LoadAutoloadConfig()
