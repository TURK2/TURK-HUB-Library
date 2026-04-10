local Library = {Flags = {}, Keybinds = {}}
local TS, UIS, plr = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("Players").LocalPlayer

-- [ Cleanup ]
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "TURK_ULTIMATE_V4" then v:Destroy() end 
end

local Theme = {
    Main = Color3.fromRGB(11, 11, 14), 
    Top = Color3.fromRGB(16, 16, 21), 
    Accent = Color3.fromRGB(0, 255, 200),
    Secondary = Color3.fromRGB(22, 22, 28), 
    Text = Color3.fromRGB(255, 255, 255), 
    TextSemi = Color3.fromRGB(170, 170, 180),
    Element = Color3.fromRGB(28, 28, 35), 
    Stroke = Color3.fromRGB(55, 55, 70),
}

local function Tween(obj, goal, t, style) 
    local info = TweenInfo.new(t or 0.4, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tween = TS:Create(obj, info, goal)
    tween:Play()
    return tween
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

function Library:CreateWindow(Config)
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_ULTIMATE_V4"; Gui.IgnoreGuiInset = true
    
    -- [ 📱 Auto-Device Detection & Scaling ]
    local View = workspace.CurrentCamera.ViewportSize
    local isMobile = UIS.TouchEnabled or View.X < 700
    local isTablet = View.X >= 700 and View.X < 1024
    
    local MainWidth = isMobile and 400 or (isTablet and 500 or 580)
    local MainHeight = isMobile and 280 or (isTablet and 340 or 380)
    local SidebarWidth = isMobile and 110 or 155
    
    -- [ 🚀 Splash Screen ]
    local LoadFrame = Instance.new("Frame", Gui)
    LoadFrame.Size = UDim2.new(0, 260, 0, 80); LoadFrame.Position = UDim2.new(0.5, 0, 0.5, 0); LoadFrame.AnchorPoint = Vector2.new(0.5, 0.5); LoadFrame.BackgroundColor3 = Theme.Main; LoadFrame.ClipsDescendants = true
    Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 15)
    local LS = Instance.new("UIStroke", LoadFrame); LS.Color = Theme.Accent; LS.Thickness = 2
    local LTitle = Instance.new("TextLabel", LoadFrame); LTitle.Size = UDim2.new(1, 0, 1, 0); LTitle.Text = "TURK HUB V4"; LTitle.TextColor3 = Theme.Text; LTitle.Font = "GothamBlack"; LTitle.TextSize = 22; LTitle.BackgroundTransparency = 1
    
    task.wait(0.5)
    Tween(LTitle, {TextTransparency = 1}, 0.5)
    task.wait(0.5)
    Tween(LoadFrame, {Size = UDim2.new(0,0,0,0)}, 0.5, Enum.EasingStyle.Back)

    -- [ 🔘 Premium Rect-Toggle (TURK-HUB) ]
    local TogF = Instance.new("Frame", Gui)
    TogF.Size = UDim2.new(0, 130, 0, 42); TogF.Position = UDim2.new(0.5, -65, 0, 50); TogF.BackgroundColor3 = Theme.Main; TogF.BackgroundTransparency = 0.1; TogF.Visible = false
    Instance.new("UICorner", TogF).CornerRadius = UDim.new(0, 10)
    local TS_Tog = Instance.new("UIStroke", TogF); TS_Tog.Color = Theme.Accent; TS_Tog.Thickness = 2
    
    local TogBtn = Instance.new("TextButton", TogF)
    TogBtn.Size = UDim2.new(1, 0, 1, 0); TogBtn.BackgroundTransparency = 1; TogBtn.Text = "TURK-HUB"; TogBtn.TextColor3 = Theme.Text; TogBtn.Font = "GothamBlack"; TogBtn.TextSize = 14
    MakeDraggable(TogBtn, TogF)

    -- [ 🛡️ Main UI Frame ]
    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 0, 0, 0); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5); Main.BackgroundColor3 = Theme.Main; Main.BackgroundTransparency = 0.05; Main.Visible = false; Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
    local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Theme.Stroke; MainStroke.Thickness = 2
    
    -- RGB Gradient Effect for Border
    local Gradient = Instance.new("UIGradient", MainStroke)
    Gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Theme.Accent), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 150, 255)), ColorSequenceKeypoint.new(1, Theme.Accent)})
    task.spawn(function() while task.wait() do Gradient.Rotation = Gradient.Rotation + 1 end end)

    task.delay(1.2, function()
        TogF.Visible = true; Main.Visible = true
        Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.6, Enum.EasingStyle.Back)
    end)

    local isOpen = true
    TogBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            Main.Visible = true
            Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.5, Enum.EasingStyle.Back)
            Tween(TS_Tog, {Color = Theme.Accent})
        else
            Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.5, Enum.EasingStyle.Back)
            task.delay(0.5, function() if not isOpen then Main.Visible = false end end)
            Tween(TS_Tog, {Color = Theme.Stroke})
        end
    end)

    -- Top Bar
    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1, 0, 0, 55); Top.BackgroundTransparency = 1; MakeDraggable(Top, Main)
    local Title = Instance.new("TextLabel", Top); Title.Size = UDim2.new(1, -40, 1, 0); Title.Position = UDim2.new(0, 20, 0, 0); Title.Text = Config.Name; Title.TextColor3 = Theme.Accent; Title.Font = "GothamBlack"; Title.TextSize = isMobile and 18 or 20; Title.TextXAlignment = "Left"; Title.BackgroundTransparency = 1

    -- [ Sidebar - No Scrollbar Lines ]
    local Side = Instance.new("ScrollingFrame", Main)
    Side.Size = UDim2.new(0, SidebarWidth, 1, -75); Side.Position = UDim2.new(0, 12, 0, 65); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0; Side.CanvasSize = UDim2.new(0,0,0,0); Side.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 6)

    -- [ Content Container ]
    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -(SidebarWidth + 30), 1, -75); Container.Position = UDim2.new(0, SidebarWidth + 20, 0, 65); Container.BackgroundTransparency = 1

    local Tabs = {First = true, Selected = nil}

    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Side)
        TabBtn.Size = UDim2.new(1, -5, 0, 38); TabBtn.BackgroundColor3 = Theme.Secondary; TabBtn.Text = name; TabBtn.TextColor3 = Theme.TextSemi; TabBtn.Font = "GothamBold"; TabBtn.TextSize = isMobile and 11 or 13; TabBtn.AutoButtonColor = false; Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8); local tbs = Instance.new("UIStroke", TabBtn); tbs.Color = Theme.Stroke; tbs.Thickness = 1
        
        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = "Y"
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10); Instance.new("UIPadding", Page).PaddingTop = UDim.new(0, 2)

        TabBtn.MouseButton1Click:Connect(function()
            if Tabs.Selected == TabBtn then return end
            for _, v in pairs(Container:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then Tween(v, {BackgroundColor3 = Theme.Secondary, TextColor3 = Theme.TextSemi}); v.UIStroke.Color = Theme.Stroke end end
            
            Page.Visible = true; Tabs.Selected = TabBtn
            Page.GroupTransparency = 1; Tween(Page, {GroupTransparency = 0}, 0.3) -- Fade in effect
            Tween(TabBtn, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Main}); TabBtn.UIStroke.Color = Theme.Accent
        end)

        if Tabs.First then Tabs.First = false; Tabs.Selected = TabBtn; Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent; TabBtn.TextColor3 = Theme.Main; TabBtn.UIStroke.Color = Theme.Accent end

        local E = {Elements = 0}
        
        function E:CreateButton(D) 
            E.Elements = E.Elements + 1
            local b = Instance.new("TextButton", Page)
            b.Size = UDim2.new(0.96, 0, 0, 42); b.BackgroundColor3 = Theme.Element; b.Text = D.Name; b.TextColor3 = Theme.Text; b.Font = "GothamBold"; b.TextSize = 13; b.LayoutOrder = E.Elements; b.AutoButtonColor = false; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10); local bs = Instance.new("UIStroke", b); bs.Color = Theme.Stroke; bs.ApplyStrokeMode = "Border"
            b.MouseButton1Down:Connect(function() Tween(b, {Size = UDim2.new(0.93, 0, 0, 38)}, 0.1) end)
            b.MouseButton1Up:Connect(function() Tween(b, {Size = UDim2.new(0.96, 0, 0, 42)}, 0.1); D.Callback() end)
        end

        function E:CreateToggle(D) 
            E.Elements = E.Elements + 1
            local state = D.CurrentValue
            local t = Instance.new("TextButton", Page)
            t.Size = UDim2.new(0.96, 0, 0, 45); t.BackgroundColor3 = Theme.Element; t.Text = "    "..D.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextXAlignment = "Left"; t.LayoutOrder = E.Elements; t.AutoButtonColor = false; Instance.new("UICorner", t).CornerRadius = UDim.new(0, 10); local ts = Instance.new("UIStroke", t); ts.Color = Theme.Stroke
            local bg = Instance.new("Frame", t); bg.Size = UDim2.new(0, 36, 0, 18); bg.Position = UDim2.new(1, -48, 0.5, -9); bg.BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(40, 40, 50); Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
            local dot = Instance.new("Frame", bg); dot.Size = UDim2.new(0, 12, 0, 12); dot.Position = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6); dot.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            t.MouseButton1Click:Connect(function() state = not state; Tween(bg, {BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(40, 40, 50)}); Tween(dot, {Position = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)}); D.Callback(state) end)
        end

        function E:CreateSlider(D)
            E.Elements = E.Elements + 1
            local S = Instance.new("Frame", Page)
            S.Size = UDim2.new(0.96, 0, 0, 55); S.BackgroundColor3 = Theme.Element; S.LayoutOrder = E.Elements; Instance.new("UICorner", S).CornerRadius = UDim.new(0, 10)
            local L = Instance.new("TextLabel", S); L.Size = UDim2.new(1, -24, 0, 25); L.Position = UDim2.new(0, 12, 0, 5); L.Text = D.Name; L.TextColor3 = Theme.TextSemi; L.Font="GothamBold"; L.TextSize = 12; L.TextXAlignment="Left"; L.BackgroundTransparency = 1
            local V = Instance.new("TextLabel", S); V.Size = UDim2.new(1, -24, 0, 25); V.Position = UDim2.new(0, -12, 0, 5); V.Text = tostring(D.CurrentValue); V.TextColor3 = Theme.Accent; V.Font="GothamBold"; V.TextXAlignment="Right"; V.BackgroundTransparency = 1
            local B = Instance.new("Frame", S); B.Size = UDim2.new(0.9, 0, 0, 4); B.Position = UDim2.new(0.05, 0, 0.75, 0); B.BackgroundColor3 = Theme.Secondary; Instance.new("UICorner", B)
            local F = Instance.new("Frame", B); F.Size = UDim2.new((D.CurrentValue-D.Range[1])/(D.Range[2]-D.Range[1]), 0, 1, 0); F.BackgroundColor3 = Theme.Accent; Instance.new("UICorner", F)
            local function Update(input) local pos = math.clamp((input.Position.X - B.AbsolutePosition.X) / B.AbsoluteSize.X, 0, 1); local val = math.floor(((D.Range[2] - D.Range[1]) * pos) + D.Range[1]); Tween(F, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1); V.Text = tostring(val); D.Callback(val) end
            local sliding = false
            B.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = true; Update(input) end end)
            UIS.InputChanged:Connect(function(input) if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then Update(input) end end)
            UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = false end end)
        end
        return E
    end
    return Tabs
end

return Library
