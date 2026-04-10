local Library = {Flags = {}, Keybinds = {}}
local TS, UIS, plr = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("Players").LocalPlayer

-- [ Cleanup ]
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "TURK_PREMIUM_UI" then v:Destroy() end 
end

local Theme = {
    Main = Color3.fromRGB(15, 15, 20), 
    Top = Color3.fromRGB(22, 22, 30), 
    Accent = Color3.fromRGB(0, 230, 255),
    Secondary = Color3.fromRGB(25, 25, 35), 
    Text = Color3.fromRGB(255, 255, 255), 
    TextSemi = Color3.fromRGB(180, 180, 190),
    Element = Color3.fromRGB(30, 30, 42), 
    Stroke = Color3.fromRGB(55, 55, 70),
}

local function Tween(obj, goal, t) 
    TS:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), goal):Play() 
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
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_PREMIUM_UI"; Gui.IgnoreGuiInset = true
    
    -- [ 📱 Auto-Scale Calculation ]
    local View = workspace.CurrentCamera.ViewportSize
    local isMobile = UIS.TouchEnabled
    local MainWidth = math.clamp(View.X * 0.7, 340, 520)
    local MainHeight = math.clamp(View.Y * 0.6, 250, 330)
    local UI_Size = UDim2.new(0, MainWidth, 0, MainHeight)

    local Main = Instance.new("Frame", Gui); Main.Size = UDim2.new(0, 0, 0, 0); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5); Main.BackgroundColor3 = Theme.Main; Main.ClipsDescendants = true; Main.ZIndex = 2
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    local MS = Instance.new("UIStroke", Main); MS.Color = Theme.Stroke; MS.Thickness = 1.2

    -- [ 🔘 Toggle Button (Fixed ZIndex) ]
    local TogF = Instance.new("Frame", Gui); TogF.Size = UDim2.new(0, 45, 0, 45); TogF.Position = UDim2.new(0.05, 0, 0.1, 0); TogF.BackgroundColor3 = Theme.Main; TogF.ZIndex = 100
    Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0)
    local TS_Tog = Instance.new("UIStroke", TogF); TS_Tog.Color = Theme.Accent; TS_Tog.Thickness = 1.5
    local TBtn = Instance.new("TextButton", TogF); TBtn.Size = UDim2.new(1,0,1,0); TBtn.BackgroundTransparency = 1; TBtn.Text = "T"; TBtn.TextColor3 = Theme.Accent; TBtn.Font = "GothamBlack"; TBtn.TextSize = 20; MakeDraggable(TBtn, TogF)

    local function ToggleUI()
        local isOpen = Main.Size ~= UDim2.new(0,0,0,0)
        if isOpen then
            Tween(Main, {Size = UDim2.new(0,0,0,0)}); task.wait(0.2); Main.Visible = false
            Tween(TBtn, {TextColor3 = Theme.Accent}); Tween(TS_Tog, {Transparency = 0, Color = Theme.Accent})
        else
            Main.Visible = true; Tween(Main, {Size = UI_Size})
            Tween(TBtn, {TextColor3 = Theme.TextSemi}); Tween(TS_Tog, {Transparency = 0.5, Color = Theme.TextSemi})
        end
    end
    TBtn.MouseButton1Click:Connect(ToggleUI)
    Main.Visible = true; Tween(Main, {Size = UI_Size}); TBtn.TextColor3 = Theme.TextSemi; TS_Tog.Transparency = 0.5

    -- [ 📋 Header ]
    local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 40); Top.BackgroundColor3 = Theme.Top; MakeDraggable(Top, Main)
    local TTitle = Instance.new("TextLabel", Top); TTitle.Size = UDim2.new(1,-40,1,0); TTitle.Position = UDim2.new(0,15,0,0); TTitle.Text = Config.Name; TTitle.TextColor3 = Theme.Accent; TTitle.Font = "GothamBlack"; TTitle.TextSize = 14; TTitle.TextXAlignment = "Left"; TTitle.BackgroundTransparency = 1

    -- [ 📂 Sidebar ]
    local SideWidth = isMobile and 110 or 130
    local Side = Instance.new("ScrollingFrame", Main); Side.Size = UDim2.new(0, SideWidth, 1, -55); Side.Position = UDim2.new(0, 10, 0, 45); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0; Side.CanvasSize = UDim2.new(0,0,0,0); Side.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 5)
    
    -- [ 📦 Container (Fixed Right Positioning) ]
    local Container = Instance.new("Frame", Main); Container.Name = "Container"
    Container.Position = UDim2.new(0, SideWidth + 20, 0, 45) 
    Container.Size = UDim2.new(1, -(SideWidth + 30), 1, -55) 
    Container.BackgroundTransparency = 1; Container.ClipsDescendants = true 

    local Tabs = {First = true}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Side); TabBtn.Size = UDim2.new(1, -5, 0, 34); TabBtn.BackgroundColor3 = Theme.Secondary; TabBtn.Text = "  "..name; TabBtn.TextColor3 = Theme.TextSemi; TabBtn.Font = "GothamBold"; TabBtn.TextSize = 11; TabBtn.TextXAlignment = "Left"; Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        local Page = Instance.new("ScrollingFrame", Container); Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Page.CanvasSize = UDim2.new(0,0,0,0); Page.AutomaticCanvasSize = "Y"
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 7)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then Tween(v, {BackgroundColor3 = Theme.Secondary, TextColor3 = Theme.TextSemi}) end end
            Page.Visible = true; Tween(TabBtn, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Main})
        end)

        if Tabs.First then Tabs.First = false; Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent; TabBtn.TextColor3 = Theme.Main end

        local E = {}
        function E:CreateButton(D) 
            local b = Instance.new("TextButton", Page); b.Size = UDim2.new(1,-6,0,36); b.BackgroundColor3 = Theme.Element; b.Text = D.Name; b.TextColor3 = Theme.Text; b.Font = "GothamBold"; b.TextSize = 12; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            local s = Instance.new("UIStroke", b); s.Color = Theme.Stroke; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Transparency = 0.4
            b.MouseButton1Click:Connect(D.Callback) 
        end

        function E:CreateToggle(D) 
            local s = D.CurrentValue or false
            local t = Instance.new("TextButton", Page); t.Size = UDim2.new(1,-6,0,36); t.BackgroundColor3 = Theme.Element; t.Text = "   "..D.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextSize = 12; t.TextXAlignment = "Left"; Instance.new("UICorner", t).CornerRadius = UDim.new(0, 6)
            local bg = Instance.new("Frame", t); bg.Size = UDim2.new(0,30,0,14); bg.Position = UDim2.new(1,-36,0.5,-7); bg.BackgroundColor3 = s and Theme.Accent or Theme.Secondary; Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
            local dot = Instance.new("Frame", bg); dot.Size = UDim2.new(0,10,0,10); dot.Position = s and UDim2.new(1,-12,0.5,-5) or UDim2.new(0,2,0.5,-5); dot.BackgroundColor3 = s and Theme.Main or Theme.TextSemi; Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
            t.MouseButton1Click:Connect(function() 
                s = not s; Tween(bg, {BackgroundColor3 = s and Theme.Accent or Theme.Secondary}); 
                Tween(dot, {Position = s and UDim2.new(1,-12,0.5,-5) or UDim2.new(0,2,0.5,-5)}); D.Callback(s) 
            end)
        end
        return E
    end
    return Tabs
end

return Library
