-- [[ KEYS | PUNYA NAA - PURE INSTANCE GUI (ANTI-BLOCK) ]] --

-- Hapus GUI lama jika sengaja di-execute ulang agar tidak menumpuk
if game.CoreGui:FindFirstChild("KeysPunyaNaaGui") then
    game.CoreGui.KeysPunyaNaaGui:Destroy()
end

-- [[ PEMBUATAN ELEMEN GUI MURNI (SESUAI GAMBAR) ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeysPunyaNaaGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Frame Utama (Hitam Elegan & Ukuran Kecil Sesuai Gambar)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0) -- Posisi kiri agak ke atas
MainFrame.Size = UDim2.new(0, 280, 0, 320) -- Ukuran minimalis ramping
MainFrame.Active = true
MainFrame.Draggable = true -- Bisa digeser sesuka hati jika menutupi tombol game

-- Garis Pembatas Hijau/Merah di Atas Menu
local Line = Instance.new("Frame")
Line.Parent = MainFrame
Line.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Garis Hijau khas
Line.Position = UDim2.new(0, 0, 0, 40)
Line.Size = UDim2.new(1, 0, 0, 2)

-- Judul "Keys | punya naa"
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "Keys  |  punya naa"
Title.TextColor3 = Color3.fromRGB(230, 50, 80) -- Merah pudar sesuai gambar
Title.Font = Enum.Font.SourceSans
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 180, 0, 40)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Sub-judul "Config"
local ConfigLabel = Instance.new("TextLabel")
ConfigLabel.Parent = MainFrame
ConfigLabel.Text = "Config"
ConfigLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ConfigLabel.Font = Enum.Font.SourceSans
ConfigLabel.TextSize = 16
ConfigLabel.BackgroundTransparency = 1
ConfigLabel.Position = UDim2.new(0, 0, 0, 45)
ConfigLabel.Size = UDim2.new(1, 0, 0, 30)

-- Label Bawah "punya naaa"
local FooterLabel = Instance.new("TextLabel")
FooterLabel.Parent = MainFrame
FooterLabel.Text = "punya naaa"
FooterLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
FooterLabel.Font = Enum.Font.SourceSans
FooterLabel.TextSize = 14
FooterLabel.BackgroundTransparency = 1
FooterLabel.Position = UDim2.new(0, 0, 1, -30)
FooterLabel.Size = UDim2.new(1, 0, 0, 25)

-- [[ FUNGSI MEMBUAT FITUR CHECKBOX TOGGLE ]] --
local toggleCount = 0
local function createToggle(name, callback)
    local yPos = 80 + (toggleCount * 45)
    toggleCount = toggleCount + 1

    local Label = Instance.new("TextLabel")
    Label.Parent = MainFrame
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 16
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, yPos)
    Label.Size = UDim2.new(0, 150, 0, 30)
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Box = Instance.new("TextButton")
    Box.Parent = MainFrame
    Box.Text = ""
    Box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Box.BorderColor3 = Color3.fromRGB(60, 60, 60)
    Box.Position = UDim2.new(1, -45, 0, yPos + 5)
    Box.Size = UDim2.new(0, 20, 0, 20)
    Box.Font = Enum.Font.SourceSansBold
    Box.TextSize = 14
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)

    local enabled = false
    Box.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Box.Text = "✓" -- Tanda centang putih sesuai gambar Anda
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            Box.Text = ""
        end
        callback(enabled)
    end)
end

-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 40)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)


-- [[ LOGIKA LOGIK & VARIABEL URUTAN AUTOFARM ]] --
local Player = game.Players.LocalPlayer

local function tp(cframe)
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cframe
    end
end

local function isLobby()
    local exit = workspace:FindFirstChild("ExitDoor") or workspace:FindFirstChild("EscapePortal") or workspace:FindFirstChild("Exit")
    return exit == nil
end

