-- Simple Delta Script (Auto Doors & Auto Win)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Membuat UI (Menu) Sederhana
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoDoorBtn = Instance.new("TextButton")
local AutoWinBtn = Instance.new("TextButton")

-- Melindungi UI agar tidak mudah dideteksi
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "KeysSimpleHub"

-- Desain Frame Utama (Bisa digeser)
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.2, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 200, 0, 140)
Frame.Active = true
Frame.Draggable = true -- Membuat menu bisa digeser di layar HP

Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🔑 Keys - Simple Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

-- Tombol Auto Door
AutoDoorBtn.Parent = Frame
AutoDoorBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoDoorBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
AutoDoorBtn.Size = UDim2.new(0.8, 0, 0, 30)
AutoDoorBtn.Text = "Auto Doors"
AutoDoorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDoorBtn.Font = Enum.Font.Gotham

-- Tombol Auto Win
AutoWinBtn.Parent = Frame
AutoWinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoWinBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
AutoWinBtn.Size = UDim2.new(0.8, 0, 0, 30)
AutoWinBtn.Text = "Auto Win"
AutoWinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoWinBtn.Font = Enum.Font.Gotham

-- Fungsi: Auto Door (Membuka Pintu Secara Otomatis)
AutoDoorBtn.MouseButton1Click:Connect(function()
    AutoDoorBtn.Text = "Membuka..."
    
    -- Mencari semua ProximityPrompt (tombol E/interaksi) di dalam game
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            -- Bypass jarak interaksi dan otomatis ditekan
            obj.RequiresLineOfSight = false
            obj.MaxActivationDistance = 50 
            fireproximityprompt(obj)
            task.wait(0.1)
        end
    end
    
    task.wait(0.5)
    AutoDoorBtn.Text = "Auto Doors"
end)

-- Fungsi: Auto Win (Teleport ke garis akhir)
AutoWinBtn.MouseButton1Click:Connect(function()
    AutoWinBtn.Text = "Teleporting..."
    
    -- Catatan: Ganti "WinPart" atau "EndZone" sesuai dengan nama folder/part akhir di game tersebut
    -- Script ini akan mencoba mendeteksi tempat spawn kemenangan
    local winArea = workspace:FindFirstChild("WinPart") or workspace:FindFirstChild("EndZone") 
    
    if winArea and winArea:IsA("BasePart") then
        rootPart.CFrame = winArea.CFrame + Vector3.new(0, 3, 0)
    else
        -- Jika part tidak ketemu secara spesifik, bypass CFrame jarak jauh
        rootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, -500) 
    end
    
    task.wait(1)
    AutoWinBtn.Text = "Auto Win"
end)
