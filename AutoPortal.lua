-- Menunggu game dimuat sepenuhnya
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Membuat wadah variabel untuk tombol On/Off
local Toggles = {
    AutoFarm = false,
    UnlockDoors = false,
    PickupKeys = false,
    JoinGame = false
}

-- 1. MEMBUAT TAMPILAN GUI (Sesuai Gambar)
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

-- Membuat Judul "Keys | EsohaSL -"
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Keys | punyanaa -"
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
    Button.Text = ""
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Parent = MainFrame

    -- Logika jika tombol ditekan
    Button.MouseButton1Click:Connect(function()
        Toggles[varName] = not Toggles[varName] -- Membalik status (On jadi Off, Off jadi On)
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

-- Membuat kotak tulisan YouTube di paling bawah
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(0.9, 0, 0, 30)
Footer.Position = UDim2.new(0.05, 0, 1, -35)
Footer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Footer.BorderColor3 = Color3.fromRGB(30, 30, 30)
Footer.Text = "punya naaa"
Footer.TextColor3 = Color3.fromRGB(200, 200, 200)
Footer.TextSize = 15
Footer.Font = Enum.Font.SourceSans
Footer.Parent = MainFrame

-- ==========================================
-- 2. LOGIKA FITUR SCRIPT (Revisi Berdasarkan Gameplay Keys)
-- ==========================================

-- Menjalankan satu sistem utama agar eksekusi tidak saling bertabrakan
task.spawn(function()
    while task.wait(0.5) do
        -- Hanya berjalan jika tombol AutoFarm diaktifkan di GUI
        if not Toggles.AutoFarm then continue end
        
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not rootPart then continue end

        -- Membuat wadah penyimpanan objek sementara
        local keys = {}
        local doors = {}
        local joinPortals = {}
        local exitPortals = {}

        -- Mengumpulkan semua ProximityPrompt di seluruh map
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                local pName = string.lower(prompt.Parent.Name)
                local aText = string.lower(prompt.ActionText)
                local oText = string.lower(prompt.ObjectText)

                -- Deteksi Kunci
                if string.find(pName, "key") or string.find(oText, "key") then
                    table.insert(keys, prompt)
                -- Deteksi Pintu / Laci (Drawer)
                elseif string.find(pName, "door") or string.find(oText, "door") or string.find(pName, "drawer") or string.find(oText, "drawer") or string.find(pName, "lock") then
                    table.insert(doors, prompt)
                -- Deteksi Portal Masuk Lobby
                elseif string.find(aText, "join") or string.find(aText, "play") or string.find(aText, "enter") then
                    table.insert(joinPortals, prompt)
                -- Deteksi Portal Keluar (Menang)
                elseif string.find(aText, "exit") or string.find(aText, "escape") or string.find(oText, "exit") then
                    table.insert(exitPortals, prompt)
                end
            end
        end

        -- ========================================
        -- PRIORITAS 1: MENGAMBIL KUNCI
        -- ========================================
        if Toggles.PickupKeys and #keys > 0 then
            for _, prompt in pairs(keys) do
                -- Teleport ke kunci
                rootPart.CFrame = prompt.Parent.CFrame
                task.wait(0.2)
                -- Tekan tombol secara otomatis
                if fireproximityprompt then
                    fireproximityprompt(prompt, 1, true)
                end
                task.wait(0.3) -- Jeda antar item agar tidak error
            end
            continue -- Mengulang loop untuk mengecek apakah masih ada kunci lain
        end

        -- ========================================
        -- PRIORITAS 2: MEMBUKA PINTU & LACI
        -- ========================================
        if Toggles.UnlockDoors and #doors > 0 then
            for _, prompt in pairs(doors) do
                rootPart.CFrame = prompt.Parent.CFrame
                task.wait(0.2)
                if fireproximityprompt then
                    fireproximityprompt(prompt, 1, true)
                end
                task.wait(0.3)
            end
            continue -- Mengulang loop
        end

        -- ========================================
        -- PRIORITAS 3: AUTO JOIN & EXIT GAME
        -- ========================================
        if Toggles.JoinGame then
            -- Kondisi A: Kita di dalam map dan sudah menang (Portal Exit Muncul)
            if #exitPortals > 0 then
                rootPart.CFrame = exitPortals[1].Parent.CFrame
                task.wait(0.2)
                if fireproximityprompt then
                    fireproximityprompt(exitPortals[1], 1, true)
                end
                task.wait(8) -- Jeda 8 detik saat loading balik ke lobby
                
            -- Kondisi B: Kita berada di Lobby (Tidak ada kunci/pintu map, adanya Join Portal)
            elseif #keys == 0 and #doors == 0 and #joinPortals > 0 then
                rootPart.CFrame = joinPortals[1].Parent.CFrame
                task.wait(0.2)
                if fireproximityprompt then
                    fireproximityprompt(joinPortals[1], 1, true)
                end
                task.wait(8) -- Jeda 8 detik saat loading masuk ke arena
            end
        end
        
    end
end)

print("Custom GUI v4 (Gameplay Synced) loaded successfully!")
