-- Menunggu game dimuat sepenuhnya
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Mencegah GUI menumpuk jika Anda meng-execute script berkali-kali
if CoreGui:FindFirstChild("CustomKeysGUI") then
    CoreGui.CustomKeysGUI:Destroy()
end

local Toggles = {
    AutoFarm = false,
    UnlockDoors = false,
    PickupKeys = false,
    JoinGame = false
}

-- ==========================================
-- 1. MEMBUAT TAMPILAN GUI (Dengan Tombol Minimize & Close)
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomKeysGUI"
ScreenGui.Parent = CoreGui 

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true -- Penting: agar isi kotak hilang saat di-minimize
MainFrame.Parent = ScreenGui

-- Top Bar (Untuk menaruh judul dan tombol kontrol)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(1, 0, 0, 2)
TopLine.Position = UDim2.new(0, 0, 1, -2)
TopLine.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
TopLine.BorderSizePixel = 0
TopLine.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, -2)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Keys | punyanaa -"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.Code
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Tombol Minimize (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -65, 0, 2)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Parent = TopBar

-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 2)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TopBar

-- Kontainer Isi GUI (Agar mudah disembunyikan saat minimize)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -35)
ContentContainer.Position = UDim2.new(0, 0, 0, 35)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local ConfigLabel = Instance.new("TextLabel")
ConfigLabel.Size = UDim2.new(1, 0, 0, 30)
ConfigLabel.Position = UDim2.new(0, 0, 0, 10)
ConfigLabel.BackgroundTransparency = 1
ConfigLabel.Text = "Config"
ConfigLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
ConfigLabel.TextSize = 16
ConfigLabel.Font = Enum.Font.SourceSans
ConfigLabel.Parent = ContentContainer

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
    Label.Parent = ContentContainer

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 20, 0, 20)
    Button.Position = UDim2.new(0.85, 0, 0, yPos + 5)
    Button.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Button.BorderColor3 = Color3.fromRGB(40, 40, 40)
    Button.Text = ""
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Parent = ContentContainer

    Button.MouseButton1Click:Connect(function()
        Toggles[varName] = not Toggles[varName]
        if Toggles[varName] then
            Button.Text = "✓"
        else
            Button.Text = ""
        end
    end)
end

-- Posisi Y disesuaikan sedikit agar pas dengan desain
CreateToggle("AutoFarm", 45, "AutoFarm")
CreateToggle("Unlock Doors", 80, "UnlockDoors")
CreateToggle("Pickup Keys", 115, "PickupKeys")
CreateToggle("Join Game", 150, "JoinGame")

local FooterFrame = Instance.new("Frame")
FooterFrame.Size = UDim2.new(0.9, 0, 0, 40)
FooterFrame.Position = UDim2.new(0.05, 0, 1, -45)
FooterFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
FooterFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)
FooterFrame.Parent = ContentContainer

local FooterTitle = Instance.new("TextLabel")
FooterTitle.Size = UDim2.new(1, 0, 0, 20)
FooterTitle.Position = UDim2.new(0, 0, 0, 5)
FooterTitle.BackgroundTransparency = 1
FooterTitle.Text = "punya naaa"
FooterTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
FooterTitle.TextSize = 15
FooterTitle.Font = Enum.Font.SourceSans
FooterTitle.Parent = FooterFrame

local FooterSubtext = Instance.new("TextLabel")
FooterSubtext.Size = UDim2.new(1, 0, 0, 15)
FooterSubtext.Position = UDim2.new(0, 0, 0, 20)
FooterSubtext.BackgroundTransparency = 1
FooterSubtext.Text = "-"
FooterSubtext.TextColor3 = Color3.fromRGB(150, 150, 150)
FooterSubtext.TextSize = 12
FooterSubtext.Font = Enum.Font.SourceSans
FooterSubtext.Parent = FooterFrame

-- Animasi & Logika Tombol
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 220, 0, 35) -- Menyusut jadi sebatas judul
    else
        MainFrame.Size = UDim2.new(0, 220, 0, 260) -- Kembali ke ukuran normal
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    Toggles.AutoFarm = false -- Mematikan proses latar belakang
    ScreenGui:Destroy() -- Menghancurkan GUI sepenuhnya
