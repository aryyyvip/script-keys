-- Menunggu game dimuat sepenuhnya
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ProximityPromptService = game:GetService("ProximityPromptService") -- Service penting untuk interaksi

-- Membuat wadah variabel untuk tombol On/Off
local Toggles = {
    AutoFarm = false,
    UnlockDoors = false,
    PickupKeys = false,
    JoinGame = false
}

-- 1. MEMBUAT TAMPILAN GUI (Sesuai Gambar Terbaru)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomKeysGUI"
-- Memasukkan GUI ke CoreGui agar tidak mudah terdeteksi anti-cheat
ScreenGui.Parent = CoreGui 

-- Membuat kotak hitam utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Hitam gelap
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Agar GUI bisa digeser dengan mouse
MainFrame.Parent = ScreenGui

-- Membuat garis hijau di bagian atas
local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, 0, 0, 2)
TopLine.Position = UDim2.new(0, 0, 0, 35)
TopLine.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Hijau terang
TopLine.BorderSizePixel = 0
TopLine.Parent = MainFrame

-- Membuat Judul "Keys | punyanaa -" (Diperbarui dari gambar input)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Keys | punyanaa -" -- Teks diperbarui verbatim
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.Code
Title.Parent = MainFrame

-- Teks "Config" di tengah
local ConfigLabel = Instance.new("TextLabel")
ConfigLabel.Size = UDim2.new(1, 0, 0, 30)
ConfigLabel.Position = UDim2.new(0, 0, 0, 80)
ConfigLabel.BackgroundTransparency = 1
ConfigLabel.Text = "Config"
ConfigLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
ConfigLabel.TextSize = 16
ConfigLabel.Font = Enum.Font.SourceSans
ConfigLabel.Parent = MainFrame

-- Fungsi untuk membuat baris tombol centang (Checkboxes)
local function CreateToggle(name, yPos, varName)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 30)
    Label.Position = UDim2.new(0, 15, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextSize = 16
    Label.Font = Enum.Font.SourceSans
    Label.Parent = MainFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 20, 0, 20)
    Button.Position = UDim2.new(0.85, 0, 0, yPos + 5)
    Button.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Button.BorderColor3 = Color3.fromRGB(40, 40, 40)
    Button.Text = "" -- Memulai tanpa centang
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Parent = MainFrame

    -- Logika jika tombol ditekan
    Button.MouseButton1Click:Connect(function()
        Toggles[varName] = not Toggles[varName] -- Membalik status
        if Toggles[varName] then
            Button.Text = "✓" -- Memunculkan centang
        else
            Button.Text = "" -- Menghilangkan centang
        end
    end)
end

-- Menambahkan tombol-tombol sesuai gambar
CreateToggle("AutoFarm", 45, "AutoFarm")
CreateToggle("Unlock Doors", 110, "UnlockDoors")
CreateToggle("Pickup Keys", 145, "PickupKeys")
CreateToggle("Join Game", 180, "JoinGame")

-- Membuat kotak tulisan YouTube/Kredit di paling bawah
local FooterFrame = Instance.new("Frame")
FooterFrame.Size = UDim2.new(0.9, 0, 0, 50)
FooterFrame.Position = UDim2.new(0.05, 0, 1, -55)
FooterFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
FooterFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)
FooterFrame.Parent = MainFrame

local FooterTitle = Instance.new("TextLabel")
FooterTitle.Size = UDim2.new(1, 0, 0, 30)
FooterTitle.BackgroundTransparency = 1
FooterTitle.Text = "punya naaa" -- Teks diperbarui verbatim
FooterTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
FooterTitle.TextSize = 15
FooterTitle.Font = Enum.Font.SourceSans
FooterTitle.Parent = FooterFrame

local FooterSubtext = Instance.new("TextLabel")
FooterSubtext.Size = UDim2.new(1, 0, 0, 20)
FooterSubtext.Position = UDim2.new(0, 0, 0, 30)
FooterSubtext.BackgroundTransparency = 1
FooterSubtext.Text = "-" -- Teks diperbarui verbatim
FooterSubtext.TextColor3 = Color3.fromRGB(150, 150, 150)
FooterSubtext.TextSize = 12
FooterSubtext.Font = Enum.Font.SourceSans
FooterSubtext.Parent = FooterFrame

