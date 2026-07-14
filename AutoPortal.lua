local library = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local title = Instance.new("TextLabel")

-- Setup UI (Sederhana)
library.Parent = game.CoreGui
mainFrame.Parent = library
mainFrame.Size = UDim2.new(0, 250, 0, 300)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Active = true
mainFrame.Draggable = true

title.Parent = mainFrame
title.Text = "Keys | punya naa"
title.Size = UDim2.new(1, 0, 0, 30)
title.TextColor3 = Color3.new(1, 0, 0) -- Warna merah seperti di foto

-- Fungsi untuk membuat toggle (checkbox)
local function createToggle(name, yPos)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = name .. "                                [ ]"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function()
        -- Logika script Anda di sini
        print(name .. " diaktifkan")
    end)
end

-- Menambahkan opsi
createToggle("AutoFarm", 50)
createToggle("Unlock Doors", 100)
createToggle("Pickup Keys", 150)
createToggle("Join Game", 200)
