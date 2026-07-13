-- ==========================================
-- Services & Variables
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BadgeService = game:GetService("BadgeService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Dọn dẹp các bản UI cũ
local OldGUIs = {
    CoreGui:FindFirstChild("Status_UI"),
    CoreGui:FindFirstChild("Status"),
    CoreGui:FindFirstChild("Redz Hub Btn"),
    CoreGui:FindFirstChild("NatAov Hub Btn"),
    CoreGui:FindFirstChild("CoinCard")
}
for _, v in pairs(OldGUIs) do
    if v then v:Destroy() end
end

if not getgenv().NatAovHub then
    getgenv().NatAovHub = { ["Hide Ui"] = false }
end

-- ==========================================
-- Bảng Màu Cao Cấp (Sci-Fi Dashboard)
-- ==========================================
local ACCENT_CYAN   = Color3.fromRGB(0, 238, 255)
local ACCENT_BLUE   = Color3.fromRGB(43, 110, 255)
local ACCENT_PURPLE = Color3.fromRGB(130, 80, 255)
local ACCENT_GOLD   = Color3.fromRGB(255, 200, 60)
local GLASS_BG      = Color3.fromRGB(10, 12, 18)
local PANEL_BG      = Color3.fromRGB(18, 22, 32)
local CARD_BG       = Color3.fromRGB(22, 28, 42)
local DIVIDER_COLOR = Color3.fromRGB(35, 45, 70)
local TEXT_MAIN     = Color3.fromRGB(240, 245, 255)
local TEXT_SUB      = Color3.fromRGB(130, 155, 190)
local SUCCESS_COLOR = Color3.fromRGB(0, 220, 130)
local FAIL_COLOR    = Color3.fromRGB(255, 70, 90)

-- ==========================================
-- Helpers
-- ==========================================
local function AddCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function AddStroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or ACCENT_CYAN
    s.Thickness = thickness or 1.5
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function AddGradient(parent, c0, c1, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c0, c1)
    g.Rotation = rotation or 90
    g.Parent = parent
    return g
end

local function AddShadow(parent, size, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "DropShadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6015895133"
    shadow.ImageColor3 = Color3.fromRGB(0, 5, 10)
    shadow.ImageTransparency = transparency or 0.4
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, size or 30, 1, size or 30)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent
    return shadow
end

-- ==========================================
-- TOP STATUS BAR (Giữ nguyên)
-- ==========================================
local StatusUI = Instance.new("ScreenGui")
StatusUI.Name = "Status_UI"
StatusUI.ResetOnSpawn = false
StatusUI.IgnoreGuiInset = true
StatusUI.Parent = CoreGui

local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(0, 460, 0, 75)
StatusFrame.Position = UDim2.new(0.5, 0, 0, 20)
StatusFrame.AnchorPoint = Vector2.new(0.5, 0)
StatusFrame.BackgroundColor3 = GLASS_BG
StatusFrame.BackgroundTransparency = 0.15
StatusFrame.BorderSizePixel = 0
StatusFrame.Parent = StatusUI
AddCorner(StatusFrame, 20)
AddShadow(StatusFrame, 40, 0.3)
local StatusStroke = AddStroke(StatusFrame, ACCENT_BLUE, 1.5, 0.2)
AddGradient(StatusFrame, Color3.fromRGB(15, 20, 30), GLASS_BG, 135)

local StatusIcon = Instance.new("ImageLabel")
StatusIcon.Size = UDim2.new(0, 36, 0, 36)
StatusIcon.Position = UDim2.new(0, 18, 0.5, 0)
StatusIcon.AnchorPoint = Vector2.new(0, 0.5)
StatusIcon.BackgroundTransparency = 1
StatusIcon.Image = "rbxassetid://120488231660846"
StatusIcon.Parent = StatusFrame

local StatusDivider = Instance.new("Frame")
StatusDivider.Size = UDim2.new(0, 1, 0, 45)
StatusDivider.Position = UDim2.new(0, 68, 0.5, -22)
StatusDivider.BackgroundColor3 = DIVIDER_COLOR
StatusDivider.BorderSizePixel = 0
StatusDivider.Parent = StatusFrame

local StatusTitle = Instance.new("TextLabel")
StatusTitle.Size = UDim2.new(1, -90, 0, 20)
StatusTitle.Position = UDim2.new(0, 80, 0, 10)
StatusTitle.BackgroundTransparency = 1
StatusTitle.Text = "NatAov Hub  <font color='rgb(100,150,255)'>|</font>  Kaitun Blox Fruits"
StatusTitle.RichText = true
StatusTitle.TextColor3 = ACCENT_CYAN
StatusTitle.TextSize = 14
StatusTitle.Font = Enum.Font.GothamBold
StatusTitle.TextXAlignment = Enum.TextXAlignment.Left
StatusTitle.Parent = StatusFrame

local StatusTextLabel = Instance.new("TextLabel")
StatusTextLabel.Size = UDim2.new(1, -90, 0, 18)
StatusTextLabel.Position = UDim2.new(0, 80, 0, 32)
StatusTextLabel.BackgroundTransparency = 1
StatusTextLabel.Text = "🎯 Main Farm: Chờ..."
StatusTextLabel.TextColor3 = TEXT_MAIN
StatusTextLabel.TextSize = 13
StatusTextLabel.Font = Enum.Font.GothamMedium
StatusTextLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusTextLabel.Parent = StatusFrame

local SubTaskLabel = Instance.new("TextLabel")
SubTaskLabel.Size = UDim2.new(1, -90, 0, 18)
SubTaskLabel.Position = UDim2.new(0, 80, 0, 50)
SubTaskLabel.BackgroundTransparency = 1
SubTaskLabel.Text = "📌 Sub Farm: Chờ..."
SubTaskLabel.TextColor3 = TEXT_SUB
SubTaskLabel.TextSize = 12
SubTaskLabel.Font = Enum.Font.Gotham
SubTaskLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTaskLabel.Parent = StatusFrame

task.spawn(function()
    while task.wait() do
        local info = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        local t1 = TweenService:Create(StatusStroke, info, { Color = ACCENT_CYAN, Thickness = 2 })
        local t2 = TweenService:Create(StatusStroke, info, { Color = ACCENT_BLUE, Thickness = 1 })
        t1:Play() t1.Completed:Wait()
        t2:Play() t2.Completed:Wait()
    end
end)

-- ==========================================
-- Functions Logic
-- ==========================================
local function GetInvMap()
    local map = {}
    local ok, inv = pcall(function() return ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory") end)
    if ok and inv then
        for _, v in pairs(inv) do
            if typeof(v) == "table" and v.Name then map[v.Name] = true end
        end
    end
    return map
end

local function FormatNumber(n)
    local formatted = tostring(n)
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

-- ==========================================
-- COINCARD — UPGRADED CHECKER DASHBOARD
-- ==========================================
local blur = Instance.new("BlurEffect")
blur.Name = "NatAov Hub Blur"
blur.Parent = Lighting
blur.Size = getgenv().NatAovHub["Hide Ui"] and 0 or 24

local CoinCard = Instance.new("ScreenGui")
CoinCard.Name = "CoinCard"
CoinCard.Parent = CoreGui
CoinCard.ResetOnSpawn = false
CoinCard.DisplayOrder = 20
CoinCard.Enabled = not getgenv().NatAovHub["Hide Ui"]

-- ── Main Panel ──────────────────────────────────────────────────
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(8, 10, 16)
Main.BackgroundTransparency = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 660, 0, 470)
Main.BorderSizePixel = 0
Main.Parent = CoinCard
AddCorner(Main, 16)
AddShadow(Main, 70, 0.55)

-- Gradient nền tím-xanh vi tế
local MainGrad = Instance.new("UIGradient")
MainGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(14, 16, 28)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 12, 20)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(8,  10, 16)),
})
MainGrad.Rotation = 145
MainGrad.Parent = Main