-- ==========================================
-- 2. LOGIKA FITUR SCRIPT (Speed Farm & Anti-Render Lag)
-- ==========================================

-- Variabel untuk mencegah salah deteksi Lobi saat game sedang loading ruangan baru
local lastItemFoundTime = tick() 

task.spawn(function()
    -- Loop dipercepat menjadi 0.05 detik
    while task.wait(0.05) do
        if not Toggles.AutoFarm then continue end
        
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then continue end
        local rootPart = character.HumanoidRootPart
        
        -- Wadah Array untuk memisahkan target
        local keys = {}
        local doors = {}
        local portals = {}
        
        -- Scanning seluruh workspace dengan cepat
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") and obj.Enabled then
                local pName = string.lower(obj.Parent.Name)
                local oName = string.lower(obj.Name)
                
                if string.find(pName, "key") or string.find(oName, "key") then
                    table.insert(keys, obj)
                elseif string.find(pName, "door") or string.find(pName, "lock") or string.find(oName, "door") then
                    table.insert(doors, obj)
                end
            elseif (obj.Name == "TouchTransmitter" or obj.Name == "TouchInterest") then
                table.insert(portals, obj.Parent)
            end
        end

        -- ========================================
        -- EKSEKUSI 1: AMBIL KUNCI (Prioritas Tertinggi)
        -- ========================================
        if Toggles.PickupKeys and #keys > 0 then
            lastItemFoundTime = tick() -- Reset timer karena kita menemukan item arena
            
            -- Teleport langsung menyatu dengan posisi kunci agar seketika terdeteksi
            rootPart.CFrame = keys[1].Parent.CFrame
            task.wait(0.05) 
            
            if fireproximityprompt then
                fireproximityprompt(keys[1], 1, true)
            else
                keys[1]:InputHoldBegin()
                task.wait(keys[1].HoldDuration)
                keys[1]:InputHoldEnd()
            end
            task.wait(0.05) -- Jeda ultra-singkat antar pengambilan
            continue -- Ulangi loop dari awal untuk mendeteksi perubahan lingkungan
        end

        -- ========================================
        -- EKSEKUSI 2: BUKA PINTU
        -- ========================================
        if Toggles.UnlockDoors and #doors > 0 then
            lastItemFoundTime = tick() -- Reset timer
            
            rootPart.CFrame = doors[1].Parent.CFrame
            task.wait(0.05)
            
            if fireproximityprompt then
                fireproximityprompt(doors[1], 1, true)
            else
                doors[1]:InputHoldBegin()
                task.wait(doors[1].HoldDuration)
                doors[1]:InputHoldEnd()
            end
            task.wait(0.05)
            continue
        end

        -- ========================================
        -- EKSEKUSI 3: JOIN PORTAL (Dengan Validasi Waktu)
        -- ========================================
        -- Hanya masuk portal JIKA tidak ada kunci/pintu DAN sudah berlalu 3 detik sejak item terakhir ditemukan
        -- (Angka 3 detik mencegah script mengeksekusi portal saat game sedang nge-lag render ruang sebelah)
        if Toggles.JoinGame and #keys == 0 and #doors == 0 and #portals > 0 then
            if tick() - lastItemFoundTime > 3 then
                rootPart.CFrame = portals[1].CFrame
                task.wait(0.1)
                
                if firetouchinterest then
                    firetouchinterest(rootPart, portals[1], 0)
                    task.wait(0.05)
                    firetouchinterest(rootPart, portals[1], 1)
                end
                
                print("[LOG] Eksekusi Join Portal!")
                task.wait(10) -- Jeda panjang agar aman mendarat di arena
            end
        end
        
    end
end)

print("Custom GUI v4.0 (Speed Farm Optimization) loaded successfully!")