-- Pembuatan Fungsi Otomatisasi Terintegrasi
createToggle("AutoFarm", function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            task.wait(0.5)
            pcall(function()
                local char = Player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                -- LANGKAH 1: DI LOBBY -> Teleport / Klik Join Game
                if isLobby() then
                    local joinPart = workspace:FindFirstChild("JoinPart") or workspace:FindFirstChild("QueuePad") or workspace:FindFirstChild("LobbyTeleport")
                    if joinPart then
                        tp(joinPart.CFrame * CFrame.new(0, 2, 0))
                    else
                        local gui = Player:FindFirstChildOfClass("PlayerGui")
                        if gui then
                            for _, v in pairs(gui:GetDescendants()) do
                                if v:IsA("TextButton") and (v.Text:lower():find("join") or v.Text:lower():find("play")) and v.Visible then
                                    firesignal(v.MouseButton1Click)
                                end
                            end
                        end
                    end
                    
                -- LANGKAH 2: JIKA SUDAH DI MATCH
                else
                    local hasKey = char:FindFirstChildOfClass("Tool") and (char:FindFirstChildOfClass("Tool").Name:lower():find("key") or char:FindFirstChildOfClass("Tool").Name:lower():find("kunci"))
                    
                    if not hasKey then
                        -- Cari kunci dan Teleport langsung ke kunci
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if (obj.Name:lower():find("key") or obj.Name:lower():find("kunci")) and (obj:IsA("BasePart") or obj:IsA("Model")) then
                                local targetCF = obj:IsA("BasePart") and obj.CFrame or obj:GetPivot()
                                tp(targetCF * CFrame.new(0, 1, 0))
                                
                                local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then fireproximityprompt(prompt) end
                                break
                            end
                        end
                    else
                        -- LANGKAH 3: PUNYA KUNCI -> Buka Pintu Biasa
                        local doorFound = false
                        for _, door in pairs(workspace:GetDescendants()) do
                            if (door.Name:lower():find("door") or door.Name:lower():find("gate")) and not door.Name:lower():find("exit") then
                                local prompt = door:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then
                                    local targetCF = door:IsA("BasePart") and door.CFrame or door:GetPivot()
                                    tp(targetCF * CFrame.new(0, 0, -2))
                                    fireproximityprompt(prompt)
                                    doorFound = true
                                    break
                                end
                            end
                        end
                        
                        -- LANGKAH 4: SELESAI PINTU -> Langsung menuju Pintu EXIT utama untuk menang dan kembali ke lobby
                        if not doorFound then
                            local exit = workspace:FindFirstChild("ExitDoor") or workspace:FindFirstChild("EscapePortal") or workspace:FindFirstChild("Exit")
                            if exit then
                                local targetCF = exit:IsA("BasePart") and exit.CFrame or exit:GetPivot()
                                tp(targetCF * CFrame.new(0, 2, 0))
                                
                                local exitPrompt = exit:FindFirstChildOfClass("ProximityPrompt") or exit.Parent:FindFirstChildOfClass("ProximityPrompt")
                                if exitPrompt then fireproximityprompt(exitPrompt) end
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

createToggle("Unlock Doors", function(state)
    _G.UnlockDoors = state
    task.spawn(function()
        while _G.UnlockDoors do
            task.wait(0.3)
            if not isLobby() then
                pcall(function()
                    for _, door in pairs(workspace:GetDescendants()) do
                        if door.Name:lower():find("door") or door.Name:lower():find("gate") then
                            local prompt = door:FindFirstChildOfClass("ProximityPrompt")
                            if prompt then fireproximityprompt(prompt) end
                        end
                    end
                end)
            end
        end
    end)
end)

createToggle("Pickup Keys", function(state)
    _G.PickupKeys = state
    task.spawn(function()
        while _G.PickupKeys do
            task.wait(0.5)
            if not isLobby() then
                pcall(function()
                    local char = Player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj.Name:lower():find("key") or obj.Name:lower():find("kunci") then
                                if obj:IsA("BasePart") then obj.CFrame = char.HumanoidRootPart.CFrame end
                                local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then fireproximityprompt(prompt) end
                            end
                        end
                    end
                end)
            end
        end
    end)
end)

createToggle("Join Game", function(state)
    _G.JoinGame = state
    task.spawn(function()
        while _G.JoinGame do
            task.wait(1)
            if isLobby() then
                pcall(function()
                    local gui = Player:FindFirstChildOfClass("PlayerGui")
                    if gui then
                        for _, v in pairs(gui:GetDescendants()) do
                            if v:IsA("TextButton") and (v.Text:lower():find("join") or v.Text:lower():find("play")) and v.Visible then
                                firesignal(v.MouseButton1Click)
                            end
                        end
                    end
                end)
            end
        end
    end)
end)

-- Pasif Instant Press
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    fireproximityprompt(prompt)
end)