-- Viền ngoài phát sáng nhẹ
local UIStrokeMain = AddStroke(Main, ACCENT_BLUE, 1.5, 0.5)

-- Dot-grid pattern
local Pattern = Instance.new("ImageLabel")
Pattern.Size = UDim2.new(1, 0, 1, 0)
Pattern.BackgroundTransparency = 1
Pattern.Image = "rbxassetid://8992237072"
Pattern.ImageTransparency = 0.96
Pattern.ScaleType = Enum.ScaleType.Tile
Pattern.TileSize = UDim2.new(0, 22, 0, 22)
Pattern.ZIndex = 1
Pattern.Parent = Main
AddCorner(Pattern, 16)

local MainScale = Instance.new("UIScale")
MainScale.Scale = getgenv().NatAovHub["Hide Ui"] and 0 or 1
MainScale.Parent = Main

-- ── Header Bar ──────────────────────────────────────────────────
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundColor3 = Color3.fromRGB(12, 15, 24)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = Main
AddCorner(Header, 16)

-- fix góc dưới header
local HeaderBottomFix = Instance.new("Frame")
HeaderBottomFix.Size = UDim2.new(1, 0, 0, 16)
HeaderBottomFix.Position = UDim2.new(0, 0, 1, -16)
HeaderBottomFix.BackgroundColor3 = Color3.fromRGB(12, 15, 24)
HeaderBottomFix.BackgroundTransparency = 0
HeaderBottomFix.BorderSizePixel = 0
HeaderBottomFix.ZIndex = 2
HeaderBottomFix.Parent = Header

-- Đường sáng chân header — gradient cyan → purple
local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, 0, 0, 1)
HeaderLine.Position = UDim2.new(0, 0, 1, 0)
HeaderLine.BackgroundColor3 = ACCENT_CYAN
HeaderLine.BorderSizePixel = 0
HeaderLine.ZIndex = 3
HeaderLine.Parent = Header
AddGradient(HeaderLine,
    ACCENT_CYAN,
    ACCENT_PURPLE,
    0
)

local TopLogo = Instance.new("ImageLabel")
TopLogo.Size = UDim2.new(0, 28, 0, 28)
TopLogo.Position = UDim2.new(0, 16, 0.5, -14)
TopLogo.BackgroundTransparency = 1
TopLogo.Image = "rbxassetid://120488231660846"
TopLogo.ZIndex = 3
TopLogo.Parent = Header

