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
-- 2. LOGIKA FITUR SCRIPT (Revisi 3 - Join/Exit)
-- ==========================================

local TeleportService = game:GetService("TeleportService")

-- Sistem Auto Join/Masuk Game
task.spawn(function()
    while task.wait(1) do
        -- Jika centang Join Game aktif
        if Toggles.JoinGame and Toggles.AutoFarm then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                
                -- Mencari tombol masuk pada portal/pintu di Lobby
                for _, prompt in pairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        local actionText = string.lower(prompt.ActionText)
                        local objectText = string.lower(prompt.ObjectText)
                        local parentName = string.lower(prompt.Parent.Name)
                        
                        -- Jika tulisan tombolnya "Enter", "Join", "Play", atau nama objeknya "Portal"
                        if string.find(actionText, "enter") or string.find(actionText, "join") or string.find(actionText, "play") or string.find(parentName, "portal") then
                            
                            -- Teleportasi ke portal masuk
                            character.HumanoidRootPart.CFrame = prompt.Parent.CFrame
                            task.wait(0.3)
                            
                            -- Eksekusi tombol masuk
                            if fireproximityprompt then
                                fireproximityprompt(prompt, 1, true)
                                print("[LOG] Berhasil menekan tombol masuk ruangan!")
                            end
                            
                            -- Matikan centang sementara agar tidak ditekan berulang kali
                            Toggles.JoinGame = false 
                            task.wait(10) -- Jeda panjang saat loading antar ruangan
                            Toggles.JoinGame = true -- Nyalakan kembali untuk ronde berikutnya
                            break
                        end
                    end
                end
            end
        end
    end
end)

-- Sistem Unlock Doors & Pickup Keys
task.spawn(function()
    while task.wait(0.5) do
        if Toggles.AutoFarm and (Toggles.UnlockDoors or Toggles.PickupKeys) then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                
                local foundItem = false
                
                for _, prompt in pairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        local parentObj = prompt.Parent
                        local parentName = string.lower(parentObj.Name)
                        local actionText = string.lower(prompt.ActionText)
                        local objectText = string.lower(prompt.ObjectText)
                        
                        -- AMBIL KUNCI
                        if Toggles.PickupKeys then
                            if string.find(parentName, "key") or string.find(actionText, "pick") or string.find(actionText, "grab") or string.find(objectText, "key") then
                                character.HumanoidRootPart.CFrame = parentObj.CFrame
                                task.wait(0.2)
                                if fireproximityprompt then
                                    fireproximityprompt(prompt, 1, true)
                                    print("[LOG] Kunci diambil!")
                                    foundItem = true
                                end
                                task.wait(0.5)
                            end
                        end
                        
                        -- BUKA PINTU
                        if Toggles.UnlockDoors then
                            if string.find(parentName, "door") or string.find(parentName, "lock") or string.find(actionText, "open") or string.find(actionText, "unlock") or string.find(objectText, "door") then
                                character.HumanoidRootPart.CFrame = parentObj.CFrame
                                task.wait(0.2)
                                if fireproximityprompt then
                                    fireproximityprompt(prompt, 1, true)
                                    print("[LOG] Pintu dibuka!")
                                    foundItem = true
                                end
                                task.wait(0.5)
                            end
                        end
                        
                    end
                end
                
                -- Sistem Exit/Rejoin (Jika di dalam ruangan dan tidak ada lagi yang bisa diambil)
                -- Hanya dijalankan jika AutoFarm menyala dan semua tugas selesai
                if Toggles.AutoFarm and not foundItem then
                    -- Kita perlu memverifikasi apakah kita sedang di ruangan game atau di lobby.
                    -- Game biasanya memiliki tempat Exit khusus setelah menang.
                    for _, prompt in pairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            local actionText = string.lower(prompt.ActionText)
                            
                            -- Mencari tombol "Exit", "Leave", "Return"
                            if string.find(actionText, "exit") or string.find(actionText, "leave") or string.find(actionText, "return") then
                                character.HumanoidRootPart.CFrame = prompt.Parent.CFrame
                                task.wait(0.2)
                                if fireproximityprompt then
                                    fireproximityprompt(prompt, 1, true)
                                    print("[LOG] Keluar ruangan dan kembali ke lobby.")
                                end
                                task.wait(5)
                                break
                            end
                        end
                    end
                end
                
            end
        end
    end
end)

print("Custom GUI v3 loaded successfully!")
