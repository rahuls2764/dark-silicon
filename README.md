# 🎮 VGA-Based Racing Game on FPGA (Verilog)

## 📌 Overview
This project implements a **real-time VGA-based racing game** using **Verilog HDL** on the **Basys 3 FPGA board**.  
The design generates VGA signals, renders a dynamic racing track with **curved road geometry**, and enables **interactive steering control** using push buttons.

This project won **1st Place** at the **Dark Silicon (VLSI) Event**.

---

## 🏆 Achievement
- 🥇 **Winner – Dark Silicon (VLSI Event)**

---

## 🎯 Objectives
The project was developed in two phases:
- **Task 1:** Display a static vehicle with a vertically scrolling track to simulate forward motion.
- **Task 2:** Introduce curved road geometry and real-time steering control using push-button inputs.

---

## 🧠 System Architecture
The system integrates VGA timing generation, scrolling logic, steering control, and real-time rendering.

### Major Modules
| Module Name | Function |
|------------|----------|
| `clock_divider` | Divides 100 MHz system clock to 25 MHz VGA pixel clock |
| `vga_sync` | Generates VGA sync pulses and pixel coordinates |
| `scroll_controller` | Creates vertical scrolling motion |
| `steering_controller` | Handles left/right steering input |
| `game_renderer` | Draws road, vehicle, curves, and visual effects |

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
Curvature is implemented using a sine-wave approximation:


curve_index = y_scroll[8:3]
sine_value = sin(2π × curve_index / 64) × 80
road_center = 320 + sine_value + lateral_offset
road_width  = BASE_WIDTH + (y / 8)


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
Curvature is implemented using a sine-wave approximation:

```text
curve_index = y_scroll[8:3]
sine_value = sin(2π × curve_index / 64) × 80
road_center = 320 + sine_value + lateral_offset
road_width  = BASE_WIDTH + (y / 8)