-- Dot phân cách
local HeaderDot = Instance.new("Frame")
HeaderDot.Size = UDim2.new(0, 1, 0, 28)
HeaderDot.Position = UDim2.new(0, 54, 0.5, -14)
HeaderDot.BackgroundColor3 = DIVIDER_COLOR
HeaderDot.BorderSizePixel = 0
HeaderDot.ZIndex = 3
HeaderDot.Parent = Header

local TopTitle = Instance.new("TextLabel")
TopTitle.Size = UDim2.new(0, 260, 1, 0)
TopTitle.Position = UDim2.new(0, 64, 0, 0)
TopTitle.BackgroundTransparency = 1
TopTitle.Text = "NatAov  <font color='rgb(130,80,255)'>Checker</font>"
TopTitle.RichText = true
TopTitle.TextColor3 = TEXT_MAIN
TopTitle.TextSize = 15
TopTitle.Font = Enum.Font.GothamBold
TopTitle.TextXAlignment = Enum.TextXAlignment.Left
TopTitle.ZIndex = 3
TopTitle.Parent = Header

-- Badge version kéo phải
local VersionBadge = Instance.new("Frame")
VersionBadge.Size = UDim2.new(0, 130, 0, 22)
VersionBadge.Position = UDim2.new(1, -146, 0.5, -11)
VersionBadge.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
VersionBadge.BorderSizePixel = 0
VersionBadge.ZIndex = 3
VersionBadge.Parent = Header
AddCorner(VersionBadge, 11)
AddStroke(VersionBadge, ACCENT_PURPLE, 1, 0.3)

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, 0, 1, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = "By NatAovHub & Arya 3TN"
VersionText.TextColor3 = ACCENT_PURPLE
VersionText.TextSize = 10
VersionText.Font = Enum.Font.GothamMedium
VersionText.ZIndex = 3
VersionText.Parent = VersionBadge

-- ── Body layout — 3 kolom ──────────────────────────────────────
-- Kolom Trái : Stats Cards (2x2)
-- Kolom Tengah : Special Items (6 pills)
-- Kolom Phải : Inventory Scroll

local BODY_Y = 60   -- y bắt đầu body
local BODY_H = 390  -- chiều cao body
local COL_PAD = 14  -- padding ngoài
local COL_GAP = 10  -- khoảng cách giữa cột

-- Tỉ lệ: 220 | 220 | 180 = 620 + 3*14 = nằm trong 660
local COL1_W = 215
local COL2_W = 215
local COL3_W = 175

local COL1_X = COL_PAD
local COL2_X = COL1_X + COL1_W + COL_GAP
local COL3_X = COL2_X + COL2_W + COL_GAP

-- ── Helper tạo section label ────────────────────────────────────
local function SectionLabel(parent, text, x, y)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -x * 2, 0, 18)
    lbl.Position = UDim2.new(0, x, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = TEXT_SUB
    lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 3
    lbl.Parent = parent
    return lbl
end

-- ═══════════════════════════════════════════════════════════════
-- KOLOM 1 — ACCOUNT STATS (2×2 card grid)
-- ═══════════════════════════════════════════════════════════════
local StatsCol = Instance.new("Frame")
StatsCol.Size = UDim2.new(0, COL1_W, 0, BODY_H)
StatsCol.Position = UDim2.new(0, COL1_X, 0, BODY_Y)
StatsCol.BackgroundTransparency = 1
StatsCol.ZIndex = 2
StatsCol.Parent = Main

SectionLabel(StatsCol, "▸  ACCOUNT OVERVIEW", 0, 0)

-- Đường accent dưới section label
local AccentLine1 = Instance.new("Frame")
AccentLine1.Size = UDim2.new(0, 50, 0, 1)
AccentLine1.Position = UDim2.new(0, 0, 0, 18)
AccentLine1.BackgroundColor3 = ACCENT_CYAN
AccentLine1.BorderSizePixel = 0
AccentLine1.ZIndex = 3
AccentLine1.Parent = StatsCol
AddGradient(AccentLine1, ACCENT_CYAN, Color3.fromRGB(0,0,0), 0)

-- Stat card factory
local function MakeStatCard(parent, px, py, w, h, icon, title)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, w, 0, h)
    card.Position = UDim2.new(0, px, 0, py)
    card.BackgroundColor3 = CARD_BG
    card.BackgroundTransparency = 0
    card.BorderSizePixel = 0
    card.ZIndex = 3
    card.Parent = parent
    AddCorner(card, 10)
    AddStroke(card, DIVIDER_COLOR, 1, 0)

    -- Gradient nhẹ trong card
    local cg = Instance.new("UIGradient")
    cg.Color = ColorSequence.new(
        Color3.fromRGB(28, 34, 52),
        Color3.fromRGB(18, 22, 34)
    )
    cg.Rotation = 135
    cg.Parent = card

    -- Icon box
    local iconBox = Instance.new("Frame")
    iconBox.Size = UDim2.new(0, 28, 0, 28)
    iconBox.Position = UDim2.new(0, 10, 0, 10)
    iconBox.BackgroundColor3 = Color3.fromRGB(20, 24, 40)
    iconBox.BackgroundTransparency = 0
    iconBox.BorderSizePixel = 0
    iconBox.ZIndex = 4
    iconBox.Parent = card
    AddCorner(iconBox, 6)
    AddStroke(iconBox, DIVIDER_COLOR, 1, 0.3)

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(1, 0, 1, 0)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icon
    iconLbl.TextSize = 14
    iconLbl.ZIndex = 5
    iconLbl.Parent = iconBox

    -- Title
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -55, 0, 14)
    titleLbl.Position = UDim2.new(0, 46, 0, 10)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = TEXT_SUB
    titleLbl.TextSize = 10
    titleLbl.Font = Enum.Font.GothamMedium
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4
    titleLbl.Parent = card

    -- Value
    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(1, -55, 0, 22)
    valLbl.Position = UDim2.new(0, 46, 0, 24)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = "—"
    valLbl.RichText = true
    valLbl.TextColor3 = TEXT_MAIN
    valLbl.TextSize = 13
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Left
    valLbl.TextTruncate = Enum.TextTruncate.AtEnd
    valLbl.ZIndex = 4
    valLbl.Parent = card

    return valLbl, card
