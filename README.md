# TURK-HUB-Library
**The Most Advanced & Adaptive UI Library for Roblox Scripting.**
TURK-HUB เป็น UI Library ที่ถูกออกแบบมาให้มีความสวยงาม ทันสมัย และใช้งานง่ายสไตล์ Rayfield โดยเน้นความลื่นไหลของ Animation และการรองรับทุกอุปกรณ์ (PC, Mobile, Tablet) พร้อมระบบ Key System ในตัว
## ✨ คุณสมบัติเด่น (Key Features)
 * 📱 **Adaptive Scaling:** หน้าต่าง UI ปรับขนาดอัตโนมัติให้พอดีกับหน้าจอมือถือและคอมพิวเตอร์
 * 🔑 **Integrated Key System:** มีระบบล็อกสคริปต์ในตัวก่อนเข้าหน้าหลัก
 * 🎭 **Glassmorphism Design:** สไตล์กระจก Cosmic พร้อมเส้นขอบ Neon Glow สวยงาม
 * 📢 **Notification System:** ระบบแจ้งเตือนมุมจอที่นุ่มนวล
 * ⚡ **Smooth Animations:** ขับเคลื่อนด้วย TweenService ทั้งระบบเพื่อความลื่นไหลขั้นสุด
## 🚀 วิธีการใช้งาน (Getting Started)
วางโค้ดนี้ที่ส่วนบนสุดของสคริปต์เพื่อโหลด Library:
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TURK2/TURK-HUB-Library/refs/heads/main/Library.lua"))()

```
## 🛠️ ตัวอย่างการเขียนสคริปต์ (Full Documentation)
### 1. สร้างหน้าต่างหลัก (Create Window)
กำหนดชื่อเมนูและรหัสผ่านสำหรับเข้าใช้งาน
```lua
local Window = Library:CreateWindow({
    Name = "TURK HUB ",
    Key = "111" -- รหัสผ่านเข้าสคริปต์
})

```
### 2. การแจ้งเตือน (Notifications)
```lua
Library:Notify({
    Title = "Script Status",
    Content = "TURK-HUB has been loaded successfully!",
    Duration = 5 -- จำนวนวินาทีที่แสดง
})

```
### 3. สร้างแถบเมนู (Create Tab)
```lua
local MainTab = Window:CreateTab("Main Cheats")
local SettingTab = Window:CreateTab("Settings")

```
### 4. องค์ประกอบภายใน (Elements)
#### 🔹 Section (ตัวแบ่งส่วน)
```lua
MainTab:CreateSection("Combat Features")

```
#### 🔹 Button (ปุ่มกด)
```lua
MainTab:CreateButton({
    Name = "Click Me!",
    Callback = function()
        print("Button Clicked!")
    end
})

```
#### 🔹 Toggle (เปิด/ปิด)
```lua
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        print("Toggle is:", Value)
    end
})

```
#### 🔹 Slider (แถบเลื่อน)
```lua
MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 500},
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

```
#### 🔹 Dropdown (ตัวเลือก)
```lua
MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Sword", "Gun", "Magic"},
    Callback = function(Option)
        print("Selected: " .. Option)
    end
})

```
#### 🔹 Input (ช่องกรอกข้อมูล)
```lua
SettingTab:CreateInput({
    Name = "Set FOV",
    PlaceholderText = "Default 70",
    Callback = function(Text)
        workspace.CurrentCamera.FieldOfView = tonumber(Text) or 70
    end
})

```
## 📜 Credits
 * **Developed by:** [Maytawin]
 * **Version:** 1.0.0
 * **Inspired by:** TURKHUB UI