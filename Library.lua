local Library = {Flags = {}, Keybinds = {}}
local TS, UIS, plr = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("Players").LocalPlayer

-- [ Cleanup ]
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "TURK_UI" then v:Destroy() end 
end

local Theme = {
    Main = Color3.fromRGB(12, 12, 15), Top = Color3.fromRGB(18, 18, 22), Accent = Color3.fromRGB(0, 230, 255),
    Secondary = Color3.fromRGB(22, 22, 28), Text = Color3.fromRGB(255, 255, 255), TextSemi = Color3.fromRGB(160, 160, 165),
    Element = Color3.fromRGB(25, 25, 32), Stroke = Color3.fromRGB(45, 45, 52), Success = Color3.fromRGB(0, 255, 150)
}

local function Tween(obj, goal, t) 
    TS:Create(obj, TweenInfo.new(t or 0.4, Enum.EasingStyle.Quint), goal):Play() 
end

local function MakeDraggable(obj, target)
    local dragging, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = target.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end

-- [[ 📢 NOTIFICATION SYSTEM ]] --
function Library:Notify(Config)
    local Gui = game:GetService("CoreGui"):FindFirstChild("TURK_UI")
    if not Gui then return end
    
    local Holder = Gui:FindFirstChild("NotifHolder") or Instance.new("Frame", Gui)
    if Holder.Name ~= "NotifHolder" then
        Holder.Name = "NotifHolder"
        Holder.Size = UDim2.new(0, 280, 1, -20)
        Holder.Position = UDim2.new(1, -290, 0, 10)
        Holder.BackgroundTransparency = 1
        local L = Instance.new("UIListLayout", Holder)
        L.VerticalAlignment = Enum.VerticalAlignment.Bottom
        L.Padding = UDim.new(0, 8)
    end

    local NF = Instance.new("Frame", Holder)
    NF.Size = UDim2.new(1, 0, 0, 0) -- Start invisible
    NF.BackgroundColor3 = Theme.Main
    NF.ClipsDescendants = true
    Instance.new("UICorner", NF)
    local Stroke = Instance.new("UIStroke", NF)
    Stroke.Color = Theme.Accent
    Stroke.Transparency = 0.5

    local NT = Instance.new("TextLabel", NF)
    NT.Size = UDim2.new(1, -20, 0, 25)
    NT.Position = UDim2.new(0, 10, 0, 5)
    NT.Text = Config.Title or "Notification"
    NT.TextColor3 = Theme.Accent
    NT.Font = Enum.Font.GothamBlack
    NT.TextSize = 14
    NT.BackgroundTransparency = 1
    NT.TextXAlignment = Enum.TextXAlignment.Left

    local NC = Instance.new("TextLabel", NF)
    NC.Size = UDim2.new(1, -20, 0, 40)
    NC.Position = UDim2.new(0, 10, 0, 25)
    NC.Text = Config.Content or ""
    NC.TextColor3 = Theme.Text
    NC.Font = Enum.Font.GothamBold
    NC.TextSize = 12
    NC.BackgroundTransparency = 1
    NC.TextXAlignment = Enum.TextXAlignment.Left
    NC.TextWrapped = true

    Tween(NF, {Size = UDim2.new(1, 0, 0, 75)})
    
    task.delay(Config.Duration or 3, function()
        Tween(NF, {Size = UDim2.new(1, 0, 0, 0)})
        task.wait(0.5)
        NF:Destroy()
    end)
end

