local Library = {Flags = {}, Theme = {}}
local TS, UIS, RS = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("RunService")

-- [ ⚡ CLEANUP ]
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "TURK_ULTRA_COMPACT" then v:Destroy() end 
end

local Theme = {
    Main = Color3.fromRGB(6, 7, 10),
    Accent = Color3.fromRGB(0, 255, 255),
    Secondary = Color3.fromRGB(12, 16, 22),
    Text = Color3.fromRGB(255, 255, 255),
    Element = Color3.fromRGB(20, 24, 32),
    Stroke = Color3.fromRGB(40, 50, 65)
}

local View = workspace.CurrentCamera.ViewportSize
local IsMobile = (View.X < 700)
local MainWidth = IsMobile and 280 or 440
local MainHeight = IsMobile and 190 or 280
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

-- [ 🔔 NOTIFICATION SYSTEM ]
function Library:Notify(text, duration)
    local n = Instance.new("Frame", game:GetService("CoreGui"):FindFirstChild("TURK_ULTRA_COMPACT"))
    n.Size = UDim2.new(0, 200, 0, 40); n.Position = UDim2.new(1, 20, 0.9, 0); n.BackgroundColor3 = Theme.Main; n.BorderSizePixel = 0
    Instance.new("UICorner", n); Instance.new("UIStroke", n).Color = Theme.Accent
    local nt = Instance.new("TextLabel", n); nt.Size = UDim2.new(1, 0, 1, 0); nt.BackgroundTransparency = 1; nt.Text = text; nt.TextColor3 = Theme.Text; nt.Font = "GothamBold"; nt.TextSize = 12
    Tween(n, {Position = UDim2.new(1, -220, 0.9, 0)}, 0.5)
    task.delay(duration or 3, function()
        Tween(n, {Position = UDim2.new(1, 20, 0.9, 0)}, 0.5)
        task.wait(0.5); n:Destroy()
    end)
end

