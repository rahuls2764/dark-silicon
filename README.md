# 🎮 VGA-Based Racing Game on FPGA (Verilog)

## 📌 Overview
This project implements a **real-time VGA-based racing game** using **Verilog HDL** on the **Basys 3 FPGA board**.  
The system generates VGA signals, renders a dynamic racing track with **curved road geometry**, and supports **interactive steering control** using push buttons.

🏆 This project won **1st Place** at the **Dark Silicon (VLSI) Event**.

---

## 🏆 Achievement
- 🥇 **Winner – Dark Silicon (VLSI Event)**

---

## 🎯 Objectives
The project was developed in two stages:
- **Task 1:** Display a static vehicle with a vertically scrolling track to simulate forward motion.
- **Task 2:** Implement curved road geometry and real-time steering using push-button inputs.

---

## 🧠 System Architecture
The design integrates VGA timing generation, scrolling logic, steering control, and real-time rendering.

### Major Modules
| Module Name | Function |
|------------|----------|
| `clock_divider` | Divides 100 MHz system clock to 25 MHz VGA pixel clock |
| `vga_sync` | Generates VGA sync pulses and pixel coordinates |
| `scroll_controller` | Creates vertical scrolling motion |
| `steering_controller` | Handles left/right steering input |
| `game_renderer` | Renders road, vehicle, curves, and visual effects |

---

## 🖥️ VGA Timing Specifications
- **Resolution:** 640 × 480 @ 60 Hz  
- **Pixel Clock:** 25 MHz  
- **Horizontal Total:** 800 pixels  
- **Vertical Total:** 525 lines  
- **Frame Rate:** 60 FPS  

---

## 🚗 Vehicle & Track Parameters
- Vehicle Position: **X = 305, Y = 380**
- Vehicle Size: **40 × 60 pixels**
- Road Width: **220 pixels (perspective scaled)**
- Scroll Speed: **3 px/frame**
- Steering Offset Limit: **±80 px**
- Frame Period: **16.6 ms**

---

## 🌀 Curved Road Geometry
- Curve Index: **y_scroll[8:3]** (maps vertical position to curve segment)
- Sine Function: **sin(2π × curve_index / 64)** for smooth curvature
- Curve Amplitude: **±80 pixels** (maximum lateral shift)
- Road Center Calculation: **320 + sine_value + lateral_offset**
- Perspective Scaling: **road_width = BASE_WIDTH + (y / 8)**
- Effect: **Smooth oscillating curved road with depth perspective**

---

## 🎨 Rendering & Visual Effects
Each pixel is rendered based on its position and animation state.

### Visual Elements
- Metallic vehicle body and glowing windshield  
- Animated thrusters with intensity modulation  
- Neon center line and pulsing rumble strips  
- Gradient road shading  
- Animated starfield and galaxy background  

---

## 🎮 User Controls
- **Left Button:** Road shifts right (vehicle moves left)  
- **Right Button:** Road shifts left (vehicle moves right)  
- **No Input:** Automatic centering behavior  

---

## 🛠️ Tools & Hardware
- **Language:** Verilog HDL  
- **FPGA Board:** Basys 3 (Artix-7)  
- **Toolchain:** Xilinx Vivado  
- **Display:** VGA Monitor (640 × 480)  

---

## ▶️ How to Run
1. Open the project in **Xilinx Vivado**
2. Add all RTL modules, testbenches, and the **XDC constraint file**
3. Run simulation to verify functionality
4. Synthesize and generate the bitstream
5. Program the **Basys 3 FPGA** and connect a VGA display


