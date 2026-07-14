-- [[ KEYS | PUNYA NAA - ROBLOX GUI SCRIPT ]] --

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Keys | punya naa", "DarkTheme")

-- Mengubah warna aksen menjadi Merah/Hijau sesuai gambar Anda
for i, v in pairs(game.CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "Keys | punya naa" then
        -- Kavo UI otomatis menyesuaikan tema gelap (DarkTheme)
    end
end

-- [[ TABS & SECTIONS ]] --
local MainTab = Window:NewTab("Config")
local MainSection = MainTab:NewSection("Automation")

-- [[ LOGIC / FITUR DUMMY ]] --
-- Catatan: Script di bawah ini menggunakan logika umum game bertema kunci/pintu (seperti Doors atau Keys).
-- Anda mungkin perlu menyesuaikan nama objek di Workspace sesuai struktur game aslinya.

-- 1. FITUR AUTOFARM
MainSection:NewToggle("AutoFarm", "Otomatis menyelesaikan level / farm koin", function(state)
    _G.AutoFarm = state
    while _G.AutoFarm do
        task.wait(1)
        pcall(function()
            -- Logika mencari objek finish atau koin
            -- Contoh: teleport ke checkpoint berikutnya
            print("AutoFarm sedang berjalan...")
        end)
    end
end)

-- 2. FITUR UNLOCK DOORS
MainSection:NewToggle("Unlock Doors", "Otomatis membuka semua pintu terkunci", function(state)
    _G.UnlockDoors = state
    while _G.UnlockDoors do
        task.wait(0.5)
        pcall(function()
            for _, door in pairs(workspace:GetDescendants()) do
                if door.Name:lower():find("door") or door.Name:lower():find("pintu") then
                    -- Logika bypass pintu atau memicu fungsi 'Open'
                    -- ProximityPrompt otomatis dipicu jika ada:
                    local prompt = door:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        fireproximityprompt(prompt)
                    end
                end
            end
        end)
    end
end)

-- 3. FITUR PICKUP KEYS
MainSection:NewToggle("Pickup Keys", "Otomatis mengambil semua kunci di map", function(state)
    _G.PickupKeys = state
    while _G.PickupKeys do
        task.wait(0.5)
        pcall(function()
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name:lower():find("key") or obj.Name:lower():find("kunci") then
                        -- Teleport / Ambil Kunci
                        if obj:IsA("BasePart") then
                            obj.CFrame = character.HumanoidRootPart.CFrame
                        elseif obj:IsA("Model") and obj:FindFirstChildOfClass("BasePart") then
                            obj:MoveTo(character.HumanoidRootPart.Position)
                        end
                        
                        -- Jika menggunakan ProximityPrompt
                        local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj:GetComponentOfClass("ProximityPrompt")
                        if prompt then fireproximityprompt(prompt) end
                    end
                end
            end
        end)
    end
end)

-- 4. FITUR JOIN GAME
MainSection:NewToggle("Join Game", "Otomatis masuk ke antrean atau match baru", function(state)
    _G.JoinGame = state
    if _G.JoinGame then
        pcall(function()
            -- Logika otomatis masuk lobi / menekan tombol 'Play' di game
            print("Auto Join Game diaktifkan.")
            -- Anda bisa menambahkan fungsi TeleportService ke Place ID game utama jika ini di Lobby
        end)
    end
end)

-- [[ FOOTER INFO ]] --
local CreditsSection = MainTab:NewSection("punya naa")
CreditsSection:NewLabel("Script buatan: punya naa")
