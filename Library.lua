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

-- [ 📐 ULTRA COMPACT SCALING ]
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

function Library:CreateWindow(Config)
    local Gui = Instance.new("ScreenGui", game:GetService("CoreGui")); Gui.Name = "TURK_ULTRA_COMPACT"; Gui.IgnoreGuiInset = true
    
    local Main = Instance.new("Frame", Gui); Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 0, 0, 0); Main.Position = UDim2.new(0.5, 0, 0.5, 0); Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Theme.Main; Main.BackgroundTransparency = 0.05; Main.ClipsDescendants = true; Main.Visible = false
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    local MStroke = Instance.new("UIStroke", Main); MStroke.Thickness = 2; MStroke.Color = Theme.Accent
    local UIGrad = Instance.new("UIGradient", MStroke)
    UIGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(0.5,0.8), NumberSequenceKeypoint.new(1,0)})
    task.spawn(function() while RS.RenderStepped:Wait() do UIGrad.Rotation = (UIGrad.Rotation + 3) % 360 end end)

    local TogF = Instance.new("Frame", Gui); TogF.Size = UDim2.new(0, 40, 0, 40); TogF.Position = UDim2.new(0.02, 0, 0.1, 0); TogF.BackgroundColor3 = Theme.Main; TogF.Visible = false; Instance.new("UICorner", TogF).CornerRadius = UDim.new(1, 0)
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
    -- [ ⏳ ALL-IN-ONE LOADER & KEY ]
    local function StartEngine()
        local LFrame = Instance.new("Frame", Gui); LFrame.Size = UDim2.new(0, 260, 0, 150); LFrame.Position = UDim2.new(0.5, 0, 0.5, 0); LFrame.AnchorPoint = Vector2.new(0.5, 0.5); LFrame.BackgroundColor3 = Theme.Main; Instance.new("UICorner", LFrame); local LS = Instance.new("UIStroke", LFrame); LS.Color = Theme.Accent; LS.Thickness = 2
        local LTit = Instance.new("TextLabel", LFrame); LTit.Size = UDim2.new(1, 0, 0, 45); LTit.Text = Config.Name; LTit.TextColor3 = Theme.Accent; LTit.Font = "GothamBlack"; LTit.TextSize = 16; LTit.BackgroundTransparency = 1
        
        local LBarBG = Instance.new("Frame", LFrame); LBarBG.Size = UDim2.new(0.8, 0, 0, 3); LBarBG.Position = UDim2.new(0.1, 0, 0.6, 0); LBarBG.BackgroundColor3 = Theme.Secondary; Instance.new("UICorner", LBarBG)
        local LBar = Instance.new("Frame", LBarBG); LBar.Size = UDim2.new(0, 0, 1, 0); LBar.BackgroundColor3 = Theme.Accent; Instance.new("UICorner", LBar)

        -- แอนิเมชันตอนโหลด
        for i = 1, 100 do LBar.Size = UDim2.new(i/100, 0, 1, 0) task.wait(0.005) end

        -- เช็คว่าเปิดใช้งานระบบ Key หรือไม่
        if Config.KeySystem then
            LBarBG.Visible = false
            LTit.Text = "AUTHENTICATION"

            local KInp = Instance.new("TextBox", LFrame); KInp.Size = UDim2.new(0.85, 0, 0, 32); KInp.Position = UDim2.new(0.075, 0, 0.35, 0); KInp.PlaceholderText = "Enter License Key..."; KInp.Text = ""; KInp.BackgroundColor3 = Theme.Secondary; KInp.TextColor3 = Theme.Text; KInp.Font = "GothamBold"; KInp.TextSize = 11; Instance.new("UICorner", KInp)
            local KBtn = Instance.new("TextButton", LFrame); KBtn.Size = UDim2.new(0.85, 0, 0, 32); KBtn.Position = UDim2.new(0.075, 0, 0.62, 0); KBtn.Text = "LOGIN"; KBtn.BackgroundColor3 = Theme.Accent; KBtn.TextColor3 = Theme.Main; KBtn.Font = "GothamBlack"; KBtn.TextSize = 12; Instance.new("UICorner", KBtn)
            local GBtn = Instance.new("TextButton", LFrame); GBtn.Size = UDim2.new(1, 0, 0, 20); GBtn.Position = UDim2.new(0, 0, 0.85, 0); GBtn.Text = "Get Key Link"; GBtn.BackgroundTransparency = 1; GBtn.TextColor3 = Color3.fromRGB(130, 130, 130); GBtn.Font = "GothamBold"; GBtn.TextSize = 10

            GBtn.MouseButton1Click:Connect(function() 
                if setclipboard then setclipboard(Config.KeyLink or "") end
                GBtn.Text = "LINK COPIED!"; task.wait(1.5); GBtn.Text = "Get Key Link" 
            end)

            KBtn.MouseButton1Click:Connect(function()
                if KInp.Text == Config.Key then 
                    KBtn.Text = "SUCCESS!"; Tween(LFrame, {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}, 0.5)
                    task.wait(0.5); LFrame:Destroy(); Main.Visible = true; TogF.Visible = true; Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.5)
                else
                    LS.Color = Color3.new(1,0,0); task.spawn(function() for i=1,8 do LFrame.Position = UDim2.new(0.5, math.random(-2,2), 0.5, math.random(-2,2)); task.wait(0.01) end LFrame.Position = UDim2.new(0.5,0,0.5,0) end)
                    task.wait(1); LS.Color = Theme.Accent
                end
            end)
        else
            -- ถ้า KeySystem = false ให้เข้าหน้าหลักทันที
            LBar.Size = UDim2.new(1, 0, 1, 0)
            task.wait(0.2)
            Tween(LFrame, {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}, 0.5)
            task.wait(0.5); LFrame:Destroy(); Main.Visible = true; TogF.Visible = true; Tween(Main, {Size = UDim2.new(0, MainWidth, 0, MainHeight)}, 0.5)
        end
    end
    return Tabs
end
return Library
