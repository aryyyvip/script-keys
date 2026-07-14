-- =========================================================
-- KEYS AUTO FARM GUI SCRIPT
-- Desain UI: Keys | punyanaa (Sesuai Screenshot Anda)
-- Fungsionalitas: Berdasarkan Gameplay Video 2025
-- =========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variabel Konfigurasi Global
_G.AutoFarm = false
_G.UnlockDoors = false
_G.PickupKeys = false
_G.JoinGame = false
_G.InfJump = false

-- Membuat ScreenGui Utama
local KeysGui = Instance.new("ScreenGui")
KeysGui.Name = "Keys_Punyanaa_GUI"
KeysGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
KeysGui.ResetOnSpawn = false

-- Frame Menu Utama (Background Gelap Sesuai Foto)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = KeysGui

-- Fungsi agar Menu Bisa Digeser (Drag) dengan Mouse / Touch
local dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragStart = nil
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragStart then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

-- Title Bar (Bar Bagian Atas)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0.05, 0, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Keys  |  punyanaa"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Tombol Keluar (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(0.9, 0, 0.1, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleBar
CloseButton.MouseButton1Click:Connect(function()
    KeysGui:Destroy()
end)

-- Garis Hijau Neon Pembatas (Sesuai Screenshot)
local GreenLine = Instance.new("Frame")
GreenLine.Size = UDim2.new(1, 0, 0, 2)
GreenLine.Position = UDim2.new(0, 0, 0, 40)
GreenLine.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
GreenLine.BorderSizePixel = 0
GreenLine.Parent = MainFrame

-- Teks "Config"
local ConfigHeader = Instance.new("TextLabel")
ConfigHeader.Size = UDim2.new(1, 0, 0, 30)
ConfigHeader.Position = UDim2.new(0, 0, 0, 45)
ConfigHeader.BackgroundTransparency = 1
ConfigHeader.Text = "Config"
ConfigHeader.TextColor3 = Color3.fromRGB(180, 180, 180)
ConfigHeader.TextSize = 16
ConfigHeader.Font = Enum.Font.SourceSans
ConfigHeader.Parent = MainFrame

-- Container Tombol Fitur
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -125)
ContentFrame.Position = UDim2.new(0, 10, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ContentFrame

-- Fungsi Pembuat Tombol Toggle (Centang)
local function createToggle(name, labelText, defaultVal, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 40)
    Container.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 16
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local CheckboxOuter = Instance.new("Frame")
    CheckboxOuter.Size = UDim2.new(0, 22, 0, 22)
    CheckboxOuter.Position = UDim2.new(0.85, 0, 0.2, 0)
    CheckboxOuter.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    CheckboxOuter.BorderColor3 = Color3.fromRGB(50, 50, 50)
    CheckboxOuter.BorderSizePixel = 1
    CheckboxOuter.Parent = Container
    
    local CheckboxInner = Instance.new("TextLabel")
    CheckboxInner.Size = UDim2.new(1, 0, 1, 0)
    CheckboxInner.BackgroundTransparency = 1
    CheckboxInner.Text = defaultVal and "✓" or ""
    CheckboxInner.TextColor3 = Color3.fromRGB(0, 255, 0)
    CheckboxInner.TextSize = 18
    CheckboxInner.Font = Enum.Font.SourceSansBold
    CheckboxInner.Parent = CheckboxOuter
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = CheckboxOuter
    
    local enabled = defaultVal
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        CheckboxInner.Text = enabled and "✓" or ""
        callback(enabled)
    end)
    
    return Container
end

-- Mendaftarkan Setiap Tombol Fitur Sesuai Gambar & Video
createToggle("AutoFarm", "AutoFarm", _G.AutoFarm, function(val) _G.AutoFarm = val end).Parent = ContentFrame
createToggle("UnlockDoors", "Unlock Doors", _G.UnlockDoors, function(val) _G.UnlockDoors = val end).Parent = ContentFrame
createToggle("PickupKeys", "Pickup Keys", _G.PickupKeys, function(val) _G.PickupKeys = val end).Parent = ContentFrame
createToggle("JoinGame", "Join Game", _G.JoinGame, function(val) _G.JoinGame = val end).Parent = ContentFrame
createToggle("InfJump", "Infinite Jump", _G.InfJump, function(val) _G.InfJump = val end).Parent = ContentFrame

