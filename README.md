```markdown
# 🌌 TURK HUB | ULTIMATE EDITION
**Advanced, Adaptive, and Aesthetic UI Library for Roblox Scripting.**

---

### 💻 วิธีการรัน
```lua
local Library = loadstring(game:HttpGet("ลิงก์_Library_ของพี่_ตรงนี้"))()

local Window = Library:CreateWindow({
    Name = "TURK HUB",
    KeySystem = true,
    Key = "TURK-6699"
})

-- ตัวอย่างการแจ้งเตือน
Library:Notify({
    Title = "Welcome!",
    Content = "สคริปต์กำลังเริ่มทำงาน...",
    Duration = 5
})
```
## 🛠️ เอกสารการใช้งาน (Documentation)
### 📂 การสร้าง Tab & Section
```lua
local MainTab = Window:CreateTab("Main Cheats")
MainTab:CreateSection("Movement Settings")

```
### 🔘 ปุ่มกด (Button)
```lua
MainTab:CreateButton({
    Name = "Click Me!",
    Callback = function()
        print("Clicked!")
    end
})

```
### 🔘 เปิด/ปิด (Toggle)
```lua
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        print("Status:", Value)
    end
})

```
### 📏 แถบเลื่อน (Slider)
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
### 🔽 ตัวเลือก (Dropdown)
```lua
MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Sword", "Gun", "Magic"},
    Callback = function(Option)
        print("Selected:", Option)
    end
})

```
### 📢 การแจ้งเตือน (Notification)
```lua
Rayfield:Notify({
    Title = "Welcome",
    Content = "TURK HUB Loaded Successfully!",
    Duration = 5
})

```
## ✨ จุดเด่น (Features)
 * 📱 **Adaptive UI:** ขนาดพอดีทั้งมือถือและคอมพิวเตอร์
 * 🔑 **Toggleable Key System:** เลือกเปิดหรือปิดหน้าใส่คีย์ได้ง่ายๆ
 * 🎨 **Modern Design:** สไตล์โปร่งแสงพร้อม Neon Glow
 * ⚡ **Ultra Smooth:** อนิเมชันนุ่มนวล ไม่กินสเปคเครื่อง
```

พี่ก๊อปไปใส่ได้เลยครับ! ระบบเปิด-ปิด Key ใช้งานง่ายมาก แค่แก้ `KeySystem = true` หรือ `false` ในตัวสคริปต์ตอนเรียกใช้ครับ! มีอะไรเพิ่มบอกได้เลยพี่!

```
