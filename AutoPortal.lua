-- [[ KEYS | PUNYA NAA - WORK SCRIPT 2026 ]] --

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Keys | punya naa", "DarkTheme")

-- [[ TABS & SECTIONS ]] --
local MainTab = Window:NewTab("Config")
local MainSection = MainTab:NewSection("Automation")

-- Pemain Lokal
local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Fungsi Teleport Aman (Bypass Anti-Cheat Dasar)
local function safeTeleport(targetCFrame)
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = targetCFrame
    end
end

-- [[ 1. FITUR AUTOFARM / AUTO WINS ]] --
-- Mengotomatiskan jalan menuju pintu keluar utama untuk memenangkan game
MainSection:NewToggle("AutoFarm", "Otomatis menuju pintu keluar utama untuk menang", function(state)
    _G.AutoFarm = state
    while _G.AutoFarm do
        task.wait(1)
        pcall(function()
            -- Mencari portal keluar/pintu EXIT seperti di dalam video gameplay
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "ExitDoor" or obj.Name == "EscapePortal" or obj.Name:lower():find("exit") then
                    if obj:IsA("BasePart") then
                        safeTeleport(obj.CFrame * CFrame.new(0, 2, 0))
                    elseif obj:IsA("Model") and obj:FindFirstChildOfClass("BasePart") then
                        safeTeleport(obj:GetPivot() * CFrame.new(0, 2, 0))
                    end
                end
            end
        end)
    end
end)

-- [[ 2. FITUR UNLOCK DOORS ]] --
-- Mengotomatiskan pembukaan pintu terkunci dengan memicu tombol interaksi jarak jauh
MainSection:NewToggle("Unlock Doors", "Buka pintu otomatis menggunakan ProximityPrompt", function(state)
    _G.UnlockDoors = state
    while _G.UnlockDoors do
        task.wait(0.3)
        pcall(function()
            for _, door in pairs(workspace:GetDescendants()) do
                if door.Name:lower():find("door") or door.Name:lower():find("gate") then
                    -- Menyalakan interaksi instan jika ada prompt interaksi pintu ("E" atau "G")
                    local prompt = door:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        -- Sesuaikan jarak agar prompt bisa dieksekusi dari jarak jauh
                        prompt.MaxActivationDistance = 9999
                        fireproximityprompt(prompt)
                    end
                end
            end
        end)
    end
end)

-- [[ 3. FITUR PICKUP KEYS ]] --
-- Mendeteksi objek kunci di dalam map lalu menteleportasikannya langsung ke karakter Anda
MainSection:NewToggle("Pickup Keys", "Otomatis mengambil seluruh kunci di dalam map", function(state)
    _G.PickupKeys = state
    while _G.PickupKeys do
        task.wait(0.5)
        pcall(function()
            local character = Player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(workspace:GetDescendants()) do
                    -- Mendeteksi objek bertuliskan "Key" atau "Kunci"
                    if obj.Name:lower():find("key") or obj.Name:lower():find("kunci") then
                        if obj:IsA("BasePart") and obj.Parent:IsA("Model") then
                            -- Teleport model kunci ke tubuh pemain
                            obj.Parent:PivotTo(character.HumanoidRootPart.CFrame)
                        elseif obj:IsA("BasePart") then
                            obj.CFrame = character.HumanoidRootPart.CFrame
                        end
                        
                        -- Otomatis menekan tombol ambil jika kunci menggunakan ProximityPrompt
                        local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            prompt.MaxActivationDistance = 9999
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end)
    end
end)

-- [[ 4. FITUR JOIN GAME ]] --
-- Otomatis mendeteksi tombol lobi "Join" saat game baru dimulai atau ketika Anda berada di lobi utama
MainSection:NewToggle("Join Game", "Otomatis menekan tombol Join / Masuk Lobi baru", function(state)
    _G.JoinGame = state
    while _G.JoinGame do
        task.wait(1)
        pcall(function()
            -- Meniru perilaku tombol "Join" di lobi atas layar seperti pada video menit 00:01
            local gui = Player:FindFirstChildOfClass("PlayerGui")
            if gui then
                for _, v in pairs(gui:GetDescendants()) do
                    if v:IsA("TextButton") and (v.Text:lower():find("join") or v.Name:lower():find("join")) then
                        if v.Visible then
                            -- Simulasi klik kiri pada UI Button resmi game
                            gui.CurrentScreenGui = v.Parent
                            firesignal(v.MouseButton1Click)
                        end
                    end
                end
            end
        end)
    end
end)

-- [[ TAMBAHAN FITUR INSTANT PRESS (Sesuai Gameplay Video) ]] --
-- Di video terdapat fitur 'Instant Press', ini adalah pengoptimalisasi bypass durasi tahan tombol
local MiscSection = MainTab:NewSection("Bypass Utility")
MiscSection:NewToggle("Instant Interaction", "Menghapus durasi loading saat menahan tombol E", function(state)
    _G.InstantPress = state
    game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
        if _G.InstantPress then
            fireproximityprompt(prompt)
        end
    end)
end)

-- [[ FOOTER ]] --
local CreditsSection = MainTab:NewSection("punya naa")
CreditsSection:NewLabel("Script Loader Active ✅")