end)


-- ==========================================
-- 2. LOGIKA FITUR SCRIPT (Bekerja di Latar Belakang)
-- ==========================================

task.spawn(function()
    while task.wait(0.2) do
        -- Jika AutoFarm dimatikan atau GUI sudah di-close, jangan jalankan script
        if not Toggles.AutoFarm then continue end
        if not ScreenGui.Parent then break end 
        
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then continue end
        local rootPart = character.HumanoidRootPart
        local humanoid = character:FindFirstChild("Humanoid")
        
        -- ========================================
        -- [UPDATE] FITUR AUTO-EQUIP MENGGUNAKAN HUMANOID API
        -- ========================================
        local hasEquippedKey = false
        
        -- Periksa apakah pemain sudah memegang kunci
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "key") or string.find(string.lower(tool.Name), "kunci")) then
                hasEquippedKey = true
            end
        end
        
        -- Jika belum pegang, cari di tas (Backpack) dan panggil EquipTool
        if not hasEquippedKey then
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack and humanoid then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "key") or string.find(string.lower(tool.Name), "kunci")) then
                        humanoid:EquipTool(tool)
                        hasEquippedKey = true
                        task.wait(0.2) -- Jeda kecil agar server mendaftarkan kunci di tangan
                    end
                end
            end
        end
        
        local keys = {}
        local doors = {}
        local portals = {}
        
        -- ========================================
        -- PEMINDAIAN & FILTERING OBJEK
        -- ========================================
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                
                -- SANGAT PENTING: Abaikan prompt yang menempel pada tubuh/tangan karakter
                if obj:IsDescendantOf(character) then continue end
                
                local aText = string.lower(obj.ActionText)
                local oText = string.lower(obj.ObjectText)
                local pName = string.lower(obj.Parent.Name)
                local oName = string.lower(obj.Name)
                
                local isPortal = string.find(aText, "join") or string.find(aText, "play") or string.find(aText, "enter") or string.find(aText, "exit") or string.find(aText, "keluar") or string.find(aText, "masuk")
                local isKey = string.find(oText, "kunci") or string.find(oText, "key") or string.find(pName, "key") or string.find(oName, "key")
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
        -- EKSEKUSI TARGET
        -- ========================================

        -- 1. KUNCI
        if Toggles.PickupKeys and #keys > 0 then
            local target = keys[1]
            if target.distance < 400 then
                target.prompt.Enabled = true
                target.prompt.MaxActivationDistance = 50
                
                rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(3, 3, 3), target.part.Position)
                task.wait(0.2)
                
                if fireproximityprompt then
                    fireproximityprompt(target.prompt, 1, true)
                end
                
                actionTaken = true
                task.wait(0.3)
            end
        end

        -- 2. PINTU (Berjalan jika tidak ada aksi ambil kunci di loop ini)
        if Toggles.UnlockDoors and not actionTaken and #doors > 0 then
            local target = doors[1]
            if target.distance < 400 then
                target.prompt.Enabled = true
                target.prompt.MaxActivationDistance = 50
                
                rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(2, 2, 2), target.part.Position)
                
                -- Jeda agak lama (0.4 detik) agar server menyadari Anda sedang di depan pintu sambil bawa kunci
                task.wait(0.4) 
                
                if fireproximityprompt then
                    fireproximityprompt(target.prompt, 1, true)
                    task.wait(0.1)
                    -- Menembakkan dua kali sebagai langkah anti-gagal
                    fireproximityprompt(target.prompt, 1, true) 
                end
                
                actionTaken = true
                task.wait(0.5) 
            end
        end

        -- 3. PORTAL
        if Toggles.JoinGame and not actionTaken then
            if #portals > 0 and portals[1].distance < 400 then
                local target = portals[1]
                rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(0, 3, 0))
                task.wait(0.2)
                
                if fireproximityprompt then
                    fireproximityprompt(target.prompt, 1, true)
                end
                task.wait(5)
            end
        end

    end
end)

print("Custom GUI + Close/Minimize + Fixed Doors loaded successfully!")