end

local CARD_W = (COL1_W - COL_GAP) / 2
local CARD_H = 62
local CARD_GAP = 8
local CARD_START_Y = 26

local LevelVal,  LevelCard  = MakeStatCard(StatsCol, 0,                    CARD_START_Y,               CARD_W, CARD_H, "⚡", "LEVEL")
local RaceVal,   RaceCard   = MakeStatCard(StatsCol, CARD_W + COL_GAP,     CARD_START_Y,               CARD_W, CARD_H, "🏅", "RACE")
local BeliVal,   BeliCard   = MakeStatCard(StatsCol, 0,                    CARD_START_Y + CARD_H + CARD_GAP, CARD_W, CARD_H, "💰", "BELI")
local FragVal,   FragCard    = MakeStatCard(StatsCol, CARD_W + COL_GAP,     CARD_START_Y + CARD_H + CARD_GAP, CARD_W, CARD_H, "💠", "FRAGMENTS")

-- Sea badge indicator (full-width card bên dưới)
local BadgeCard = Instance.new("Frame")
BadgeCard.Size = UDim2.new(1, 0, 0, 42)
BadgeCard.Position = UDim2.new(0, 0, 0, CARD_START_Y + (CARD_H + CARD_GAP) * 2)
BadgeCard.BackgroundColor3 = CARD_BG
BadgeCard.BackgroundTransparency = 0
BadgeCard.BorderSizePixel = 0
BadgeCard.ZIndex = 3
BadgeCard.Parent = StatsCol
AddCorner(BadgeCard, 10)
AddStroke(BadgeCard, DIVIDER_COLOR, 1, 0)
AddGradient(BadgeCard, Color3.fromRGB(28, 34, 52), Color3.fromRGB(18, 22, 34), 135)

local BadgeDotLabel = Instance.new("TextLabel")
BadgeDotLabel.Size = UDim2.new(0, 28, 1, 0)
BadgeDotLabel.BackgroundTransparency = 1
BadgeDotLabel.Text = "🔴"
BadgeDotLabel.TextSize = 14
BadgeDotLabel.ZIndex = 4
BadgeDotLabel.Parent = BadgeCard

local BadgeTitleLbl = Instance.new("TextLabel")
BadgeTitleLbl.Size = UDim2.new(1, -40, 0, 14)
BadgeTitleLbl.Position = UDim2.new(0, 32, 0, 7)
BadgeTitleLbl.BackgroundTransparency = 1
BadgeTitleLbl.Text = "SEA 3 BADGE"
BadgeTitleLbl.TextColor3 = TEXT_SUB
BadgeTitleLbl.TextSize = 10
BadgeTitleLbl.Font = Enum.Font.GothamBold
BadgeTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
BadgeTitleLbl.ZIndex = 4
BadgeTitleLbl.Parent = BadgeCard

local BadgeStatusLbl = Instance.new("TextLabel")
BadgeStatusLbl.Size = UDim2.new(1, -40, 0, 16)
BadgeStatusLbl.Position = UDim2.new(0, 32, 0, 20)
BadgeStatusLbl.BackgroundTransparency = 1
BadgeStatusLbl.Text = "Chưa có"
BadgeStatusLbl.TextColor3 = FAIL_COLOR
BadgeStatusLbl.TextSize = 12
BadgeStatusLbl.Font = Enum.Font.GothamBold
BadgeStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
BadgeStatusLbl.ZIndex = 4
BadgeStatusLbl.Parent = BadgeCard

-- Quick tip lore-flavor dưới cùng kolom 1
local TipBox = Instance.new("Frame")
TipBox.Size = UDim2.new(1, 0, 0, 50)
TipBox.Position = UDim2.new(0, 0, 0, CARD_START_Y + (CARD_H + CARD_GAP) * 2 + 42 + CARD_GAP)
TipBox.BackgroundColor3 = Color3.fromRGB(16, 20, 32)
TipBox.BackgroundTransparency = 0.2
TipBox.BorderSizePixel = 0
TipBox.ZIndex = 3
TipBox.Parent = StatsCol
AddCorner(TipBox, 8)
AddStroke(TipBox, Color3.fromRGB(30, 40, 60), 1, 0)

local TipIcon = Instance.new("TextLabel")
TipIcon.Size = UDim2.new(0, 26, 1, 0)
TipIcon.BackgroundTransparency = 1
TipIcon.Text = "💡"
TipIcon.TextSize = 13
TipIcon.ZIndex = 4
TipIcon.Parent = TipBox

