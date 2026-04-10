local Library = {Flags = {}, Keybinds = {}, Theme = {}}
local TS, UIS, RS = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("RunService")

-- [ ⚡ CLEANUP ]
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "TURK_MICRO_SCALE" then v:Destroy() end 
end

local Theme = {
    Main = Color3.fromRGB(6, 7, 10),
    Accent = Color3.fromRGB(0, 255, 255),
    Secondary = Color3.fromRGB(12, 15, 22),
    Text = Color3.fromRGB(255, 255, 255),
    Element = Color3.fromRGB(18, 22, 30),
    Stroke = Color3.fromRGB(35, 45, 60),
    Success = Color3.fromRGB(0, 255, 120)
}

-- [ 📐 MICRO ADAPTIVE SCALING ]
local View = workspace.CurrentCamera.ViewportSize
local IsMobile = (View.X < 700)
local IsTablet = (View.X >= 700 and View.X < 1024)

-- ปรับขนาดให้เล็กกะทัดรัด (Micro Size)
local MainWidth = IsMobile and 290 or IsTablet and 380 or 460
local MainHeight = IsMobile and 200 or IsTablet and 250 or 300
local SideWidth = IsMobile and 85 or 125

local function Tween(obj, goal, t) 
    TS:Create(obj, TweenInfo.new(t or 0.4, Enum.EasingStyle.Quint), goal):Play()
end

local function MakeDraggable(obj, target)
    local dragging, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true; dragStart = input.Position; startPos = target.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input) dragging = false end)
end

