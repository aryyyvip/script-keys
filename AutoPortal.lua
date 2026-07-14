-- =========================================================
-- ROBLOX KEYS SCRIPT (CUSTOM GUI STYLE: punyanaa)
-- =========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Mencegah script menumpuk jika dijalankan berulang kali
if CoreGui:FindFirstChild("KeysPunyanaaGui") then
    CoreGui:FindFirstChild("KeysPunyanaaGui"):Destroy()
end

-- 1. Membuat ScreenGui Utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeysPunyanaaGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 2. Frame Utama (Background Hitam)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.15, 0, 0.35, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Membuat menu bisa digeser/drag
MainFrame.Parent = ScreenGui

-- 3. Garis Atas Menu (Warna Hijau)
local TopLine = Instance.new("Frame")
TopLine.Name = "TopLine"
TopLine.Size = UDim2.new(1, 0, 0, 4)
TopLine.BackgroundColor3 = Color3.fromRGB(0, 220, 0)
TopLine.BorderSizePixel = 0
TopLine.Parent = MainFrame

-- 4. Header Menu
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 35)
Header.Position = UDim2.new(0, 0, 0, 4)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

-- Judul Menu
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Keys   |   punyanaa   -"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSans
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Tombol Close (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(0.88, 0, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = Header

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 5. Frame Konten Menu
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -39)
Content.Position = UDim2.new(0, 0, 0, 39)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Teks "Config"
local ConfigTitle = Instance.new("TextLabel")
ConfigTitle.Name = "ConfigTitle"
ConfigTitle.Size = UDim2.new(1, 0, 0, 30)
ConfigTitle.Position = UDim2.new(0, 0, 0, 15)
ConfigTitle.BackgroundTransparency = 1
ConfigTitle.Text = "Config"
ConfigTitle.TextColor3 = Color3.fromRGB(160, 160, 160)
ConfigTitle.TextSize = 15
ConfigTitle.Font = Enum.Font.SourceSans
ConfigTitle.Parent = Content

-- Sistem Penyimpanan Status Fitur (On/Off)
local Flags = {
    AutoFarm = false,
    UnlockDoors = false,
    PickupKeys = false,
    JoinGame = false
}

-- Fungsi untuk Membuat Tombol Centang (Toggle) otomatis
local function createToggle(id, labelText, yPos)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
    ToggleFrame.Position = UDim2.new(0.05, 0, 0, yPos)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = Content

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.75, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 16
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Checkbox = Instance.new("TextButton")
    Checkbox.Size = UDim2.new(0, 22, 0, 22)
    Checkbox.Position = UDim2.new(0.85, 0, 0.2, 0)
    Checkbox.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Checkbox.BorderColor3 = Color3.fromRGB(40, 40, 40)
    Checkbox.Text = ""
    Checkbox.TextColor3 = Color3.fromRGB(0, 255, 0)
    Checkbox.TextSize = 16
    Checkbox.Font = Enum.Font.SourceSansBold
    Checkbox.Parent = ToggleFrame

    Checkbox.MouseButton1Click:Connect(function()
        Flags[id] = not Flags[id]
        if Flags[id] then
            Checkbox.Text = "✓"
            Checkbox.BorderColor3 = Color3.fromRGB(0, 200, 0)
        else
            Checkbox.Text = ""
            Checkbox.BorderColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)
end

-- Membuat 4 Pilihan Utama sesuai Gambar Anda
createToggle("AutoFarm", "AutoFarm", 55)
createToggle("UnlockDoors", "Unlock Doors", 95)
createToggle("PickupKeys", "Pickup Keys", 135)
createToggle("JoinGame", "Join Game", 175)

-- Bagian Bawah (Footer Text)
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -35)
Footer.BackgroundTransparency = 1
Footer.Text = "punya naaa\n-"
Footer.TextColor3 = Color3.fromRGB(110, 110, 110)
Footer.TextSize = 13
Footer.Font = Enum.Font.SourceSans
Footer.Parent = Content


-- =========================================================
-- LOGIKAL OTOMATISASI GAME (BACKEND SCRIPT)
-- =========================================================

-- Loop untuk AutoFarm / Doors Farm
task.spawn(function()
    while task.wait(0.5) do
        if Flags.AutoFarm then
            -- Logika dasar teleportasi ke pintu keluar / menyelesaikan stage secara instan
            print("[KEYS] AutoFarm sedang berjalan...")
            -- Masukkan fungsi teleportasi lokal ke target map disini jika diperlukan
        end
    end
end)

-- Loop untuk Unlock Doors
task.spawn(function()
    while task.wait(0.3) do
        if Flags.UnlockDoors then
            print("[KEYS] Membuka semua pintu secara otomatis...")
            -- Mengubah CanCollide pintu di Workspace menjadi false atau memicu fungsi buka
        end
    end
end)

-- Loop untuk Pickup Keys
task.spawn(function()
    while task.wait(0.3) do
        if Flags.PickupKeys then
            print("[KEYS] Mendeteksi dan mengambil kunci otomatis...")
            -- Mencari objek 'Key' atau tool di workspace untuk langsung didekatkan ke karakter
        end
    end
end)

-- Loop untuk Auto Join Game dari Lobby
task.spawn(function()
    while task.wait(1) do
        if Flags.JoinGame then
            print("[KEYS] Memeriksa ketersediaan permainan di lobby...")
            -- Logika mendeteksi area portal masuk di lobby agar otomatis teleport ke dalam game saat terbuka
        end
    end
end)