local TipText = Instance.new("TextLabel")
TipText.Size = UDim2.new(1, -32, 1, 0)
TipText.Position = UDim2.new(0, 30, 0, 0)
TipText.BackgroundTransparency = 1
TipText.Text = "Data cập nhật mỗi giây khi dashboard mở."
TipText.TextColor3 = Color3.fromRGB(90, 110, 145)
TipText.TextSize = 10
TipText.Font = Enum.Font.Gotham
TipText.TextXAlignment = Enum.TextXAlignment.Left
TipText.TextWrapped = true
TipText.ZIndex = 4
TipText.Parent = TipBox

-- ═══════════════════════════════════════════════════════════════
-- KOLOM 2 — SPECIAL ITEMS (Pill rows với glow state)
-- ═══════════════════════════════════════════════════════════════
local SpecialCol = Instance.new("Frame")
SpecialCol.Size = UDim2.new(0, COL2_W, 0, BODY_H)
SpecialCol.Position = UDim2.new(0, COL2_X, 0, BODY_Y)
SpecialCol.BackgroundTransparency = 1
SpecialCol.ZIndex = 2
SpecialCol.Parent = Main

SectionLabel(SpecialCol, "▸  SPECIAL ITEMS", 0, 0)

local AccentLine2 = Instance.new("Frame")
AccentLine2.Size = UDim2.new(0, 50, 0, 1)
AccentLine2.Position = UDim2.new(0, 0, 0, 18)
AccentLine2.BackgroundColor3 = ACCENT_PURPLE
AccentLine2.BorderSizePixel = 0
AccentLine2.ZIndex = 3
AccentLine2.Parent = SpecialCol
AddGradient(AccentLine2, ACCENT_PURPLE, Color3.fromRGB(0,0,0), 0)

-- Special pill factory — mỗi pill full width, có glow bar trái
local PILL_H     = 48
local PILL_GAP   = 7
local PILL_START = 26

local specialPills = {}

local function MakeSpecialPill(idx, itemName, itemIcon)
    local py = PILL_START + (idx - 1) * (PILL_H + PILL_GAP)

    local pill = Instance.new("Frame")
    pill.Size = UDim2.new(1, 0, 0, PILL_H)
    pill.Position = UDim2.new(0, 0, 0, py)
    pill.BackgroundColor3 = CARD_BG
    pill.BackgroundTransparency = 0
    pill.BorderSizePixel = 0
    pill.ZIndex = 3
    pill.Parent = SpecialCol
    AddCorner(pill, 8)
    local stroke = AddStroke(pill, DIVIDER_COLOR, 1, 0)

    -- Gradient card
    AddGradient(pill, Color3.fromRGB(25, 30, 46), Color3.fromRGB(18, 22, 34), 135)

    -- Accent bar kiri (warna berubah sesuai state)
    local accentBar = Instance.new("Frame")
    accentBar.Size = UDim2.new(0, 3, 1, -12)
    accentBar.Position = UDim2.new(0, 0, 0.5, 0)
    accentBar.AnchorPoint = Vector2.new(0, 0.5)
    accentBar.BackgroundColor3 = FAIL_COLOR
    accentBar.BorderSizePixel = 0
    accentBar.ZIndex = 4
    accentBar.Parent = pill
    AddCorner(accentBar, 2)

    -- Icon
    local iconL = Instance.new("TextLabel")
    iconL.Size = UDim2.new(0, 28, 0, 28)
    iconL.Position = UDim2.new(0, 12, 0.5, -14)
    iconL.BackgroundTransparency = 1
    iconL.Text = itemIcon
    iconL.TextSize = 16
    iconL.ZIndex = 4
    iconL.Parent = pill

    -- Item name
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -90, 0, 16)
    nameLbl.Position = UDim2.new(0, 46, 0, 9)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = itemName
    nameLbl.TextColor3 = TEXT_MAIN
    nameLbl.TextSize = 12
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 4
    nameLbl.Parent = pill

    -- Status badge (kanan)
    local statusBadge = Instance.new("Frame")
    statusBadge.Size = UDim2.new(0, 58, 0, 20)
    statusBadge.Position = UDim2.new(1, -66, 0.5, -10)
    statusBadge.BackgroundColor3 = Color3.fromRGB(60, 20, 25)
    statusBadge.BorderSizePixel = 0
    statusBadge.ZIndex = 4
    statusBadge.Parent = pill
    AddCorner(statusBadge, 10)

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "✘  NONE"
    statusText.TextColor3 = FAIL_COLOR
    statusText.TextSize = 10
    statusText.Font = Enum.Font.GothamBold
    statusText.ZIndex = 5
    statusText.Parent = statusBadge

    -- Sub label (di bawah name)
    local subLbl = Instance.new("TextLabel")
    subLbl.Size = UDim2.new(1, -90, 0, 14)
    subLbl.Position = UDim2.new(0, 46, 0, 26)
    subLbl.BackgroundTransparency = 1
    subLbl.Text = "Chưa sở hữu"
    subLbl.TextColor3 = FAIL_COLOR
    subLbl.TextSize = 10
    subLbl.Font = Enum.Font.Gotham
    subLbl.TextXAlignment = Enum.TextXAlignment.Left
    subLbl.ZIndex = 4
    subLbl.Parent = pill

    return {
        pill       = pill,
        stroke     = stroke,
        accentBar  = accentBar,
        statusBadge = statusBadge,
        statusText = statusText,
        subLbl     = subLbl,
    }
