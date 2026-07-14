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
-- 2. LOGIKA FITUR SCRIPT (Auto-Equip & Door Fix)
-- ==========================================

task.spawn(function()
    while task.wait(0.2) do
        if not Toggles.AutoFarm then continue end
        
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then continue end
        local rootPart = character.HumanoidRootPart
        
        -- ========================================
        -- [BARU] FITUR AUTO-EQUIP KUNCI
        -- Memaksa karakter memegang kunci yang ada di tas
        -- ========================================
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = character
                    task.wait(0.1) -- Jeda sebentar agar server mendaftarkan kunci di tangan
                end
            end
        end
        
        local keys = {}
        local doors = {}
        local portals = {}
        
        -- 1. PEMINDAIAN & FILTERING OBJEK
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                local aText = string.lower(obj.ActionText)
                local oText = string.lower(obj.ObjectText)
                local pName = string.lower(obj.Parent.Name)
                local oName = string.lower(obj.Name)
                
                -- Deteksi Portal
                local isPortal = string.find(aText, "join") or string.find(aText, "play") or string.find(aText, "enter") or string.find(aText, "exit") or string.find(aText, "keluar") or string.find(aText, "masuk")
                
                -- Deteksi Kunci
                local isKey = string.find(oText, "kunci") or string.find(oText, "key") or string.find(pName, "key") or string.find(oName, "key")
                
                -- Deteksi Pintu/Gembok (Ditambahkan kata kunci 'padlock', 'unlock')
                local isDoor = string.find(oText, "pintu") or string.find(oText, "door") or string.find(pName, "door") or string.find(pName, "lock") or string.find(pName, "padlock") or string.find(oText, "gembok") or string.find(aText, "buka") or string.find(aText, "open") or string.find(aText, "unlock")

                if obj.Parent and obj.Parent:IsA("BasePart") then
                    local dist = (rootPart.Position - obj.Parent.Position).Magnitude
                    local itemData = {prompt = obj, part = obj.Parent, distance = dist}
                    
                    if isPortal then
                        table.insert(portals, itemData)
                    elseif isKey then
                        table.insert(keys, itemData)
                    elseif isDoor then
                        table.insert(doors, itemData)
                    end
                end
            end
        end
        
        local function sortClosest(a, b)
            return a.distance < b.distance
        end
        table.sort(keys, sortClosest)
        table.sort(doors, sortClosest)
        table.sort(portals, sortClosest)
        
        local actionTaken = false

        -- ========================================
        -- 2. EKSEKUSI TARGET
        -- ========================================

        -- PRIORITAS 1: AMBIL KUNCI
        if Toggles.PickupKeys and #keys > 0 then
            local target = keys[1]
            if target.distance < 400 then
                target.prompt.Enabled = true
                target.prompt.MaxActivationDistance = 50
                
                rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(3, 3, 3), target.part.Position)
                task.wait(0.1)
                
                if fireproximityprompt then
                    fireproximityprompt(target.prompt, 1, true)
                end
                
                print("[INFO] Kunci diambil!")
                actionTaken = true
                task.wait(0.3)
            end
        end

        -- PRIORITAS 2: BUKA PINTU
        if Toggles.UnlockDoors and not actionTaken and #doors > 0 then
            local target = doors[1]
            if target.distance < 400 then
                target.prompt.Enabled = true
                target.prompt.MaxActivationDistance = 50
                
                -- Bergerak ke arah pintu
                rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(3, 3, 3), target.part.Position)
                task.wait(0.2) -- Jeda diperpanjang sedikit agar game menyadari kunci ada di tangan
                
                if fireproximityprompt then
                    fireproximityprompt(target.prompt, 1, true)
                else
                    target.prompt:InputHoldBegin()
                    task.wait(target.prompt.HoldDuration)
                    target.prompt:InputHoldEnd()
                end
                
                print("[INFO] Mengeksekusi Pintu/Gembok!")
                actionTaken = true
                task.wait(0.3)
            end
        end

        -- PRIORITAS 3: PORTAL
        if Toggles.JoinGame and not actionTaken then
            if #portals > 0 and portals[1].distance < 400 then
                local target = portals[1]
                rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(0, 3, 0))
                task.wait(0.1)
                
                if fireproximityprompt then
                    fireproximityprompt(target.prompt, 1, true)
                end
                task.wait(5)
            end
        end

    end
end)

print("Custom GUI vFinal (Auto-Equip Applied) loaded successfully!")
