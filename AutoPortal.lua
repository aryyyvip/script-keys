-- ==========================================
-- SCRIPT FULL: GUI + ANTI-LEMARI + PORTAL FIX
-- ==========================================

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

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
-- 1. TAMPILAN GUI
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
-- 2. LOGIKA FITUR SCRIPT (ANTI-LEMARI & PORTAL)
-- ==========================================
task.spawn(function()
    while task.wait(0.2) do
        if not Toggles.AutoFarm then continue end
        if not ScreenGui.Parent then break end 
        
        pcall(function()
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            local rootPart = character.HumanoidRootPart
            local humanoid = character:FindFirstChild("Humanoid")
            
            -- AUTO EQUIP KUNCI
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack and humanoid then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        humanoid:EquipTool(tool)
                        task.wait(0.1)
                    end
                end
            end
            
            local keys = {}
            local doors = {}
            local portalPart = nil
            
            -- 1. MENCARI PORTAL "DIMULAI DI SINI" DI LOBI
            if Toggles.JoinGame then
                for _, obj in pairs(workspace:GetDescendants()) do
                    -- Mencari papan tulisan portal
                    if (obj:IsA("TextLabel") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui")) then
                        if string.find(string.lower(tostring(obj.Text or obj.Name)), "dimulai") or string.find(string.lower(tostring(obj.Text or obj.Name)), "menyaksikan") then
                            -- Menemukan lantai/blok portal
                            local parent = obj.Parent
                            while parent and not parent:IsA("BasePart") do
                                parent = parent.Parent
                            end
                            if parent then
                                portalPart = parent
                                break
                            end
                        end
                    end
                end
            end
            
            -- 2. MENCARI KUNCI DAN PINTU
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    if obj:IsDescendantOf(character) then continue end
                    
                    local combinedText = string.lower(obj.ActionText .. " " .. obj.ObjectText .. " " .. (obj.Parent and obj.Parent.Name or "") .. " " .. obj.Name)
                    
                    -- BLOKIR BENDA PENGGANGGU (Sembunyi, Lemari, Toko, dll)
                    if string.find(combinedText, "lemari") or string.find(combinedText, "sembunyi") or string.find(combinedText, "hide") or string.find(combinedText, "closet") or string.find(combinedText, "toko") or string.find(combinedText, "beli") or string.find(combinedText, "shop") then
                        continue -- Lewati benda ini!
                    end
                    
                    if obj.Parent and obj.Parent:IsA("BasePart") then
                        local dist = (rootPart.Position - obj.Parent.Position).Magnitude
                        
                        -- Filter Kunci
                        if string.find(combinedText, "kunci") or string.find(combinedText, "key") then
                            table.insert(keys, {prompt = obj, part = obj.Parent, distance = dist})
                            
                        -- Filter Pintu (Hanya menerima kata Pintu/Door/Gembok/Lock)
                        elseif string.find(combinedText, "pintu") or string.find(combinedText, "door") or string.find(combinedText, "gembok") or string.find(combinedText, "lock") or string.find(combinedText, "padlock") then
                            table.insert(doors, {prompt = obj, part = obj.Parent, distance = dist})
                            
                        -- Portal via Tombol (Exit)
                        elseif string.find(combinedText, "exit") or string.find(combinedText, "keluar") or string.find(combinedText, "join") then
                            portalPart = obj.Parent
                        end
                    end
                end
            end
            
            table.sort(keys, function(a, b) return a.distance < b.distance end)
            table.sort(doors, function(a, b) return a.distance < b.distance end)
            
            local actionTaken = false

            -- EKSEKUSI 1: KUNCI
            if Toggles.PickupKeys and #keys > 0 then
                local target = keys[1]
                if target.distance < 400 then
                    target.prompt.Enabled = true
                    
                    rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(0, 3, 0), target.part.Position)
                    task.wait(0.2) 
                    
                    if fireproximityprompt then
                        fireproximityprompt(target.prompt, 1, true)
                    end
                    
                    actionTaken = true
                    task.wait(0.3)
                end
            end

            -- EKSEKUSI 2: PINTU
            if Toggles.UnlockDoors and not actionTaken and #doors > 0 then
                local target = doors[1]
                if target.distance < 400 then
                    target.prompt.Enabled = true
                    
                    rootPart.CFrame = CFrame.new(target.part.Position + Vector3.new(0, 3, 0), target.part.Position)
                    task.wait(0.3) 
                    
                    if fireproximityprompt then
                        fireproximityprompt(target.prompt, 1, true)
                        task.wait(0.1)
                        fireproximityprompt(target.prompt, 1, true)
                    end
                    
                    actionTaken = true
                    task.wait(0.4)
                end
            end

            -- EKSEKUSI 3: JOIN GAME / PORTAL LOBI
            -- Hanya masuk lobi jika tidak ada lagi kunci atau pintu (sedang di lobi atau sudah tamat)
            if Toggles.JoinGame and not actionTaken and #keys == 0 and #doors == 0 and portalPart then
                local dist = (rootPart.Position - portalPart.Position).Magnitude
                if dist < 500 then
                    rootPart.CFrame = portalPart.CFrame + Vector3.new(0, 3, 0)
                    task.wait(0.2)
                    
                    -- Paksa interaksi sentuhan
                    if firetouchinterest then
                        firetouchinterest(rootPart, portalPart, 0)
                        task.wait(0.1)
                        firetouchinterest(rootPart, portalPart, 1)
                    end
                    
                    -- Paksa karakter berjalan sedikit untuk men-trigger portal jika firetouchinterest diblokir
                    if humanoid then
                        humanoid:MoveTo(portalPart.Position + Vector3.new(0, 0, 5))
                    end
                    
                    -- Paksa interaksi tombol jika portal itu menggunakan tombol E
                    local prompt = portalPart:FindFirstChildWhichIsA("ProximityPrompt")
                    if prompt and fireproximityprompt then
                        fireproximityprompt(prompt, 1, true)
                    end
                    
                    task.wait(6) -- Jeda aman agar tidak spam saat layar loading
                end
            end
            
        end)
    end
end)