end

local GH  = MakeSpecialPill(1, "GodHuman",          "👊")
local CDK = MakeSpecialPill(2, "Cursed Dual Katana", "⚔️")
local VH  = MakeSpecialPill(3, "Valkyrie Helm",      "🪖")
local SG  = MakeSpecialPill(4, "Skull Guitar",       "🎸")
local MF  = MakeSpecialPill(5, "Mirror Fractal",     "🪞")
local PL  = MakeSpecialPill(6, "Pull Lever",         "🔑")

-- State update function — gọi per-item
local function UpdatePill(t, hasItem)
    if hasItem then
        t.accentBar.BackgroundColor3  = SUCCESS_COLOR
        t.stroke.Color                = SUCCESS_COLOR
        t.stroke.Transparency         = 0.4
        t.statusBadge.BackgroundColor3 = Color3.fromRGB(15, 50, 35)
        t.statusText.Text             = "✔  HAVE"
        t.statusText.TextColor3       = SUCCESS_COLOR
        t.subLbl.Text                 = "Đã sở hữu"
        t.subLbl.TextColor3           = SUCCESS_COLOR
    else
        t.accentBar.BackgroundColor3  = FAIL_COLOR
        t.stroke.Color                = DIVIDER_COLOR
        t.stroke.Transparency         = 0
        t.statusBadge.BackgroundColor3 = Color3.fromRGB(60, 20, 25)
        t.statusText.Text             = "✘  NONE"
        t.statusText.TextColor3       = FAIL_COLOR
        t.subLbl.Text                 = "Chưa sở hữu"
        t.subLbl.TextColor3           = FAIL_COLOR
    end
end

-- ═══════════════════════════════════════════════════════════════
-- KOLOM 3 — INVENTORY SCROLL
-- ═══════════════════════════════════════════════════════════════
local InvCol = Instance.new("Frame")
InvCol.Size = UDim2.new(0, COL3_W, 0, BODY_H)
InvCol.Position = UDim2.new(0, COL3_X, 0, BODY_Y)
InvCol.BackgroundColor3 = CARD_BG
InvCol.BackgroundTransparency = 0
InvCol.BorderSizePixel = 0
InvCol.ZIndex = 2
InvCol.Parent = Main
AddCorner(InvCol, 10)
AddStroke(InvCol, DIVIDER_COLOR, 1, 0)
AddGradient(InvCol, Color3.fromRGB(20, 24, 38), Color3.fromRGB(14, 17, 26), 135)

-- Header kolom inventory
local InvHeader = Instance.new("Frame")
InvHeader.Size = UDim2.new(1, 0, 0, 34)
InvHeader.BackgroundColor3 = Color3.fromRGB(14, 18, 28)
InvHeader.BackgroundTransparency = 0
InvHeader.BorderSizePixel = 0
InvHeader.ZIndex = 3
InvHeader.Parent = InvCol
AddCorner(InvHeader, 10)

local InvHeaderFix = Instance.new("Frame")
InvHeaderFix.Size = UDim2.new(1, 0, 0, 10)
InvHeaderFix.Position = UDim2.new(0, 0, 1, -10)
InvHeaderFix.BackgroundColor3 = Color3.fromRGB(14, 18, 28)
InvHeaderFix.BackgroundTransparency = 0
InvHeaderFix.BorderSizePixel = 0
InvHeaderFix.ZIndex = 3
InvHeaderFix.Parent = InvHeader

local InvTitleLabel = Instance.new("TextLabel")
InvTitleLabel.Size = UDim2.new(1, -12, 1, 0)
InvTitleLabel.Position = UDim2.new(0, 12, 0, 0)
InvTitleLabel.BackgroundTransparency = 1
InvTitleLabel.Text = "🎒  INVENTORY"
InvTitleLabel.TextColor3 = ACCENT_GOLD
InvTitleLabel.TextSize = 11
InvTitleLabel.Font = Enum.Font.GothamBold
InvTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
InvTitleLabel.ZIndex = 4
InvTitleLabel.Parent = InvHeader

local InvDivider = Instance.new("Frame")
InvDivider.Size = UDim2.new(1, 0, 0, 1)
InvDivider.Position = UDim2.new(0, 0, 1, 0)
InvDivider.BackgroundColor3 = DIVIDER_COLOR
InvDivider.BorderSizePixel = 0
InvDivider.ZIndex = 4
InvDivider.Parent = InvHeader

-- Count badge
local CountBadge = Instance.new("Frame")
CountBadge.Size = UDim2.new(0, 26, 0, 16)
CountBadge.Position = UDim2.new(1, -34, 0.5, -8)
CountBadge.BackgroundColor3 = Color3.fromRGB(40, 32, 16)
CountBadge.BorderSizePixel = 0
CountBadge.ZIndex = 4
CountBadge.Parent = InvHeader
AddCorner(CountBadge, 8)

local CountText = Instance.new("TextLabel")
CountText.Size = UDim2.new(1, 0, 1, 0)
CountText.BackgroundTransparency = 1
CountText.Text = "0"
CountText.TextColor3 = ACCENT_GOLD
CountText.TextSize = 10
CountText.Font = Enum.Font.GothamBold
CountText.ZIndex = 5
CountText.Parent = CountBadge

