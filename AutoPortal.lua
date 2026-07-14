-- [[ KEYS | PUNYA NAA - ULTRA COMPACT RAYFIELD EDITION ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Membuat jendela micro
local Window = Rayfield:CreateWindow({
   Name = "Keys | punya naa",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by naa",
   ConfigurationSaving = { Enabled = false }
})

-- Memaksa ukuran GUI menjadi sangat kecil di layar HP/PC
if game.CoreGui:FindFirstChild("Rayfield") then
    local main = game.CoreGui.Rayfield:FindFirstChild("Main")
    if main then
        main.Size = UDim2.new(0, 290, 0, 190) -- Sangat kecil dan minimalis
    end
end

local Tab = Window:CreateTab("Config", nil)
local Player = game.Players.LocalPlayer

-- Helper Teleport
local function tp(cframe)
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cframe
    end
end

-- Deteksi Status Game
local function isLobby()
    local exit = workspace:FindFirstChild("ExitDoor") or workspace:FindFirstChild("EscapePortal") or workspace:FindFirstChild("Exit")
    return exit == nil
end

-- [[ INTEGRATED SMART AUTOFARM ]] --
local AutoFarmToggle = Tab:CreateToggle({
   Name = "Smart AutoFarm",
   CurrentValue = false,
   Flag = "AutoFarmFlag",
   Callback = function(Value)
      _G.AutoFarm = Value
      
      task.spawn(function()
          while _G.AutoFarm do
              task.wait(0.5)
              pcall(function()
                  local char = Player.Character
                  if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                  
                  -- ALUR 1: DI LOBBY (Teleport Masuk Game / Klik UI Join)
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
                      
                  -- ALUR 2: DI DALAM MATCH
                  else
                      local hasKey = char:FindFirstChildOfClass("Tool") and (char:FindFirstChildOfClass("Tool").Name:lower():find("key") or char:FindFirstChildOfClass("Tool").Name:lower():find("kunci"))
                      
                      if not hasKey then
                          -- Teleport ke Kunci terdekat
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
                          -- ALUR 3: PUNYA KUNCI -> Teleport ke Pintu Biasa
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
                          
                          -- ALUR 4: PINTU BIASA TERBUKA -> Menuju Pintu EXIT
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
   end,
})

-- [[ BYPASS PENDUKUNG ]] --
local InstantToggle = Tab:CreateToggle({
   Name = "Instant Interaction",
   CurrentValue = false,
   Flag = "InstantFlag",
   Callback = function(Value)
      _G.Instant = Value
      if _G.Instant then
          game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
              if _G.Instant then fireproximityprompt(prompt) end
          end)
      end
   end,
})
