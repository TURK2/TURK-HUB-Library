local Library = {Flags = {}, Theme = {}}
local TS, UIS, RS = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("RunService")

for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "TURK_ULTRA" then v:Destroy() end end

local T = {
    Main = Color3.fromRGB(6, 7, 10), Accent = Color3.fromRGB(0, 255, 255),
    Sec = Color3.fromRGB(12, 16, 22), Text = Color3.fromRGB(255, 255, 255),
    Elm = Color3.fromRGB(20, 24, 32), Str = Color3.fromRGB(40, 50, 65)
}

local View = workspace.CurrentCamera.ViewportSize
local IsMob = (View.X < 700)
local MW, MH, SW = IsMob and 280 or 440, IsMob and 190 or 280, IsMob and 85 or 125

local function Tw(o, g, t) TS:Create(o, TweenInfo.new(t or 0.4, Enum.EasingStyle.Quint), g):Play() end

local function Draggable(o, t)
    local drag, start, pos
    o.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag, start, pos = true, i.Position, t.Position end end)
    UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - start t.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y) end end)
    UIS.InputEnded:Connect(function(i) drag = false end)
end

function Library:CreateWindow(cfg)
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_ULTRA"; Gui.IgnoreGuiInset = true
    local Main = Instance.new("Frame", Gui); Main.Size = UDim2.new(0, 0, 0, 0); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5); Main.BackgroundColor3 = T.Main; Main.ClipsDescendants = true; Main.Visible = false
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10); Instance.new("UIStroke", Main).Color = T.Accent

    local TogF = Instance.new("Frame", Gui); TogF.Size = UDim2.new(0, 40, 0, 40); TogF.Position = UDim2.new(0.02, 0, 0.1, 0); TogF.BackgroundColor3 = T.Main; TogF.Visible = false; Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0); Instance.new("UIStroke", TogF).Color = T.Accent
    local TogB = Instance.new("TextButton", TogF); TogB.Size = UDim2.new(1, 0, 1, 0); TogB.BackgroundTransparency = 1; TogB.Text = "T"; TogB.TextColor3 = T.Accent; TogB.Font = "GothamBlack"; TogB.TextSize = 18; Draggable(TogB, TogF)

    TogB.MouseButton1Click:Connect(function()
        if Main.Size.X.Offset > 0 then Tw(Main, {Size = UDim2.new(0, 0, 0, 0)}) task.wait(0.4) Main.Visible = false
        else Main.Visible = true Tw(Main, {Size = UDim2.new(0, MW, 0, MH)}) end
    end)

    local function Start()
        local L = Instance.new("Frame", Gui); L.Size = UDim2.new(0, 260, 0, 150); L.Position = UDim2.new(0.5, 0, 0.5, 0); L.AnchorPoint = Vector2.new(0.5, 0.5); L.BackgroundColor3 = T.Main; Instance.new("UICorner", L); local LS = Instance.new("UIStroke", L); LS.Color = T.Accent
        local LT = Instance.new("TextLabel", L); LT.Size = UDim2.new(1, 0, 0, 45); LT.Text = cfg.Name; LT.TextColor3 = T.Accent; LT.Font = "GothamBlack"; LT.TextSize = 16; LT.BackgroundTransparency = 1
        local BarBG = Instance.new("Frame", L); BarBG.Size = UDim2.new(0.8, 0, 0, 3); BarBG.Position = UDim2.new(0.1, 0, 0.6, 0); BarBG.BackgroundColor3 = T.Sec; Instance.new("UICorner", BarBG)
        local Bar = Instance.new("Frame", BarBG); Bar.Size = UDim2.new(0, 0, 1, 0); Bar.BackgroundColor3 = T.Accent; Instance.new("UICorner", Bar)

        for i = 1, 100 do Bar.Size = UDim2.new(i/100, 0, 1, 0) task.wait(0.005) end
        
        local function OpenMain()
            Tw(L, {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}, 0.4)
            task.wait(0.4) L:Destroy() Main.Visible, TogF.Visible = true, true
            Tw(Main, {Size = UDim2.new(0, MW, 0, MH)}, 0.5)
        end

        if cfg.KeySystem then
            BarBG.Visible, LT.Text = false, "AUTHENTICATION"
            local KInp = Instance.new("TextBox", L); KInp.Size = UDim2.new(0.85, 0, 0, 32); KInp.Position = UDim2.new(0.075, 0, 0.35, 0); KInp.PlaceholderText = "Enter Key..."; KInp.BackgroundColor3 = T.Sec; KInp.TextColor3 = T.Text; KInp.Font = "GothamBold"; KInp.TextSize = 11; Instance.new("UICorner", KInp)
            local KBtn = Instance.new("TextButton", L); KBtn.Size = UDim2.new(0.85, 0, 0, 32); KBtn.Position = UDim2.new(0.075, 0, 0.62, 0); KBtn.Text = "LOGIN"; KBtn.BackgroundColor3 = T.Accent; KBtn.TextColor3 = T.Main; KBtn.Font = "GothamBlack"; Instance.new("UICorner", KBtn)
            local GBtn = Instance.new("TextButton", L); GBtn.Size = UDim2.new(1, 0, 0, 20); GBtn.Position = UDim2.new(0, 0, 0.85, 0); GBtn.Text = "Get Key Link"; GBtn.BackgroundTransparency = 1; GBtn.TextColor3 = Color3.fromRGB(130, 130, 130); GBtn.Font = "GothamBold"; GBtn.TextSize = 10
            
            GBtn.MouseButton1Click:Connect(function() setclipboard(cfg.KeyLink or "") GBtn.Text = "COPIED!" task.wait(1) GBtn.Text = "Get Key Link" end)
            KBtn.MouseButton1Click:Connect(function()
                if KInp.Text == cfg.Key then OpenMain() else LS.Color = Color3.new(1,0,0) task.wait(1) LS.Color = T.Accent end
            end)
        else OpenMain() end
    end
    task.spawn(Start)

    local Side = Instance.new("ScrollingFrame", Main); Side.Size = UDim2.new(0, SW, 1, -50); Side.Position = UDim2.new(0, 10, 0, 42); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0; Side.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 5)
    local Cont = Instance.new("Frame", Main); Cont.Size = UDim2.new(1, -(SW + 25), 1, -50); Cont.Position = UDim2.new(0, SW + 15, 0, 42); Cont.BackgroundTransparency = 1

    local Tabs = {First = true, Sel = nil}
    function Tabs:CreateTab(n)
        local btn = Instance.new("TextButton", Side); btn.Size = UDim2.new(1, -5, 0, 28); btn.BackgroundColor3 = T.Sec; btn.Text = n; btn.TextColor3 = Color3.fromRGB(140,140,140); btn.Font = "GothamBold"; btn.TextSize = 9; Instance.new("UICorner", btn)
        local pg = Instance.new("ScrollingFrame", Cont); pg.Size = UDim2.new(1, 0, 1, 0); pg.Visible = false; pg.BackgroundTransparency = 1; pg.ScrollBarThickness = 0; pg.AutomaticCanvasSize = "Y"; Instance.new("UIListLayout", pg).Padding = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(Cont:GetChildren()) do v.Visible = false end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then v.BackgroundColor3, v.TextColor3 = T.Sec, Color3.fromRGB(140,140,140) end end
            pg.Visible, btn.BackgroundColor3, btn.TextColor3 = true, T.Accent, T.Main
        end)
        if Tabs.First then Tabs.First = false pg.Visible, btn.BackgroundColor3, btn.TextColor3 = true, T.Accent, T.Main end

        local Elm = {}
        function Elm:CreateButton(i)
            local b = Instance.new("TextButton", pg); b.Size = UDim2.new(0.98, 0, 0, 30); b.BackgroundColor3 = T.Elm; b.Text = i.Name; b.TextColor3 = T.Text; b.Font = "GothamBold"; b.TextSize = 10; Instance.new("UICorner", b); b.MouseButton1Click:Connect(i.Callback)
        end
        function Elm:CreateSection(n)
            local s = Instance.new("TextLabel", pg); s.Size = UDim2.new(0.98, 0, 0, 20); s.Text = n; s.TextColor3 = T.Accent; s.Font = "GothamBlack"; s.TextSize = 10; s.BackgroundTransparency = 1
        end
        return Elm
    end
    return Tabs
end
return Library