-- Scroll frame
local TypeAccountScroll = Instance.new("ScrollingFrame")
TypeAccountScroll.Name = "TypeAccountScroll"
TypeAccountScroll.BackgroundTransparency = 1
TypeAccountScroll.Position = UDim2.new(0, 6, 0, 38)
TypeAccountScroll.Size = UDim2.new(1, -12, 1, -44)
TypeAccountScroll.ScrollBarThickness = 2
TypeAccountScroll.ScrollBarImageColor3 = ACCENT_GOLD
TypeAccountScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TypeAccountScroll.ZIndex = 3
TypeAccountScroll.Parent = InvCol

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = TypeAccountScroll

-- ── Footer ──────────────────────────────────────────────────────
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 28)
Footer.Position = UDim2.new(0, 0, 1, -28)
Footer.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
Footer.BackgroundTransparency = 0
Footer.BorderSizePixel = 0
Footer.ZIndex = 2
Footer.Parent = Main
AddCorner(Footer, 16)

local FooterTopFix = Instance.new("Frame")
FooterTopFix.Size = UDim2.new(1, 0, 0, 16)
FooterTopFix.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
FooterTopFix.BackgroundTransparency = 0
FooterTopFix.BorderSizePixel = 0
FooterTopFix.ZIndex = 2
FooterTopFix.Parent = Footer

-- Accent line atas footer
local FooterLine = Instance.new("Frame")
FooterLine.Size = UDim2.new(1, 0, 0, 1)
FooterLine.BackgroundColor3 = DIVIDER_COLOR
FooterLine.BorderSizePixel = 0
FooterLine.ZIndex = 3
FooterLine.Parent = Footer

-- Discord + branding
local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.BackgroundTransparency = 1
FooterText.Text = "discord.gg/UefGEBySJ8  •  NatAov Community"
FooterText.TextColor3 = Color3.fromRGB(70, 90, 130)
FooterText.TextSize = 10
FooterText.Font = Enum.Font.Gotham
FooterText.ZIndex = 3
FooterText.Parent = Footer

-- Live indicator dot (kiri footer)
local LiveDot = Instance.new("Frame")
LiveDot.Size = UDim2.new(0, 6, 0, 6)
LiveDot.Position = UDim2.new(0, 12, 0.5, -3)
LiveDot.BackgroundColor3 = SUCCESS_COLOR
LiveDot.BorderSizePixel = 0
LiveDot.ZIndex = 4
LiveDot.Parent = Footer
AddCorner(LiveDot, 3)

task.spawn(function()
    while task.wait(0.9) do
        TweenService:Create(LiveDot, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {BackgroundTransparency = 0.8}):Play()
        task.wait(0.45)
        TweenService:Create(LiveDot, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
    end
end)

local LiveLabel = Instance.new("TextLabel")
LiveLabel.Size = UDim2.new(0, 40, 1, 0)
LiveLabel.Position = UDim2.new(0, 22, 0, 0)
LiveLabel.BackgroundTransparency = 1
LiveLabel.Text = "LIVE"
LiveLabel.TextColor3 = SUCCESS_COLOR
LiveLabel.TextSize = 9
LiveLabel.Font = Enum.Font.GothamBold
LiveLabel.TextXAlignment = Enum.TextXAlignment.Left
LiveLabel.ZIndex = 4
LiveLabel.Parent = Footer

-- ==========================================
-- TOGGLE BUTTON (Giữ nguyên cấu trúc, nâng style)
-- ==========================================
local NatAovHubBtn = Instance.new("ScreenGui")
NatAovHubBtn.Name = "NatAov Hub Btn"
NatAovHubBtn.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NatAovHubBtn.DisplayOrder = 10
NatAovHubBtn.ResetOnSpawn = false
NatAovHubBtn.Parent = CoreGui

local ToggleBtn = Instance.new("Frame")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.AnchorPoint = Vector2.new(0.5, 0.5)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(12, 15, 24)
ToggleBtn.Position = UDim2.new(0, 50, 0.1, 20)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = NatAovHubBtn
AddCorner(ToggleBtn, 25)
AddShadow(ToggleBtn, 25, 0.3)
local BtnStroke = AddStroke(ToggleBtn, ACCENT_CYAN, 2)

local BtnImage = Instance.new("ImageLabel")
BtnImage.AnchorPoint = Vector2.new(0.5, 0.5)
BtnImage.BackgroundTransparency = 1
BtnImage.Position = UDim2.new(0.5, 0, 0.5, 0)
BtnImage.Size = UDim2.new(0, 32, 0, 32)
BtnImage.Image = "rbxassetid://120488231660846"
BtnImage.Parent = ToggleBtn

local BtnHitbox = Instance.new("TextButton")
BtnHitbox.BackgroundTransparency = 1
BtnHitbox.Size = UDim2.new(1, 0, 1, 0)
BtnHitbox.Text = ""
BtnHitbox.Parent = ToggleBtn

task.spawn(function()
    while task.wait() do
        local inf = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        local t1 = TweenService:Create(BtnStroke, inf, { Transparency = 0.8, Thickness = 3 })
        local t2 = TweenService:Create(BtnStroke, inf, { Transparency = 0, Thickness = 2 })
        t1:Play() t1.Completed:Wait()
        t2:Play() t2.Completed:Wait()
    end
end)

local isCoinCardOpen = not getgenv().NatAovHub["Hide Ui"]
local tweenPop  = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenHide = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)