function Library:CreateWindow(Config)
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_ULTRA_COMPACT"; Gui.IgnoreGuiInset = true
    
    local Main = Instance.new("Frame", Gui); Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 0, 0, 0); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Theme.Main; Main.BackgroundTransparency = 0.05; Main.ClipsDescendants = true; Main.Visible = false
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    local MStroke = Instance.new("UIStroke", Main); MStroke.Thickness = 2; MStroke.Color = Theme.Accent
    local UIGrad = Instance.new("UIGradient", MStroke)
    task.spawn(function() while RS.RenderStepped:Wait() do UIGrad.Rotation = (UIGrad.Rotation + 3) % 360 end end)

    local TogF = Instance.new("Frame", Gui); TogF.Size = UDim2.new(0, 40, 0, 40); TogF.Position = UDim2.new(0.02, 0, 0.1, 0); TogF.BackgroundColor3 = Theme.Main; TogF.Visible = false; Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0)
    local TStroke = Instance.new("UIStroke", TogF); TStroke.Thickness = 2; TStroke.Color = Theme.Accent
    local TogBtn = Instance.new("TextButton", TogF); TogBtn.Size = UDim2.new(1, 0, 1, 0); TogBtn.BackgroundTransparency = 1; TogBtn.Text = "T"; TogBtn.TextColor3 = Theme.Accent; TogBtn.Font = "GothamBlack"; TogBtn.TextSize = 18; MakeDraggable(TogBtn, TogF)

    TogBtn.MouseButton1Click:Connect(function()
        if Main.Size.X.Offset > 0 then
            Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.4); task.wait(0.4); Main.Visible = false
        else
            Main.Visible = true; Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.5)
        end
    end)

    local function OpenMain()
        Main.Visible = true; TogF.Visible = true; Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.5)
    end

    if Config.KeySystem and Config.KeySystem.EnableKeySystem then
        local LFrame = Instance.new("Frame", Gui); LFrame.Size = UDim2.new(0, 260, 0, 150); LFrame.Position = UDim2.new(0.5, 0, 0.5, 0); LFrame.AnchorPoint = Vector2.new(0.5, 0.5); LFrame.BackgroundColor3 = Theme.Main; Instance.new("UICorner", LFrame); local LS = Instance.new("UIStroke", LFrame); LS.Color = Theme.Accent; LS.Thickness = 2
        local LTit = Instance.new("TextLabel", LFrame); LTit.Size = UDim2.new(1, 0, 0, 45); LTit.Text = "AUTHENTICATION"; LTit.TextColor3 = Theme.Accent; LTit.Font = "GothamBlack"; LTit.TextSize = 16; LTit.BackgroundTransparency = 1
        local KInp = Instance.new("TextBox", LFrame); KInp.Size = UDim2.new(0.85, 0, 0, 32); KInp.Position = UDim2.new(0.075, 0, 0.4, 0); KInp.PlaceholderText = "Enter Key..."; KInp.Text = ""; KInp.BackgroundColor3 = Theme.Secondary; KInp.TextColor3 = Theme.Text; KInp.Font = "GothamBold"; KInp.TextSize = 11; Instance.new("UICorner", KInp)
        local KBtn = Instance.new("TextButton", LFrame); KBtn.Size = UDim2.new(0.85, 0, 0, 32); KBtn.Position = UDim2.new(0.075, 0, 0.68, 0); KBtn.Text = "LOGIN"; KBtn.BackgroundColor3 = Theme.Accent; KBtn.TextColor3 = Theme.Main; KBtn.Font = "GothamBlack"; KBtn.TextSize = 12; Instance.new("UICorner", KBtn)
        
        KBtn.MouseButton1Click:Connect(function()
            if KInp.Text == Config.KeySystem.Key then 
                Tween(LFrame, {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}, 0.5); task.wait(0.5); LFrame:Destroy(); OpenMain()
            else
                LS.Color = Color3.new(1,0,0); task.wait(1); LS.Color = Theme.Accent
            end
        end)
    else
        OpenMain()
    end

    local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 35); Top.BackgroundTransparency = 1; MakeDraggable(Top, Main)
    local Title = Instance.new("TextLabel", Top); Title.Size = UDim2.new(1, -20, 1, 0); Title.Position = UDim2.new(0, 15, 0, 0); Title.Text = Config.Name; Title.TextColor3 = Theme.Text; Title.Font = "GothamBlack"; Title.TextSize = 11; Title.TextXAlignment = "Left"; Title.BackgroundTransparency = 1
    
    local Side = Instance.new("ScrollingFrame", Main); Side.Size = UDim2.new(0, SideWidth, 1, -50); Side.Position = UDim2.new(0, 10, 0, 42); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0; Side.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 5)
    local Container = Instance.new("Frame", Main); Container.Size = UDim2.new(1, -(SideWidth + 25), 1, -50); Container.Position = UDim2.new(0, SideWidth + 15, 0, 42); Container.BackgroundTransparency = 1

    local Tabs = {First = true, Selected = nil}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Side); TabBtn.Size = UDim2.new(1, -5, 0, 28); TabBtn.BackgroundColor3 = Theme.Secondary; TabBtn.Text = name; TabBtn.TextColor3 = Color3.fromRGB(140,140,140); TabBtn.Font = "GothamBold"; TabBtn.TextSize = 9; TabBtn.AutoButtonColor = false; Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6); local TS_B = Instance.new("UIStroke", TabBtn); TS_B.Color = Theme.Accent; TS_B.Enabled = false
        local Page = Instance.new("ScrollingFrame", Container); Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = "Y"; Instance.new("UIListLayout", Page).Padding = UDim.new(0, 6)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then Tween(v, {BackgroundColor3 = Theme.Secondary, TextColor3 = Color3.fromRGB(140,140,140)}, 0.2); v.UIStroke.Enabled = false end end
            Page.Visible = true; Tween(TabBtn, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Main}, 0.2); TS_B.Enabled = true
        end)
        if Tabs.First then Tabs.First = false; Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent; TabBtn.TextColor3 = Theme.Main; TS_B.Enabled = true end

        local Elements = {}
        
        function Elements:CreateSection(Name)
            local s = Instance.new("TextLabel", Page); s.Size = UDim2.new(0.98, 0, 0, 20); s.BackgroundTransparency = 1; s.Text = "— "..Name; s.TextColor3 = Theme.Accent; s.Font = "GothamBlack"; s.TextSize = 10; s.TextXAlignment = "Left"
        end

        function Elements:CreateButton(Info)
            local b = Instance.new("TextButton", Page); b.Size = UDim2.new(0.98, 0, 0, 30); b.BackgroundColor3 = Theme.Element; b.Text = Info.Name; b.TextColor3 = Theme.Text; b.Font = "GothamBold"; b.TextSize = 10; Instance.new("UICorner", b); b.MouseButton1Click:Connect(function() Info.Callback() end)
        end

        function Elements:CreateToggle(Info)
            local s = Info.CurrentValue; local t = Instance.new("TextButton", Page); t.Size = UDim2.new(0.98, 0, 0, 32); t.BackgroundColor3 = Theme.Element; t.Text = "   "..Info.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextSize = 10; t.TextXAlignment = "Left"; Instance.new("UICorner", t)
            local bg = Instance.new("Frame", t); bg.Size = UDim2.new(0, 28, 0, 14); bg.Position = UDim2.new(1, -35, 0.5, -7); bg.BackgroundColor3 = s and Theme.Accent or Theme.Secondary; Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
            local dot = Instance.new("Frame", bg); dot.Size = UDim2.new(0, 10, 0, 10); dot.Position = s and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5); dot.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            t.MouseButton1Click:Connect(function() s = not s; Tween(bg, {BackgroundColor3 = s and Theme.Accent or Theme.Secondary}, 0.2); Tween(dot, {Position = s and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)}, 0.2); Info.Callback(s) end)
        end

        function Elements:CreateSlider(Info)
            local s = Instance.new("Frame", Page); s.Size = UDim2.new(0.98, 0, 0, 40); s.BackgroundColor3 = Theme.Element; Instance.new("UICorner", s)
            local t = Instance.new("TextLabel", s); t.Size = UDim2.new(1, 0, 0, 20); t.Position = UDim2.new(0, 10, 0, 5); t.Text = Info.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextSize = 10; t.TextXAlignment = "Left"; t.BackgroundTransparency = 1
            local v = Instance.new("TextLabel", s); v.Size = UDim2.new(0, 30, 0, 20); v.Position = UDim2.new(1, -40, 0, 5); v.Text = tostring(Info.CurrentValue); v.TextColor3 = Theme.Accent; v.Font = "GothamBold"; v.TextSize = 10; v.BackgroundTransparency = 1
            local bar = Instance.new("Frame", s); bar.Size = UDim2.new(0.9, 0, 0, 4); bar.Position = UDim2.new(0.05, 0, 0.75, 0); bar.BackgroundColor3 = Theme.Secondary; Instance.new("UICorner", bar)
            local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((Info.CurrentValue - Info.Min)/(Info.Max - Info.Min), 0, 1, 0); fill.BackgroundColor3 = Theme.Accent; Instance.new("UICorner", fill)
            
            local function Update(input)
                local per = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                local val = math.floor(per * (Info.Max - Info.Min) + Info.Min)
                v.Text = tostring(val); fill.Size = UDim2.new(per, 0, 1, 0); Info.Callback(val)
            end
            bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then move = true; Update(i) end end)
            UIS.InputChanged:Connect(function(i) if move and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i) end end)
            UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then move = false end end)
        end

        function Elements:CreateDropdown(Info)
            local d = Instance.new("Frame", Page); d.Size = UDim2.new(0.98, 0, 0, 32); d.BackgroundColor3 = Theme.Element; d.ClipsDescendants = true; Instance.new("UICorner", d)
            local t = Instance.new("TextButton", d); t.Size = UDim2.new(1, 0, 0, 32); t.BackgroundTransparency = 1; t.Text = "   "..Info.Name..": "..Info.CurrentValue; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextSize = 10; t.TextXAlignment = "Left"
            local open = false
            t.MouseButton1Click:Connect(function()
                open = not open; Tween(d, {Size = open and UDim2.new(0.98, 0, 0, 32 + (#Info.Options * 25)) or UDim2.new(0.98, 0, 0, 32)}, 0.3)
            end)
            for _, opt in pairs(Info.Options) do
                local o = Instance.new("TextButton", d); o.Size = UDim2.new(1, 0, 0, 25); o.Position = UDim2.new(0, 0, 0, 32 + ((_ - 1) * 25)); o.BackgroundTransparency = 1; o.Text = opt; o.TextColor3 = Color3.fromRGB(150, 150, 150); o.Font = "GothamBold"; o.TextSize = 9
                o.MouseButton1Click:Connect(function()
                    t.Text = "   "..Info.Name..": "..opt; open = false; Tween(d, {Size = UDim2.new(0.98, 0, 0, 32)}, 0.3); Info.Callback(opt)
                end)
            end
        end

        function Elements:CreateKeybind(Info)
            local k = Instance.new("TextButton", Page); k.Size = UDim2.new(0.98, 0, 0, 32); k.BackgroundColor3 = Theme.Element; k.Text = "   "..Info.Name; k.TextColor3 = Theme.Text; k.Font = "GothamBold"; k.TextSize = 10; k.TextXAlignment = "Left"; Instance.new("UICorner", k)
            local v = Instance.new("TextLabel", k); v.Size = UDim2.new(0, 60, 0, 20); v.Position = UDim2.new(1, -70, 0.5, -10); v.BackgroundColor3 = Theme.Secondary; v.Text = Info.CurrentKeybind; v.TextColor3 = Theme.Accent; v.Font = "GothamBold"; v.TextSize = 9; Instance.new("UICorner", v)
            local waiting = false
            k.MouseButton1Click:Connect(function() v.Text = "..."; waiting = true end)
            UIS.InputBegan:Connect(function(input)
                if waiting and input.UserInputType == Enum.UserInputType.Keyboard then
                    v.Text = input.KeyCode.Name; waiting = false; Info.Callback(input.KeyCode)
                end
            end)
        end

        return Elements
    end
    return Tabs
end

-- [ ตัวอย่างการใช้งาน ]
-- local Win = Library:CreateWindow({
--     Name = "TURK HUB V11",
--     KeySystem = {EnableKeySystem = true, Key = "TURK", Link = "discord.gg/xxx"}
-- })
-- local Tab = Win:CreateTab("Main")
-- Tab:CreateSection("Farming")
-- Tab:CreateToggle({Name = "Auto Farm", CurrentValue = false, Callback = function(v) print(v) end})
-- Tab:CreateSlider({Name = "Speed", Min = 16, Max = 200, CurrentValue = 16, Callback = function(v) print(v) end})
-- Tab:CreateDropdown({Name = "Select Mode", Options = {"Mode A", "Mode B"}, CurrentValue = "None", Callback = function(v) print(v) end})
-- Tab:CreateKeybind({Name = "Toggle Menu", CurrentKeybind = "F", Callback = function(v) print(v) end})
-- Library:Notify("Welcome to Turk Hub!", 5)

return Library
