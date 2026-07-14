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
-- 2. LOGIKA FITUR SCRIPT (Bekerja di Latar Belakang)
-- ==========================================

-- Sistem Auto Join Portal (Diaktifkan lewat centang "Join Game" & "AutoFarm")
task.spawn(function()
    while task.wait(3) do
        -- Hanya berjalan jika "AutoFarm" DAN "Join Game" dicentang
        if Toggles.AutoFarm and Toggles.JoinGame then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                -- Mencari portal sentuh di Lobby
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "TouchTransmitter" or obj.Name == "TouchInterest" then
                        local portalPart = obj.Parent
                        if portalPart and portalPart:IsA("BasePart") then
                            -- Teleportasi ke portal
                            character.HumanoidRootPart.CFrame = portalPart.CFrame
                            task.wait(6) -- Jeda setelah pindah server/room
                        end
                    end
                end
            end
        end
    end
end)

-- Sistem Unlock Doors
task.spawn(function()
    while task.wait(0.5) do
        if Toggles.AutoFarm and Toggles.UnlockDoors then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                -- Mencari objek dengan ProximityPrompt (interaksi tombol 'E' dll) di dalam Workspace
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        local parentObj = obj.Parent
                        local parentName = string.lower(parentObj.Name)
                        
                        -- Memastikan ini adalah pintu atau gembok
                        if string.find(parentName, "door") or string.find(parentName, "lock") then
                            -- Teleportasi ke depan pintu
                            character.HumanoidRootPart.CFrame = parentObj.CFrame
                            task.wait(0.2)
                            
                            -- Otomatis mengeksekusi 'ProximityPrompt' tanpa ditekan manual
                            if fireproximityprompt then
                                fireproximityprompt(obj, 1, true)
                            end
                            task.wait(0.5) -- Jeda sebentar agar tidak terdeteksi spam
                        end
                    end
                end
            end
        end
    end
end)

-- Sistem Pickup Keys
task.spawn(function()
    while task.wait(0.5) do
        if Toggles.AutoFarm and Toggles.PickupKeys then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(workspace:GetDescendants()) do
                    -- Skenario 1: Jika kunci menggunakan sistem ProximityPrompt
                    if obj:IsA("ProximityPrompt") then
                        local parentObj = obj.Parent
                        if string.find(string.lower(parentObj.Name), "key") then
                            character.HumanoidRootPart.CFrame = parentObj.CFrame
                            task.wait(0.2)
                            if fireproximityprompt then
                                fireproximityprompt(obj, 1, true)
                            end
                            task.wait(0.5)
                        end
                    
                    -- Skenario 2: Jika kunci berbentuk Tools yang jatuh di lantai dan bisa disentuh
                    elseif obj:IsA("Tool") and string.find(string.lower(obj.Name), "key") then
                        local handle = obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")
                        if handle then
                            -- Teleportasi ke Kunci
                            character.HumanoidRootPart.CFrame = handle.CFrame
                            task.wait(0.2)
                            
                            -- Memalsukan event "sentuhan" antara pemain dan kunci
                            if firetouchinterest then
                                firetouchinterest(character.HumanoidRootPart, handle, 0)
                                task.wait(0.1)
                                firetouchinterest(character.HumanoidRootPart, handle, 1)
                            end
                            task.wait(0.5)
                        end
                    end
                end
            end
        end
    end
end)

print("Custom GUI loaded successfully!")