function Library:CreateWindow(Config)
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    Gui.Name = "TURK_UI"
    Gui.IgnoreGuiInset = true

    -- [ ✨ RESPONSIVE SIZING LOGIC ] --
    local View = workspace.CurrentCamera.ViewportSize
    local isMobile = UIS.TouchEnabled
    
    -- ปรับขนาดตามความกว้างหน้าจอ (ถ้ามือถือจะเล็กลงแต่พอดีมือ)
    local MainWidth = isMobile and math.min(View.X * 0.85, 450) or 580
    local MainHeight = isMobile and math.min(View.Y * 0.8, 320) or 380
    local UI_Size = UDim2.new(0, MainWidth, 0, MainHeight)

    -- [ 🔑 KEY SYSTEM ]
    local KeyEnabled = Config.KeySystem or false
    local KeyMain = Instance.new("Frame", Gui)
    KeyMain.Size = UDim2.new(0, 320, 0, 180)
    KeyMain.Position = UDim2.new(0.5, 0, 0.5, 0)
    KeyMain.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyMain.BackgroundColor3 = Theme.Main
    KeyMain.Visible = KeyEnabled
    Instance.new("UICorner", KeyMain)
    Instance.new("UIStroke", KeyMain).Color = Theme.Accent

    local KT = Instance.new("TextLabel", KeyMain)
    KT.Size = UDim2.new(1,0,0,45); KT.Text = "AUTHENTICATION"; KT.TextColor3 = Theme.Accent; KT.Font = "GothamBlack"; KT.TextSize = 18; KT.BackgroundTransparency = 1
    
    local KI = Instance.new("TextBox", KeyMain)
    KI.Size = UDim2.new(0.85, 0, 0, 40); KI.Position = UDim2.new(0.075, 0, 0.35, 0); KI.BackgroundColor3 = Theme.Secondary; KI.PlaceholderText = "Enter Key..."; KI.Text = ""; KI.TextColor3 = Theme.Text; KI.Font = "GothamBold"; Instance.new("UICorner", KI)
    
    local KB = Instance.new("TextButton", KeyMain)
    KB.Size = UDim2.new(0.85, 0, 0, 35); KB.Position = UDim2.new(0.075, 0, 0.65, 0); KB.BackgroundColor3 = Theme.Accent; KB.Text = "LOGIN"; KB.TextColor3 = Theme.Main; KB.Font = "GothamBlack"; Instance.new("UICorner", KB)

    -- [ 🛡️ MAIN UI ]
    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Theme.Main
    Main.Visible = not KeyEnabled
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", Main).Color = Theme.Stroke

    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1, 0, 0, 45); Top.BackgroundColor3 = Theme.Top; MakeDraggable(Top, Main)
    Instance.new("UICorner", Top)
    local TTitle = Instance.new("TextLabel", Top)
    TTitle.Size = UDim2.new(1,-40,1,0); TTitle.Position = UDim2.new(0,20,0,0); TTitle.Text = Config.Name; TTitle.TextColor3 = Theme.Accent; TTitle.Font = "GothamBlack"; TTitle.TextSize = 16; TTitle.TextXAlignment = "Left"; TTitle.BackgroundTransparency = 1

    local TogF = Instance.new("Frame", Gui)
    TogF.Size = UDim2.new(0, 50, 0, 50); TogF.Position = UDim2.new(0.05, 0, 0.1, 0); TogF.BackgroundColor3 = Theme.Main; TogF.Visible = not KeyEnabled; Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0); Instance.new("UIStroke", TogF).Color = Theme.Accent
    local TBtn = Instance.new("TextButton", TogF); TBtn.Size = UDim2.new(1,0,1,0); TBtn.BackgroundTransparency = 1; TBtn.Text = "T"; TBtn.TextColor3 = Theme.Accent; TBtn.Font = "GothamBlack"; TBtn.TextSize = 20; MakeDraggable(TBtn, TogF)

    if not KeyEnabled then Tween(Main, {Size = UI_Size}) end

    KB.MouseButton1Click:Connect(function()
        if KI.Text == Config.Key then
            Tween(KeyMain, {Size = UDim2.new(0,0,0,0)}); task.wait(0.4)
            KeyMain:Destroy(); Main.Visible = true; TogF.Visible = true; Tween(Main, {Size = UI_Size})
            Library:Notify({Title = "Logged In", Content = "Welcome back, "..plr.Name, Duration = 4})
        else
            KI.Text = ""; KI.PlaceholderText = "INVALID KEY"; task.wait(1); KI.PlaceholderText = "Enter Key..."
        end
    end)

    TBtn.MouseButton1Click:Connect(function() 
        local isOpen = Main.Size ~= UDim2.new(0,0,0,0)
        Tween(Main, {Size = isOpen and UDim2.new(0,0,0,0) or UI_Size}) 
    end)

    local Side = Instance.new("ScrollingFrame", Main)
    Side.Size = UDim2.new(0, isMobile and 130 or 160, 1, -60); Side.Position = UDim2.new(0, 10, 0, 55); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 6)
    
    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, isMobile and -155 or -185, 1, -65); Container.Position = UDim2.new(0, isMobile and 145 or 175, 0, 55); Container.BackgroundTransparency = 1

    local Tabs = {First = true}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Side); TabBtn.Size = UDim2.new(1, -5, 0, 35); TabBtn.BackgroundColor3 = Theme.Secondary; TabBtn.Text = " "..name; TabBtn.TextColor3 = Theme.TextSemi; TabBtn.Font = "GothamBold"; TabBtn.TextSize = 12; TabBtn.TextXAlignment = "Left"; Instance.new("UICorner", TabBtn)
        local Page = Instance.new("ScrollingFrame", Container); Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8); Page.AutomaticCanvasSize = "Y"
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then Tween(v, {BackgroundColor3 = Theme.Secondary, TextColor3 = Theme.TextSemi}) end end
            Page.Visible = true; Tween(TabBtn, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Main})
        end)
        
        if Tabs.First then Tabs.First = false; Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent; TabBtn.TextColor3 = Theme.Main end
        
        local E = {}
        function E:CreateSection(n) 
            local l = Instance.new("TextLabel", Page); l.Size = UDim2.new(1,-10,0,25); l.Text = "— "..n:upper(); l.TextColor3 = Theme.Accent; l.Font = "GothamBlack"; l.TextSize = 11; l.BackgroundTransparency = 1; l.TextXAlignment = "Left" 
        end
        function E:CreateButton(D) 
            local b = Instance.new("TextButton", Page); b.Size = UDim2.new(1,-10,0,40); b.BackgroundColor3 = Theme.Element; b.Text = D.Name; b.TextColor3 = Theme.Text; b.Font = "GothamBold"; b.TextSize = 13; Instance.new("UICorner", b); Instance.new("UIStroke", b).Color = Theme.Stroke; b.MouseButton1Click:Connect(D.Callback) 
        end
        function E:CreateToggle(D) 
            local s = D.CurrentValue; local t = Instance.new("TextButton", Page); t.Size = UDim2.new(1,-10,0,40); t.BackgroundColor3 = Theme.Element; t.Text = "    "..D.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextSize = 13; t.TextXAlignment = "Left"; Instance.new("UICorner", t)
            local bg = Instance.new("Frame", t); bg.Size = UDim2.new(0,34,0,18); bg.Position = UDim2.new(1,-44,0.5,-9); bg.BackgroundColor3 = s and Theme.Accent or Theme.Secondary; Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
            t.MouseButton1Click:Connect(function() s = not s; Tween(bg, {BackgroundColor3 = s and Theme.Accent or Theme.Secondary}); D.Callback(s) end)
        end
        function E:CreateSlider(D)
            local S = Instance.new("Frame", Page); S.Size = UDim2.new(1,-10,0,55); S.BackgroundColor3 = Theme.Element; Instance.new("UICorner", S)
            local L = Instance.new("TextLabel", S); L.Size = UDim2.new(1,-20,0,25); L.Position = UDim2.new(0,12,0,5); L.Text = D.Name; L.TextColor3 = Theme.Text; L.Font="GothamBold"; L.TextSize = 12; L.TextXAlignment="Left"; L.BackgroundTransparency = 1
            local V = Instance.new("TextLabel", S); V.Size = UDim2.new(1,-20,0,25); V.Position = UDim2.new(0,-12,0,5); V.Text = tostring(D.CurrentValue); V.TextColor3 = Theme.Accent; V.Font="GothamBold"; V.TextSize = 12; V.TextXAlignment="Right"; V.BackgroundTransparency = 1
            local B = Instance.new("Frame", S); B.Size = UDim2.new(0.9,0,0,4); B.Position = UDim2.new(0.05,0,0.75,0); B.BackgroundColor3 = Theme.Secondary; Instance.new("UICorner", B)
            local F = Instance.new("Frame", B); F.Size = UDim2.new((D.CurrentValue-D.Range[1])/(D.Range[2]-D.Range[1]),0,1,0); F.BackgroundColor3 = Theme.Accent; Instance.new("UICorner", F)
            B.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then local p = math.clamp((i.Position.X - B.AbsolutePosition.X) / B.AbsoluteSize.X, 0, 1); local v = math.floor(((D.Range[2]-D.Range[1])*p)+D.Range[1]); Tween(F, {Size = UDim2.new(p,0,1,0)}, 0.1); V.Text = tostring(v); D.Callback(v) end end)
        end
        return E
    end
    return Tabs
end

return Library
