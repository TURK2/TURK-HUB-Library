# 🌌 TURK HUB | ULTIMATE EDITION
**The Most Advanced & Adaptive UI Library for Roblox Scripting.**
## 🚀 วิธีการเรียกใช้งาน (Boot Script)
ก๊อปปี้โค้ดด้านล่างนี้ไปวางใน Executor ของคุณเพื่อเริ่มต้นใช้งาน:
```lua
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/TURK2/TURK-HUB-Library/refs/heads/main/Library.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "TURK HUB",
    Key = "TURK-6699" -- ตั้งรหัสผ่านที่นี่
})

-- [[ การแจ้งเตือนเมื่อโหลดสำเร็จ ]]
Rayfield:Notify({
    Title = "Script Loaded",
    Content = "Welcome to TURK HUB Ultimate Edition",
    Duration = 5
})

```
## 🛠️ เอกสารการใช้งาน (Documentation)
### 📂 การสร้าง Tab (Tabs)
ใช้สำหรับแยกหมวดหมู่ของฟีเจอร์ต่างๆ
```lua
local MainTab = Window:CreateTab("Main Cheats")
local MiscTab = Window:CreateTab("Settings")

```
### 📋 การสร้าง Section (Sections)
ใช้จัดระเบียบองค์ประกอบภายใน Tab
```lua
MainTab:CreateSection("Combat Settings")

```
### 🔘 ปุ่มกด (Buttons)
```lua
MainTab:CreateButton({
    Name = "Kill All Players",
    Callback = function()
        print("Executing Kill All...")
    end
})

```
### Toggle (เปิด/ปิด)
```lua
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Farm status:", Value)
    end
})

```
### 📏 แถบเลื่อน (Sliders)
```lua
MainTab:CreateSlider({
    Name = "WalkSpeed Hack",
    Range = {16, 500},
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

```
### 🔽 ตัวเลือกรายการ (Dropdowns)
```lua
MainTab:CreateDropdown({
    Name = "Select Target",
    Options = {"Head", "Torso", "Random"},
    Callback = function(Option)
        print("Selected Target:", Option)
    end
})

```
### ✍️ ช่องกรอกข้อมูล (Inputs)
```lua
MiscTab:CreateInput({
    Name = "Custom FOV",
    PlaceholderText = "Enter FOV (Default 70)",
    Callback = function(Text)
        workspace.CurrentCamera.FieldOfView = tonumber(Text) or 70
    end
})

```
## ✨ จุดเด่นของ Library นี้
 * **Rayfield-Style API:** เปลี่ยนมาใช้การเรียกแบบ Rayfield:CreateWindow ทำให้คนย้ายค่ายมาใช้ของพี่ได้ทันทีโดยไม่ต้องแก้โค้ดเยอะ
 * **Adaptive Interface:** หน้าต่างสวยงาม พอดีทุกหน้าจอ ไม่ว่าจะเป็นมือถือหรือคอมพิวเตอร์
 * **No Version Tags:** ลบเลขเวอร์ชันออกเพื่อความสะอาดตาและดูเป็นสคริปต์ระดับพรีเมียม
 * **Security Integrated:** ระบบ Key System ฝังมาให้ในตัว ปลอดภัยแน่นอน
