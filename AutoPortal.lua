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
-- 2. LOGIKA FITUR SCRIPT (Bekerja di Latar Belakang)
-- ==========================================

-- Sistem Fungsional Baru untuk Unlock Doors & Pickup Keys
task.spawn(function()
    while task.wait(0.5) do
        if Toggles.AutoFarm then
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then continue end

            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") and obj.Enabled then
                    local parent = obj.Parent
                    local isFarming = false
                    
                    -- Logika Pickup Keys
                    if Toggles.PickupKeys and (string.find(obj.Name:lower(), "key") or string.find(parent.Name:lower(), "key")) then
                        isFarming = true
                    end
                    
                    -- Logika Unlock Doors
                    if not isFarming and Toggles.UnlockDoors and (string.find(obj.Name:lower(), "door") or string.find(parent.Name:lower(), "door") or string.find(obj.Name:lower(), "lock") or string.find(parent.Name:lower(), "lock")) then
                        isFarming = true
                    end
                    
                    if isFarming then
                        character.HumanoidRootPart.CFrame = parent.CFrame * CFrame.new(0, 0, 2)
                        task.wait(0.2) 
                        
                        -- Menggunakan fireproximityprompt jika didukung executor (Lebih instan dan akurat)
                        if fireproximityprompt then
                            fireproximityprompt(obj, 1, true)
                        else
                            obj:InputHoldBegin()
                            task.wait(obj.HoldDuration) 
                            obj:InputHoldEnd()
                        end
                        task.wait(0.3)
                    end
                end
            end
        end
    end
end)

-- Sistem Auto Join Game (Diperbarui dengan Trigger Paksa)
task.spawn(function()
    while task.wait(2) do
        if Toggles.AutoFarm and Toggles.JoinGame then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                
                for _, obj in pairs(workspace:GetDescendants()) do
                    -- Skenario A: Portal menggunakan tombol (ProximityPrompt)
                    if obj:IsA("ProximityPrompt") then
                        local actText = string.lower(obj.ActionText)
                        if string.find(actText, "join") or string.find(actText, "play") or string.find(actText, "enter") then
                            rootPart.CFrame = obj.Parent.CFrame
                            task.wait(0.2)
                            if fireproximityprompt then
                                fireproximityprompt(obj, 1, true)
                            end
                            task.wait(5) -- Jeda agar tidak spam saat loading
                        end
                    end
                    
                    -- Skenario B: Portal sentuh (seperti portal ungu pada gambar Anda)
                    if obj.Name == "TouchTransmitter" or obj.Name == "TouchInterest" then
                        local portalPart = obj.Parent
                        if portalPart and portalPart:IsA("BasePart") then
                            -- Pindahkan karakter ke portal
                            rootPart.CFrame = portalPart.CFrame
                            task.wait(0.2)
                            
                            -- Paksa engine Roblox mendaftarkan event "Sentuhan" (Collision)
                            if firetouchinterest then
                                firetouchinterest(rootPart, portalPart, 0) -- 0 = Mulai sentuh
                                task.wait(0.1)
                                firetouchinterest(rootPart, portalPart, 1) -- 1 = Berhenti sentuh
                            end
                            task.wait(5) -- Jeda saat masuk ruangan
                        end
                    end
                end
                
            end
        end
    end
end)

print("Custom GUI v2.1 (Join Fix) loaded successfully!")
