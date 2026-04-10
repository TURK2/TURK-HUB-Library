local Library = {Flags = {}, Theme = {}}
local TS, UIS, RS = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("RunService")

-- [ ⚡ CLEANUP ]
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "TURK_ULTRA_COMPACT" then v:Destroy() end 
end

local Theme = {
    Main = Color3.fromRGB(6, 7, 10), Accent = Color3.fromRGB(0, 255, 255),
    Secondary = Color3.fromRGB(12, 16, 22), Text = Color3.fromRGB(255, 255, 255),
    Element = Color3.fromRGB(20, 24, 32), Stroke = Color3.fromRGB(40, 50, 65)
}

local View = workspace.CurrentCamera.ViewportSize
local IsMobile = (View.X < 700)
local MW, MH, SW = IsMobile and 280 or 440, IsMobile and 190 or 280, IsMobile and 85 or 125

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
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_ULTRA_COMPACT"; Gui.IgnoreGuiInset = true

    local Main = Instance.new("Frame", Gui); Main.AnchorPoint = Vector2.new(0.5, 0.5); Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.BackgroundColor3 = Theme.Main; Main.ClipsDescendants = true; Main.Visible = false; Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    local MStroke = Instance.new("UIStroke", Main); MStroke.Thickness = 2; MStroke.Color = Theme.Accent

    local TogF = Instance.new("Frame", Gui); TogF.Size = UDim2.new(0, 40, 0, 40); TogF.Position = UDim2.new(0.02, 0, 0.1, 0); TogF.BackgroundColor3 = Theme.Main; TogF.Visible = false; Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0); Instance.new("UIStroke", TogF).Color = Theme.Accent
    local TogBtn = Instance.new("TextButton", TogF); TogBtn.Size = UDim2.new(1, 0, 1, 0); TogBtn.BackgroundTransparency = 1; TogBtn.Text = "T"; TogBtn.TextColor3 = Theme.Accent; TogBtn.Font = "GothamBlack"; TogBtn.TextSize = 18; MakeDraggable(TogBtn, TogF)

    TogBtn.MouseButton1Click:Connect(function()
        if Main.Size.X.Offset > 0 then Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}) task.wait(0.4) Main.Visible = false
        else Main.Visible = true; Tween(Main, {Size = UDim2.new(0, MW, 0, MH)}) end
    end)

    local function StartEngine()
        if not Config.KeySystem then 
            Main.Visible, TogF.Visible = true, true; Main.Size = UDim2.new(0, MW, 0, MH); return 
        end
        
        local L = Instance.new("Frame", Gui); L.Size = UDim2.new(0, 260, 0, 150); L.Position = UDim2.new(0.5, 0, 0.5, 0); L.AnchorPoint = Vector2.new(0.5, 0.5); L.BackgroundColor3 = Theme.Main; Instance.new("UICorner", L); local LS = Instance.new("UIStroke", L); LS.Color = Theme.Accent
        local LT = Instance.new("TextLabel", L); LT.Size = UDim2.new(1, 0, 0, 45); LT.Text = "AUTHENTICATION"; LT.TextColor3 = Theme.Accent; LT.Font = "GothamBlack"; LT.BackgroundTransparency = 1
        
        local KInp = Instance.new("TextBox", L); KInp.Size = UDim2.new(0.85, 0, 0, 32); KInp.Position = UDim2.new(0.075, 0, 0.35, 0); KInp.PlaceholderText = "Enter Key..."; KInp.BackgroundColor3 = Theme.Secondary; KInp.TextColor3 = Theme.Text; KInp.Font = "GothamBold"; Instance.new("UICorner", KInp)
        local KBtn = Instance.new("TextButton", L); KBtn.Size = UDim2.new(0.85, 0, 0, 32); KBtn.Position = UDim2.new(0.075, 0, 0.65, 0); KBtn.Text = "LOGIN"; KBtn.BackgroundColor3 = Theme.Accent; KBtn.Font = "GothamBlack"; Instance.new("UICorner", KBtn)

        KBtn.MouseButton1Click:Connect(function()
            if KInp.Text == Config.Key then 
                Tween(L, {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}) task.wait(0.4) L:Destroy()
                Main.Visible, TogF.Visible = true, true; Tween(Main, {Size = UDim2.new(0, MW, 0, MH)})
            else 
                LS.Color = Color3.new(1,0,0) task.wait(1) LS.Color = Theme.Accent
            end
        end)
    end
    task.spawn(StartEngine)

    local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 35); Top.BackgroundTransparency = 1; MakeDraggable(Top, Main)
    local Side = Instance.new("ScrollingFrame", Main); Side.Size = UDim2.new(0, SW, 1, -50); Side.Position = UDim2.new(0, 10, 0, 42); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0; Side.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 5)
    local Container = Instance.new("Frame", Main); Container.Size = UDim2.new(1, -(SW + 25), 1, -50); Container.Position = UDim2.new(0, SW + 15, 0, 42); Container.BackgroundTransparency = 1

    local Tabs = {First = true, Selected = nil}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Side); TabBtn.Size = UDim2.new(1, -5, 0, 28); TabBtn.BackgroundColor3 = Theme.Secondary; TabBtn.Text = name; TabBtn.TextColor3 = Color3.fromRGB(140,140,140); TabBtn.Font = "GothamBold"; TabBtn.TextSize = 9; Instance.new("UICorner", TabBtn)
        local Page = Instance.new("ScrollingFrame", Container); Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = "Y"; Instance.new("UIListLayout", Page).Padding = UDim.new(0, 6)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then v.BackgroundColor3 = Theme.Secondary end end
            Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent
        end)
        if Tabs.First then Tabs.First = false; Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent end

        local Elements = {}
        
        -- [ Rayfield: Section ]
        function Elements:CreateSection(name)
            local s = Instance.new("TextLabel", Page); s.Size = UDim2.new(0.98, 0, 0, 20); s.Text = "— "..name.." —"; s.TextColor3 = Theme.Accent; s.Font = "GothamBlack"; s.TextSize = 10; s.BackgroundTransparency = 1
        end

        -- [ Rayfield: Button ]
        function Elements:CreateButton(Info)
            local b = Instance.new("TextButton", Page); b.Size = UDim2.new(0.98, 0, 0, 30); b.BackgroundColor3 = Theme.Element; b.Text = Info.Name; b.TextColor3 = Theme.Text; b.Font = "GothamBold"; b.TextSize = 10; Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(Info.Callback)
            return {Set = function(t) b.Text = t end}
        end

        -- [ Rayfield: Toggle ]
        function Elements:CreateToggle(Info)
            local state = Info.CurrentValue or false
            if Info.Flag then Library.Flags[Info.Flag] = state end
            
            local t = Instance.new("TextButton", Page); t.Size = UDim2.new(0.98, 0, 0, 32); t.BackgroundColor3 = Theme.Element; t.Text = "   "..Info.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextSize = 10; t.TextXAlignment = "Left"; Instance.new("UICorner", t)
            local bg = Instance.new("Frame", t); bg.Size = UDim2.new(0, 28, 0, 14); bg.Position = UDim2.new(1, -35, 0.5, -7); bg.BackgroundColor3 = state and Theme.Accent or Theme.Secondary; Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
            local dot = Instance.new("Frame", bg); dot.Size = UDim2.new(0, 10, 0, 10); dot.Position = state and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5); dot.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            
            local function Update()
                Tween(bg, {BackgroundColor3 = state and Theme.Accent or Theme.Secondary}, 0.2)
                Tween(dot, {Position = state and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)}, 0.2)
                if Info.Flag then Library.Flags[Info.Flag] = state end
                Info.Callback(state)
            end

            t.MouseButton1Click:Connect(function() state = not state; Update() end)
            return {Set = function(v) state = v; Update() end}
        end

        return Elements
    end
    return Tabs
end
return Library