BtnHitbox.MouseButton1Down:Connect(function()
    isCoinCardOpen = not isCoinCardOpen

    TweenService:Create(BtnImage, tweenPop, {
        Size = isCoinCardOpen and UDim2.new(0, 32, 0, 32) or UDim2.new(0, 24, 0, 24)
    }):Play()
    BtnStroke.Color = isCoinCardOpen and ACCENT_CYAN or Color3.fromRGB(80, 80, 100)

    if isCoinCardOpen then
        CoinCard.Enabled = true
        TweenService:Create(MainScale, tweenPop, { Scale = 1 }):Play()
        TweenService:Create(blur, TweenInfo.new(0.3), { Size = 24 }):Play()
    else
        local closeTween = TweenService:Create(MainScale, tweenHide, { Scale = 0 })
        closeTween:Play()
        TweenService:Create(blur, TweenInfo.new(0.3), { Size = 0 }):Play()
        closeTween.Completed:Once(function()
            if not isCoinCardOpen then CoinCard.Enabled = false end
        end)
    end
end)

-- ==========================================
-- SYNC LOGIC
-- ==========================================
local shownItems = {}

local function SyncInventory()
    local ok, inventory = pcall(function()
        return ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")
    end)
    if not ok or not inventory then return end

    local current = {}
    local count = 0

    for _, v in pairs(inventory) do
        if typeof(v) == "table" and v.Name then
            current[v.Name] = true
            count += 1

            if not shownItems[v.Name] then
                -- Item row trong scroll
                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 28)
                row.BackgroundColor3 = Color3.fromRGB(26, 32, 48)
                row.BackgroundTransparency = 0.3
                row.BorderSizePixel = 0
                row.ZIndex = 4
                row.Parent = TypeAccountScroll
                AddCorner(row, 5)

                -- Accent dot
                local dot = Instance.new("Frame")
                dot.Size = UDim2.new(0, 4, 0, 4)
                dot.Position = UDim2.new(0, 8, 0.5, -2)
                dot.BackgroundColor3 = ACCENT_CYAN
                dot.BorderSizePixel = 0
                dot.ZIndex = 5
                dot.Parent = row
                AddCorner(dot, 2)

                local label = Instance.new("TextLabel")
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, -22, 1, 0)
                label.Position = UDim2.new(0, 18, 0, 0)
                label.Font = Enum.Font.GothamMedium
                label.TextSize = 11
                label.TextColor3 = TEXT_SUB
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Text = v.Name
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.ZIndex = 5
                label.Parent = row

                shownItems[v.Name] = row
            end
        end
    end

    -- Xóa item không còn trong inventory
    for name, frame in pairs(shownItems) do
        if not current[name] then
            frame:Destroy()
            shownItems[name] = nil
        end
    end

    CountText.Text = tostring(count)
end

-- Main update loop
local badgeId = 2125253113

task.spawn(function()
    while task.wait(1) do
        if CoinCard.Enabled and MainScale.Scale > 0.1 then

            -- Inventory sync
            SyncInventory()

            local inv  = GetInvMap()
            local char = player.Character
            local bag  = player.Backpack

            -- Special Items
            local hasValk = inv["Valkyrie Helm"] or (char and char:FindFirstChild("Valkyrie Helm"))
            UpdatePill(VH, hasValk)

            local hasCDK = inv["Cursed Dual Katana"]
                or bag:FindFirstChild("Cursed Dual Katana")
                or (char and char:FindFirstChild("Cursed Dual Katana"))
            UpdatePill(CDK, hasCDK)

            local okG, resG = pcall(function()
                return ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman", true)
            end)
            UpdatePill(GH, okG and (resG == 1 or resG == 2))

            local hasSG = inv["Skull Guitar"]
                or bag:FindFirstChild("Skull Guitar")
                or (char and char:FindFirstChild("Skull Guitar"))
            UpdatePill(SG, hasSG)

            UpdatePill(MF, inv["Mirror Fractal"])

            local okL, resL = pcall(function()
                return ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor")
            end)
            UpdatePill(PL, okL and (resL == true or resL == "true"))

            -- Stats
            local hasBadge = false
            pcall(function() hasBadge = BadgeService:UserHasBadgeAsync(player.UserId, badgeId) end)

            LevelVal.Text = tostring(player.Data.Level.Value)

            -- Badge card update
            if hasBadge then
                BadgeDotLabel.Text         = "🟢"
                BadgeStatusLbl.Text        = "Đã có badge Sea 3"
                BadgeStatusLbl.TextColor3  = SUCCESS_COLOR
            else
                BadgeDotLabel.Text         = "🔴"
                BadgeStatusLbl.Text        = "Chưa có badge Sea 3"
                BadgeStatusLbl.TextColor3  = FAIL_COLOR
            end

            RaceVal.Text = player.Data.Race.Value
            BeliVal.Text = FormatNumber(player.Data.Beli.Value)
            FragVal.Text = FormatNumber(player.Data.Fragments.Value)
        end
    end
end)
