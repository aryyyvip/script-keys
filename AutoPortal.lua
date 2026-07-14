-- [[ KEYS | PUNYA NAA - ULTRA COMPACT & LOGIC FIXED ]] --

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Membuat jendela super kecil (280x180)
local Window = OrionLib:MakeWindow({
    Name = "Keys", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Loading..."
})

if game.CoreGui:FindFirstChild("Orion") then
    local mainFrame = game.CoreGui.Orion:FindFirstChild("Main")
    if mainFrame then
        mainFrame.Size = UDim2.new(0, 280, 0, 180) -- Ukuran micro, sangat pas di pojok layar
    end
end

local Tab = Window:MakeTab({Name = "Config"})
local Player = game.Players.LocalPlayer

-- Fungsi Helper Teleport
local function tp(cframe)
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cframe
    end
end

-- Deteksi Status Game
local function isLobby()
    -- Menguji apakah pintu keluar / kunci belum ada di workspace (berarti masih di lobby)
    local exit = workspace:FindFirstChild("ExitDoor") or workspace:FindFirstChild("EscapePortal") or workspace:FindFirstChild("Exit")
    return exit == nil
end

-- [[ UTAMA: ALL-IN-ONE AUTOMATION ]] --
Tab:AddToggle({
    Name = "AutoFarm (Smart Sequence)",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        task.spawn(function()
            while _G.AutoFarm do
                task.wait(0.5)
                pcall(function()
                    local char = Player.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    
                    -- ALUR 1: JIKA MASIH DI LOBBY (Teleport untuk Join Game)
                    if isLobby() then
                        -- Cari Pad Antrean / Teleporter untuk masuk game di lobby
                        local joinPart = workspace:FindFirstChild("JoinPart") or workspace:FindFirstChild("QueuePad") or workspace:FindFirstChild("LobbyTeleport")
                        if joinPart then
                            tp(joinPart.CFrame * CFrame.new(0, 2, 0))
                        else
                            -- Jika berupa tombol UI, otomatis klik tombol Join/Play
                            local gui = Player:FindFirstChildOfClass("PlayerGui")
                            if gui then
                                for _, v in pairs(gui:GetDescendants()) do
                                    if v:IsA("TextButton") and (v.Text:lower():find("join") or v.Text:lower():find("play")) and v.Visible then
                                        firesignal(v.MouseButton1Click)
                                    end
                                end
                            end
                        end
                        
                    -- ALUR 2: JIKA SUDAH MASUK GAME / MATCH
                    else
                        -- Cek Kunci (Apakah karakter memegang kunci?)
                        local hasKey = char:FindFirstChildOfClass("Tool") and (char:FindFirstChildOfClass("Tool").Name:lower():find("key") or char:FindFirstChildOfClass("Tool").Name:lower():find("kunci"))
                        
                        if not hasKey then
                            -- Cari kunci di map dan teleport ke sana
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if (obj.Name:lower():find("key") or obj.Name:lower():find("kunci")) and (obj:IsA("BasePart") or obj:IsA("Model")) then
                                    local targetCF = obj:IsA("BasePart") and obj.CFrame or obj:GetPivot()
                                    tp(targetCF * CFrame.new(0, 1, 0))
                                    
                                    -- Ambil interaksi kunci jika ada ProximityPrompt
                                    local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                                    if prompt then fireproximityprompt(prompt) end
                                    break
                                end
                            end
                        else
                            -- ALUR 3: JIKA SUDAH PUNYA KUNCI (Teleport ke Pintu Terdekat)
                            local doorFound = false
                            for _, door in pairs(workspace:GetDescendants()) do
                                if (door.Name:lower():find("door") or door.Name:lower():find("gate")) and not door.Name:lower():find("exit") then
                                    local prompt = door:FindFirstChildOfClass("ProximityPrompt")
                                    if prompt then
                                        local targetCF = door:IsA("BasePart") and door.CFrame or door:GetPivot()
                                        tp(targetCF * CFrame.new(0, 0, -2)) -- Depan pintu
                                        fireproximityprompt(prompt)
                                        doorFound = true
                                        break
                                    end
                                end
                            end
                            
                            -- ALUR 4: JIKA PINTU BIASA SELESAI, GO TO EXIT DOOR
                            if not doorFound then
                                local exit = workspace:FindFirstChild("ExitDoor") or workspace:FindFirstChild("EscapePortal") or workspace:FindFirstChild("Exit")
                                if exit then
                                    local targetCF = exit:IsA("BasePart") and exit.CFrame or exit:GetPivot()
                                    tp(targetCF * CFrame.new(0, 2, 0))
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end    
})

-- [[ FITUR PENDUKUNG PASIF ]] --
Tab:AddToggle({
    Name = "Instant Doors & Items",
    Default = false,
    Callback = function(Value)
        _G.Instant = Value
        if _G.Instant then
            game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                if _G.Instant then fireproximityprompt(prompt) end
            end)
        end
    end
})

OrionLib:Init()
