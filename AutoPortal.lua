-- ==========================================
-- SCRIPT FULL: REBUILT FROM SCRATCH (MUMU SAFE + DOOR FIX)
-- ==========================================

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Dukungan Khusus Emulator Android / MuMu Player
local UI_PARENT
local success, result = pcall(function() 
    return (gethui and gethui()) or game:GetService("CoreGui") 
end)

if success and result then
    UI_PARENT = result
else
    UI_PARENT = LocalPlayer:WaitForChild("PlayerGui")
end

-- Menghapus GUI lama agar tidak menumpuk
if UI_PARENT:FindFirstChild("CustomKeysGUI") then
    UI_PARENT.CustomKeysGUI:Destroy()
end

local Toggles = {
    AutoFarm = false,
    UnlockDoors = false,
    PickupKeys = false,
    JoinGame = false
}

-- ==========================================
-- 1. MEMBUAT TAMPILAN GUI (Sama Persis)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomKeysGUI"
ScreenGui.Parent = UI_PARENT 

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

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
Title.Text = "Keys | punya naa "
Title.TextColor3 = Color3.fromRGB(232, 158, 184)
Title.TextSize = 16
Title.Font = Enum.Font.Code
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -65, 0, 2)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 22
MinBtn.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 2)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TopBar

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
        Button.Text = Toggles[varName] and "✓" or ""
    end)
end

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

-- Logika Tombol GUI
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 220, 0, 35)
        ContentContainer.Visible = false
    else
        MainFrame.Size = UDim2.new(0, 220, 0, 260)
        ContentContainer.Visible = true
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    Toggles.AutoFarm = false 
    ScreenGui:Destroy() 
end)

-- ==========================================
-- 2. LOGIKA DIBANGUN ULANG (FOKUS PINTU & KUNCI)
-- ==========================================

task.spawn(function()
    while task.wait(0.25) do -- Jeda loop sedikit lebih santai agar server tidak panik
        if not Toggles.AutoFarm then continue end
        if not ScreenGui.Parent then break end 
        
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            if not hrp or not hum then return end
            
            -- ========================================
            -- A. SISTEM AUTO-EQUIP (Memastikan alat dipegang)
            -- ========================================
            local hasToolEquipped = false
            for _, child in ipairs(char:GetChildren()) do
                if child:IsA("Tool") then hasToolEquipped = true end
            end
            
            if not hasToolEquipped then
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                if backpack then
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            hum:EquipTool(tool)
                            task.wait(0.2) -- Tunggu animasi equip selesai
                            break
                        end
                    end
                end
            end
            
            -- ========================================
            -- B. SCANNING OBJEK
            -- ========================================
            local keys = {}
            local doors = {}
            local portals = {}
            
            for _, desc in ipairs(workspace:GetDescendants()) do
                if desc:IsA("ProximityPrompt") and not desc:IsDescendantOf(char) then
                    local parentPart = desc.Parent
                    if parentPart and parentPart:IsA("BasePart") then
                        
                        -- Menggabungkan semua teks untuk difilter
                        local text = string.lower(desc.ActionText .. " " .. desc.ObjectText .. " " .. parentPart.Name .. " " .. desc.Name)
                        local dist = (hrp.Position - parentPart.Position).Magnitude
                        
                        -- BLOKIR: Lemari, tempat sembunyi, toko
                        if string.find(text, "shop") or string.find(text, "toko") or string.find(text, "hide") or string.find(text, "sembunyi") or string.find(text, "lemari") or string.find(text, "drawer") then
                            continue
                        end
                        
                        local itemData = {prompt = desc, part = parentPart, distance = dist}
                        
                        if string.find(text, "join") or string.find(text, "play") or string.find(text, "enter") or string.find(text, "exit") or string.find(text, "keluar") or string.find(text, "masuk") then
                            table.insert(portals, itemData)
                        elseif string.find(text, "key") or string.find(text, "kunci") then
                            table.insert(keys, itemData)
                        elseif string.find(text, "door") or string.find(text, "pintu") or string.find(text, "lock") or string.find(text, "gembok") or string.find(text, "open") or string.find(text, "buka") then
                            table.insert(doors, itemData)
                        end
                    end
                end
            end
            
            -- Urutkan target terdekat
            local function sortDist(a, b) return a.distance < b.distance end
            table.sort(keys, sortDist)
            table.sort(doors, sortDist)
            table.sort(portals, sortDist)
            
            -- ========================================
            -- C. FASE EKSEKUSI (HANYA JALAN 1 AKSI PER LOOP)
            -- ========================================

            -- PRIORITAS 1: AMBIL KUNCI
            if Toggles.PickupKeys and #keys > 0 then
                local target = keys[1]
                if target.distance < 400 then
                    target.prompt.Enabled = true
                    target.prompt.MaxActivationDistance = 50
                    target.prompt.RequiresLineOfSight = false -- BYPASS ANTI-CHEAT VISUAL
                    
                    -- Teleport natural (Mendarat di atasnya)
                    hrp.CFrame = CFrame.new(target.part.Position + Vector3.new(0, 3, 0))
                    task.wait(0.2)
                    
                    if fireproximityprompt then
                        fireproximityprompt(target.prompt, 1, true)
                    end
                    
                    -- RETURN digunakan agar script langsung mengulang loop dan tidak menabrak perintah pintu
                    return 
                end
            end

            -- PRIORITAS 2: BUKA PINTU
            if Toggles.UnlockDoors and #doors > 0 then
                local target = doors[1]
                if target.distance < 400 then
                    target.prompt.Enabled = true
                    target.prompt.MaxActivationDistance = 50
                    target.prompt.RequiresLineOfSight = false -- RAHASIA MEMBUKA PINTU MESKI TERHALANG
                    
                    -- Teleport menghadap pintu agak mundur sedikit agar tidak menyatu dengan tembok
                    hrp.CFrame = CFrame.new(target.part.Position + Vector3.new(2, 2, 2), target.part.Position)
                    
                    -- Jeda ini krusial: Memberi server waktu memastikan karakter sedang pegang kunci
                    task.wait(0.4) 
                    
                    if fireproximityprompt then
                        fireproximityprompt(target.prompt, 1, true)
                        task.wait(0.1)
                        fireproximityprompt(target.prompt, 1, true) -- Tembakan ganda jaminan mutu
                    end
                    
                    return 
                end
            end

            -- PRIORITAS 3: MASUK PORTAL
            if Toggles.JoinGame and #portals > 0 then
                local target = portals[1]
                if target.distance < 400 then
                    target.prompt.Enabled = true
                    target.prompt.MaxActivationDistance = 50
                    target.prompt.RequiresLineOfSight = false
                    
                    hrp.CFrame = CFrame.new(target.part.Position + Vector3.new(0, 3, 0))
                    task.wait(0.2)
                    
                    if fireproximityprompt then
                        fireproximityprompt(target.prompt, 1, true)
                    end
                    
                    task.wait(4) -- Jeda panjang karena akan pindah server/ruangan
                    return
                end
            end
            
        end)
    end
end)

print("Custom GUI vFinal (Rebuilt from Scratch) loaded successfully!")
