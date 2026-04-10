local Library = {Flags = {}, Keybinds = {}}
local TS, UIS, plr = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("Players").LocalPlayer

-- [ Cleanup ]
for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do 
    if v.Name == "TURK_PREMIUM_UI" then v:Destroy() end 
end

local Theme = {
    Main = Color3.fromRGB(15, 15, 20), 
    Top = Color3.fromRGB(20, 20, 28), 
    Accent = Color3.fromRGB(0, 230, 255),
    Secondary = Color3.fromRGB(25, 25, 35), 
    Text = Color3.fromRGB(255, 255, 255), 
    TextSemi = Color3.fromRGB(180, 180, 190),
    Element = Color3.fromRGB(30, 30, 40), 
    Stroke = Color3.fromRGB(50, 50, 65),
    Success = Color3.fromRGB(0, 255, 150)
}

local function Tween(obj, goal, t) 
    TS:Create(obj, TweenInfo.new(t or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), goal):Play() 
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
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_PREMIUM_UI"; Gui.IgnoreGuiInset = true
    local View = workspace.CurrentCamera.ViewportSize
    local isMobile = UIS.TouchEnabled
    local MainWidth = isMobile and math.min(View.X * 0.9, 450) or 600
    local MainHeight = isMobile and math.min(View.Y * 0.85, 340) or 400
    local UI_Size = UDim2.new(0, MainWidth, 0, MainHeight)

    -- [ 🛡️ Main UI ]
    local Main = Instance.new("Frame", Gui); Main.Size = UDim2.new(0, 0, 0, 0); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5); Main.BackgroundColor3 = Theme.Main; Main.Visible = false; Main.ClipsDescendants = true; Main.ZIndex = 2
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
    local MS = Instance.new("UIStroke", Main); MS.Color = Theme.Stroke; MS.Thickness = 1.2

    -- [ 🔘 Toggle Button (ตัว T) ]
    local TogF = Instance.new("Frame", Gui); TogF.Size = UDim2.new(0, 50, 0, 50); TogF.Position = UDim2.new(0.05, 0, 0.15, 0); TogF.BackgroundColor3 = Theme.Main; TogF.ZIndex = 10; TogF.Active = true
    Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0)
    local TS_Tog = Instance.new("UIStroke", TogF); TS_Tog.Color = Theme.Accent; TS_Tog.Thickness = 1.5
    
    local TBtn = Instance.new("TextButton", TogF); TBtn.Size = UDim2.new(1,0,1,0); TBtn.BackgroundTransparency = 1; TBtn.Text = "T"; TBtn.TextColor3 = Theme.Accent; TBtn.Font = "GothamBlack"; TBtn.TextSize = 22; MakeDraggable(TBtn, TogF)

    -- [ ✨ Logic: Toggle UI & Button Color ]
    local function ToggleUI()
        local isOpen = Main.Size ~= UDim2.new(0,0,0,0)
        if isOpen then
            -- ปิด UI: ปุ่ม T จะมีสี
            Tween(Main, {Size = UDim2.new(0,0,0,0)})
            task.wait(0.2) Main.Visible = false
            Tween(TBtn, {TextColor3 = Theme.Accent})
            Tween(TS_Tog, {Transparency = 0, Color = Theme.Accent})
        else
            -- เปิด UI: ปุ่ม T จะจางลง
            Main.Visible = true
            Tween(Main, {Size = UI_Size})
            Tween(TBtn, {TextColor3 = Theme.TextSemi})
            Tween(TS_Tog, {Transparency = 0.6, Color = Theme.TextSemi})
        end
    end
    TBtn.MouseButton1Click:Connect(ToggleUI)

    -- เริ่มต้น (ถ้าไม่ได้ใช้ Key System ให้เปิดเลย)
    if not Config.KeySystem then 
        Main.Visible = true; Tween(Main, {Size = UI_Size}) 
        TBtn.TextColor3 = Theme.TextSemi; TS_Tog.Transparency = 0.6
    end

    local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 50); Top.BackgroundColor3 = Theme.Top; MakeDraggable(Top, Main)
    Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 15)
    local TTitle = Instance.new("TextLabel", Top); TTitle.Size = UDim2.new(1,-40,1,0); TTitle.Position = UDim2.new(0,25,0,0); TTitle.Text = Config.Name; TTitle.TextColor3 = Theme.Accent; TTitle.Font = "GothamBlack"; TTitle.TextSize = 18; TTitle.TextXAlignment = "Left"; TTitle.BackgroundTransparency = 1

    local Side = Instance.new("ScrollingFrame", Main); Side.Name = "SideBar"; Side.Size = UDim2.new(0, isMobile and 120 or 145, 1, -70); Side.Position = UDim2.new(0, 15, 0, 60); Side.BackgroundTransparency = 1; Side.ScrollBarThickness = 0; Side.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", Side).Padding = UDim.new(0, 8)
    
    -- [[ แก้ไขส่วน Container ไม่ให้ล้ำเส้น ]]
    local Container = Instance.new("Frame", Main); Container.Name = "Container"
    Container.Position = UDim2.new(0, isMobile and 145 or 170, 0, 60) 
    Container.Size = UDim2.new(1, isMobile and -160 or -185, 1, -75) 
    Container.BackgroundTransparency = 1; Container.ClipsDescendants = true 

    local Tabs = {First = true}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Side); TabBtn.Size = UDim2.new(1, -5, 0, 38); TabBtn.BackgroundColor3 = Theme.Secondary; TabBtn.Text = "   "..name; TabBtn.TextColor3 = Theme.TextSemi; TabBtn.Font = "GothamBold"; TabBtn.TextSize = 13; TabBtn.TextXAlignment = "Left"; Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
        local Page = Instance.new("ScrollingFrame", Container); Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.ScrollBarThickness = 0; Page.AutomaticCanvasSize = "Y"
        local PL = Instance.new("UIListLayout", Page); PL.Padding = UDim.new(0, 8); PL.SortOrder = Enum.SortOrder.LayoutOrder

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            for _, v in pairs(Side:GetChildren()) do if v:IsA("TextButton") then Tween(v, {BackgroundColor3 = Theme.Secondary, TextColor3 = Theme.TextSemi}) end end
            Page.Visible = true; Tween(TabBtn, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Main})
        end)

        if Tabs.First then Tabs.First = false; Page.Visible = true; TabBtn.BackgroundColor3 = Theme.Accent; TabBtn.TextColor3 = Theme.Main end

        local ElementCount = 0
        local E = {}
        
        function E:CreateSection(n) 
            ElementCount = ElementCount + 1
            local SFrame = Instance.new("Frame", Page); SFrame.Size = UDim2.new(1, -5, 0, 25); SFrame.BackgroundTransparency = 1; SFrame.LayoutOrder = ElementCount
            local l = Instance.new("TextLabel", SFrame); l.Size = UDim2.new(1, 0, 1, 0); l.Text = "⚡ " .. n:upper(); l.TextColor3 = Theme.Accent; l.Font = "GothamBlack"; l.TextSize = 11; l.BackgroundTransparency = 1; l.TextXAlignment = "Left"
        end

        function E:CreateButton(D) 
            ElementCount = ElementCount + 1
            local b = Instance.new("TextButton", Page); b.Size = UDim2.new(1,-5,0,40); b.BackgroundColor3 = Theme.Element; b.Text = D.Name; b.TextColor3 = Theme.Text; b.Font = "GothamBold"; b.TextSize = 13; b.LayoutOrder = ElementCount; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
            local s = Instance.new("UIStroke", b); s.Color = Theme.Stroke; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            b.MouseButton1Click:Connect(D.Callback) 
        end

        function E:CreateToggle(D) 
            ElementCount = ElementCount + 1
            local s = D.CurrentValue; local t = Instance.new("TextButton", Page); t.Size = UDim2.new(1,-5,0,40); t.BackgroundColor3 = Theme.Element; t.Text = "    "..D.Name; t.TextColor3 = Theme.Text; t.Font = "GothamBold"; t.TextXAlignment = "Left"; t.LayoutOrder = ElementCount; Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
            local bg = Instance.new("Frame", t); bg.Size = UDim2.new(0,34,0,18); bg.Position = UDim2.new(1,-44,0.5,-9); bg.BackgroundColor3 = s and Theme.Accent or Theme.Secondary; Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
            t.MouseButton1Click:Connect(function() s = not s; Tween(bg, {BackgroundColor3 = s and Theme.Accent or Theme.Secondary}); D.Callback(s) end)
        end
        return E
    end
    return Tabs
end

return Library
