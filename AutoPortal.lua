-- [[ KEYS | PUNYA NAA - COMPACT & FIXED VERSION ]] --

-- Menggunakan library GUI yang jauh lebih kecil dan responsif
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Keys | punya naa", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Loading...",
    IntroIcon = "rbxassetid://4483345998"
})

-- Memastikan ukuran GUI kecil dan pas untuk layar mobile/PC (mengikuti gambar)
if game.CoreGui:FindFirstChild("Orion") then
    local mainFrame = game.CoreGui.Orion:FindFirstChild("Main")
    if mainFrame then
        mainFrame.Size = UDim2.new(0, 380, 0, 250) -- Mengunci ukuran agar minimalis
    end
end

local Tab = Window:MakeTab({
    Name = "Config",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Variabel Pemain
local Player = game.Players.LocalPlayer

-- Fungsi pengaman agar tidak ngebug teleport di lobby utama
local function isInMatch()
    -- Cek jika ada objek khusus game (seperti monster/pintu match). Jika di lobby (PlaceID lobi), kembalikan false.
    if workspace:FindFirstChild("Lobby") or not workspace:FindFirstChild("MatchFolder") then
        -- Catatan: Jika nama folder game bukan 'MatchFolder', script akan mendeteksi dari ada tidaknya pintu keluar
        if not workspace:FindFirstChild("ExitDoor") and not workspace:FindFirstChild("EscapePortal") then
            return false -- Sedang di Lobby
        end
    end
    return true -- Sedang di dalam Match
end

-- [[ 1. AUTOFARM (FIXED) ]] --
Tab:AddToggle({
    Name = "AutoFarm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        while _G.AutoFarm do
            task.wait(1)
            if isInMatch() then
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name == "ExitDoor" or obj.Name == "EscapePortal" or obj.Name:lower():find("exit") then
                            local char = Player.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                if obj:IsA("BasePart") then
                                    char.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                                elseif obj:IsA("Model") then
                                    char.HumanoidRootPart.CFrame = obj:GetPivot() * CFrame.new(0, 2, 0)
                                end
                            end
                        end
                    end
                end)
            end
        end
    end    
})

-- [[ 2. UNLOCK DOORS ]] --
Tab:AddToggle({
    Name = "Unlock Doors",
    Default = false,
    Callback = function(Value)
        _G.UnlockDoors = Value
        while _G.UnlockDoors do
            task.wait(0.3)
            if isInMatch() then
                pcall(function()
                    for _, door in pairs(workspace:GetDescendants()) do
                        if door.Name:lower():find("door") or door.Name:lower():find("gate") then
                            local prompt = door:FindFirstChildOfClass("ProximityPrompt")
                            if prompt then
                                prompt.MaxActivationDistance = 50 -- Jarak wajar agar tidak di-kick anti-cheat
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                end)
            end
        end
    end    
})

-- [[ 3. PICKUP KEYS ]] --
Tab:AddToggle({
    Name = "Pickup Keys",
    Default = false,
    Callback = function(Value)
        _G.PickupKeys = Value
        while _G.PickupKeys do
            task.wait(0.5)
            if isInMatch() then
                pcall(function()
                    local char = Player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj.Name:lower():find("key") or obj.Name:lower():find("kunci") then
                                -- Bawa kunci langsung ke posisi karakter secara halus
                                if obj:IsA("BasePart") then
                                    obj.CFrame = char.HumanoidRootPart.CFrame
                                elseif obj:IsA("Model") then
                                    obj:PivotTo(char.HumanoidRootPart.CFrame)
                                end
                                
                                local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then fireproximityprompt(prompt) end
                            end
                        end
                    end
                end)
            end
        end
    end    
})

-- [[ 4. JOIN GAME ]] --
Tab:AddToggle({
    Name = "Join Game",
    Default = false,
    Callback = function(Value)
        _G.JoinGame = Value
        while _G.JoinGame do
            task.wait(1)
            pcall(function()
                -- Hanya menekan tombol join jika posisi pemain SEDANG di lobi
                if not isInMatch() then
                    local gui = Player:FindFirstChildOfClass("PlayerGui")
                    if gui then
                        for _, v in pairs(gui:GetDescendants()) do
                            if v:IsA("TextButton") and (v.Text:lower():find("join") or v.Name:lower():find("join") or v.Text:lower():find("play")) then
                                if v.Visible then
                                    firesignal(v.MouseButton1Click)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end    
})

OrionLib:Init()
