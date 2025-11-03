# uvm-verification-sequential-logic
UVM-Based Verification of Sequential Logic Circuits — Includes D Flip-Flop and Mod-12 Up-Down Counter verification environments with constrained random stimulus, functional coverage, and assertions

# 🎯 UVM-Based Verification of Sequential Logic Circuits

This repository contains the UVM-based verification environments for two fundamental sequential circuits:
1. **D Flip-Flop**
2. **Mod-12 Up-Down Counter**

## 🔍 What’s Verified

### ✅ D Flip-Flop
- Edge-triggered behavior (Q updates on active clock edge)
- Reset functionality
- Setup and hold timing validation to prevent metastability

### ✅ Mod-12 Up-Down Counter
- Correct counting from 0 to 11 and wrap-around behavior
- Direction control via Up/Down signal
- Reset and enable-based operation

## 🔹 Verification Methodology
- Modular UVM Testbench with Driver, Monitor, Sequencer, Scoreboard, and Coverage
- Achieved **100% functional coverage**
- Included constrained random stimulus and self-checking Scoreboard

## 🛠️ Tools Used
- Synopsys VCS
- QuestaSim
- Verdi
- SpyGlass
- Design Compiler

## 📁 Repository Structure
Each subfolder (DFF_Verification, Counter_Verification) contains RTL, UVM Testbench, Simulation, and Documentation files.

## 💡 Learning Outcome
This project enhanced understanding of sequential logic behavior and the construction of reusable UVM environments.

---

📍 *Author:* **Muttu B Naik**  
📧 *Email:* muttunaik5096@gmail.com  
🔗 *LinkedIn:* [linkedin.com/in/muttu-naik](https://linkedin.com/in/muttu-naik)