-- Footer Menu (punya naaa -)
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 35)
Footer.Position = UDim2.new(0, 0, 1, -35)
Footer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Footer.BorderSizePixel = 0
Footer.Parent = MainFrame

local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.BackgroundTransparency = 1
FooterText.Text = "punya naaa\n-"
FooterText.TextColor3 = Color3.fromRGB(120, 120, 120)
FooterText.TextSize = 11
FooterText.Font = Enum.Font.SourceSans
FooterText.Parent = Footer

-- Menghubungkan ulang karakter jika respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- =========================================================
-- LOGIKA / BACKEND SETIAP FITUR
-- =========================================================

-- Fitur: Infinite Jump (Melompat tanpa batas di udara)
UserInputService.JumpRequest:Connect(function()
    if _G.InfJump and Character and Character:FindFirstChildOfClass("Humanoid") then
        Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Fungsi pemicu interaksi otomatis (Proximity Prompt)
local function firePrompt(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        fireproximityprompt(prompt)
    end
end

-- Fitur: AutoFarm & Doors Farm (Teleport ke kunci lalu langsung ke pintu keluar)
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFarm then
            pcall(function()
                local keys = {}
                local doors = {}
                
                -- Mencari objek kunci dan pintu di Workspace
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        local parentName = obj.Parent.Name:lower()
                        if parentName:find("key") then
                            table.insert(keys, obj)
                        elseif parentName:find("door") or parentName:find("exit") or parentName:find("escape") then
                            table.insert(doors, obj)
                        end
                    end
                end
                
                if #keys > 0 then
                    -- Teleport otomatis ke kunci pertama dan mengambilnya
                    local targetKey = keys[1].Parent
                    local part = targetKey:IsA("Model") and targetKey.PrimaryPart or targetKey
                    if part then
                        HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.2)
                        firePrompt(keys[1])
                    end
                elseif #doors > 0 then
                    -- Teleport otomatis ke pintu keluar apabila semua kunci sudah diambil
                    local targetDoor = doors[1].Parent
                    local part = targetDoor:IsA("Model") and targetDoor.PrimaryPart or targetDoor
                    if part then
                        HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.2)
                        firePrompt(doors[1])
                    end
                end
            end)
        end
    end
end)

-- Fitur: Unlock Doors Only (Buka Pintu Otomatis jika didekati)
task.spawn(function()
    while task.wait(0.2) do
        if _G.UnlockDoors and not _G.AutoFarm then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and (obj.Parent.Name:lower():find("door") or obj.Parent.Name:lower():find("escape")) then
                        firePrompt(obj)
                    end
                end
            end)
        end
    end
end)

-- Fitur: Pickup Keys Only (Ambil Kunci Otomatis jika berada di dekatnya)
task.spawn(function()
    while task.wait(0.2) do
        if _G.PickupKeys and not _G.AutoFarm then
            pcall(function()
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and (obj.Parent.Name:lower():find("key") or obj.Name:lower():find("key")) then
                        firePrompt(obj)
                    end
                end
            end)
        end
    end
end)

-- Fitur: Join Game (Otomatis masuk portal lobby atau menekan tombol UI Join)
task.spawn(function()
    while task.wait(1) do
        if _G.JoinGame then
            pcall(function()
                -- Berjalan otomatis ke portal lobby jika ada
                local portal = workspace:FindFirstChild("JoinPortal", true) or workspace:FindFirstChild("LobbyPortal", true)
                if portal and portal:IsA("BasePart") then
                    HumanoidRootPart.CFrame = portal.CFrame
                end
                
                -- Mencari dan mengklik tombol "Join" di layar secara otomatis
                local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                if PlayerGui then
                    for _, button in ipairs(PlayerGui:GetDescendants()) do
                        if button:IsA("TextButton") and (button.Text:lower():find("join") or button.Name:lower():find("join")) and button.Visible then
                            button:Activate()
                        end
                    end
                end
            end)
        end
    end
end)