function Library:CreateWindow(Config)
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_MICRO_SCALE"; Gui.IgnoreGuiInset = true
    
    local Main = Instance.new("Frame", Gui); Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 0, 0, 0); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Theme.Main; Main.BackgroundTransparency = 0.05; Main.ClipsDescendants = true; Main.Visible = false
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    local MStroke = Instance.new("UIStroke", Main); MStroke.Thickness = 2; MStroke.Color = Theme.Accent
    local UIGrad = Instance.new("UIGradient", MStroke)
    UIGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(0.5,0.8), NumberSequenceKeypoint.new(1,0)})
    task.spawn(function() while RS.RenderStepped:Wait() do UIGrad.Rotation = (UIGrad.Rotation + 3) % 360 end end)

    local TogF = Instance.new("Frame", Gui); TogF.Size = UDim2.new(0, 42, 0, 42); TogF.Position = UDim2.new(0.02, 0, 0.15, 0); TogF.BackgroundColor3 = Theme.Main; TogF.Visible = false; Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0)
    local TStroke = Instance.new("UIStroke", TogF); TStroke.Thickness = 2; TStroke.Color = Theme.Accent
    local TogBtn = Instance.new("TextButton", TogF); TogBtn.Size = UDim2.new(1, 0, 1, 0); TogBtn.BackgroundTransparency = 1; TogBtn.Text = "T"; TogBtn.TextColor3 = Theme.Accent; TogBtn.Font = "GothamBlack"; TogBtn.TextSize = 18; MakeDraggable(TogBtn, TogF)

    TogBtn.MouseButton1Click:Connect(function()
        if Main.Size.X.Offset > 0 then
            Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.4)
            task.wait(0.4) Main.Visible = false
        else
            Main.Visible = true; Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.5)
        end
    end)
    -- [ ⏳ COMPACT LOADING & GET KEY ]
    local function StartEngine()
        local LFrame = Instance.new("Frame", Gui); LFrame.Size = UDim2.new(0, 240, 0, 120); LFrame.Position = UDim2.new(0.5, 0, 0.5, 0); LFrame.AnchorPoint = Vector2.new(0.5, 0.5); LFrame.BackgroundColor3 = Theme.Main; Instance.new("UICorner", LFrame); local LS = Instance.new("UIStroke", LFrame); LS.Color = Theme.Accent; LS.Thickness = 2
        local LTit = Instance.new("TextLabel", LFrame); LTit.Size = UDim2.new(1, 0, 0, 40); LTit.Text = "LOADING SYSTEM"; LTit.TextColor3 = Theme.Accent; LTit.Font = "GothamBlack"; LTit.TextSize = 14; LTit.BackgroundTransparency = 1
        local LBarBG = Instance.new("Frame", LFrame); LBarBG.Size = UDim2.new(0.8, 0, 0, 3); LBarBG.Position = UDim2.new(0.1, 0, 0.65, 0); LBarBG.BackgroundColor3 = Theme.Secondary; Instance.new("UICorner", LBarBG)
        local LBar = Instance.new("Frame", LBarBG); LBar.Size = UDim2.new(0, 0, 1, 0); LBar.BackgroundColor3 = Theme.Accent; Instance.new("UICorner", LBar)
        for i = 1, 100 do LBar.Size = UDim2.new(i/100, 0, 1, 0) task.wait(0.008) end
        LFrame:Destroy()

        local KFrame = Instance.new("Frame", Gui); KFrame.Size = UDim2.new(0, 260, 0, 170); KFrame.Position = UDim2.new(0.5, 0, 0.5, 0); KFrame.AnchorPoint = Vector2.new(0.5, 0.5); KFrame.BackgroundColor3 = Theme.Main; Instance.new("UICorner", KFrame); local KS = Instance.new("UIStroke", KFrame); KS.Color = Theme.Accent; KS.Thickness = 2
        local KInp = Instance.new("TextBox", KFrame); KInp.Size = UDim2.new(0.85, 0, 0, 35); KInp.Position = UDim2.new(0.075, 0, 0.22, 0); KInp.PlaceholderText = "Key: 1"; KInp.Text = ""; KInp.BackgroundColor3 = Theme.Secondary; KInp.TextColor3 = Theme.Text; KInp.Font = "GothamBold"; KInp.TextSize = 12; Instance.new("UICorner", KInp)
        
        local KBtn = Instance.new("TextButton", KFrame); KBtn.Size = UDim2.new(0.85, 0, 0, 32); KBtn.Position = UDim2.new(0.075, 0, 0.5, 0); KBtn.Text = "SUBMIT"; KBtn.BackgroundColor3 = Theme.Accent; KBtn.TextColor3 = Theme.Main; KBtn.Font = "GothamBlack"; KBtn.TextSize = 12; Instance.new("UICorner", KBtn)
        local GBtn = Instance.new("TextButton", KFrame); GBtn.Size = UDim2.new(0.85, 0, 0, 25); GBtn.Position = UDim2.new(0.075, 0, 0.78, 0); GBtn.Text = "Get Key (Copy Link)"; GBtn.BackgroundTransparency = 1; GBtn.TextColor3 = Color3.fromRGB(150,150,150); GBtn.Font = "GothamBold"; GBtn.TextSize = 10

        GBtn.MouseButton1Click:Connect(function()
            setclipboard("https://getkey-link.com") -- ใส่ลิงก์ของคุณที่นี่
            GBtn.Text = "COPIED!"; task.wait(1.5); GBtn.Text = "Get Key (Copy Link)"
        end)

        KBtn.MouseButton1Click:Connect(function()
            if KInp.Text == "1" then 
                KFrame:Destroy(); Main.Visible = true; TogF.Visible = true; Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.5)
            else
                KS.Color = Color3.new(1,0,0); task.spawn(function() for i=1,10 do KFrame.Position = UDim2.new(0.5, math.random(-3,3), 0.5, math.random(-3,3)); task.wait(0.01) end KFrame.Position = UDim2.new(0.5,0,0.5,0) end)
                task.wait(1); KS.Color = Theme.Accent
            end
        end)
    end
    StartEngine()

    -- [ 🔳 MAIN INTERFACE ]
    local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 38); Top.BackgroundTransparency = 1; MakeDraggable(Top, Main)
    local Title = Instance.new("TextLabel", Top); Title.Size = UDim2.new(1, -20, 1, 0); Title.Position = UDim2.new(0, 15, 0, 0); Title.Text = Config.Name; Title.TextColor3 = Theme.Text; Title.Font = "GothamBlack"; Title.TextSize = 12; Title.TextXAlignment = "Left"; Title.BackgroundTransparency = 1
    
    local Side = Instance.new("ScrollingFrame", Main); Side.Size = UDim2.new(0, SideWidth, 1, -55); Side.Position = UDim2.new(0, 10, 0, 45); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0; Side.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 6)
    local Container = Instance.new("Frame", Main); Container.Size = UDim2.new(1, -(SideWidth + 25), 1, -55); Container.Position = UDim2.new(0, SideWidth + 15, 0, 45); Container.BackgroundTransparency = 1

    local Tabs = {First = true, Selected = nil}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Side); TabBtn.Size = UDim2.new(1, -5, 0, 30); TabBtn.BackgroundColor3 = Theme.Secondary; TabBtn.Text = name; TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150); TabBtn.Font = "GothamBold"; TabBtn.TextSize = 10; TabBtn.AutoButtonColor = false; Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8); local TS_B = Instance.new("UIStroke", TabBtn); TS_B.Color = Theme.Accent; TS_B.Enabled = false
        local Page = Instance.new("ScrollingFrame", Container); Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = "Y"; Instance.new("UIListLayout", Page).Padding = UDim.new(0, 6)

        TabBtn.MouseButton1Click:Connect(function()
            if Tabs.Selected == TabBtn then return end
            for _, v in pairs(Container:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then Tween(v, {BackgroundColor3 = Theme.Secondary, TextColor3 = Color3.fromRGB(150,150,150)}, 0.2); v.UIStroke.Enabled = false end end
            Page.Visible = true; Tabs.Selected = TabBtn; Tween(TabBtn, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Main}, 0.2); TS_B.Enabled = true
        end)

        if Tabs.First then Tabs.First = false; Tabs.Selected = TabBtn; Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent; TabBtn.TextColor3 = Theme.Main; TS_B.Enabled = true end

        local E = {}
        function E:CreateButton(D)
            local b = Instance.new("TextButton", Page); b.Size = UDim2.new(0.98, 0, 0, 32); b.BackgroundColor3 = Theme.Element; b.Text = D.Name; b.TextColor3 = Theme.Text; b.Font = "GothamBold"; b.TextSize = 10; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8); local BS = Instance.new("UIStroke", b); BS.Color = Theme.Stroke; BS.Thickness = 1
            b.MouseButton1Click:Connect(function() D.Callback() end)
        end
        function E:CreateToggle(D)
            local s = D.CurrentValue; local t = Instance.new("TextButton", Page); t.Size = UDim2.new(0.98, 0, 0, 34); t.BackgroundColor3 = Theme.Element; t.Text = "   "..D.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextSize = 10; t.TextXAlignment = "Left"; Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
            local bg = Instance.new("Frame", t); bg.Size = UDim2.new(0, 30, 0, 16); bg.Position = UDim2.new(1, -38, 0.5, -8); bg.BackgroundColor3 = s and Theme.Accent or Theme.Secondary; Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
            local dot = Instance.new("Frame", bg); dot.Size = UDim2.new(0, 12, 0, 12); dot.Position = s and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6); dot.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            t.MouseButton1Click:Connect(function() s = not s; Tween(bg, {BackgroundColor3 = s and Theme.Accent or Theme.Secondary}, 0.2); Tween(dot, {Position = s and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)}, 0.2); D.Callback(s) end)
        end
        return E
    end
    return Tabs
end

-- [ 🚀 START RUN ]
local Window = Library:CreateWindow({Name = "TURK HUB : MICRO"})
local T1 = Window:CreateTab("Main")
T1:CreateToggle({Name = "Auto Farming", CurrentValue = false, Callback = function(v) print(v) end})
T1:CreateButton({Name = "Instant Kill", Callback = function() print("Done") end})

return Library
