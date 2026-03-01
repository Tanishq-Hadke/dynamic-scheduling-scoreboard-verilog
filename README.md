# Out-of-Order Issue Scoreboard Simulator (RTL)

## 📌 Project Overview

This project implements a simplified dynamic scheduling engine using the classical **Scoreboard algorithm**, inspired by the CDC 6600 architecture.

The design is written in Verilog RTL and simulated using Xilinx Vivado.  
It demonstrates out-of-order instruction issue, hazard detection, and variable-latency functional unit modeling.

This is a microarchitecture-level design project focused purely on RTL + simulation (no FPGA board required).

---

## 🧠 Microarchitectural Features

- Instruction Window
- Reservation Station
- Scoreboard Register Status Table
- RAW hazard detection
- WAW hazard prevention
- Structural hazard handling
- Variable-latency functional unit
- Writeback stage
- FSM-based control engine

---

## 🏗 Architecture

Instruction Flow:

FETCH → ISSUE → EXECUTE → WRITEBACK

Components:

- Instruction Register
- Issue Logic
- Scoreboard Table
- Reservation Station
- Functional Unit (latency modeled)
- Writeback Unit

---

## 📂 Project Structure
scoreboard-out-of-order-simulator-rtl/
│
├── rtl/
│ ├── scoreboard_top.v
│ ├── scoreboard_table.v
│ ├── issue_logic.v
│ ├── reservation_station.v
│ ├── functional_unit.v
│ ├── writeback_unit.v
│
├── sim/
  └── tb_scoreboard.v

  
---

## 🔢 Instruction Format

Custom 32-bit instruction format:

[31:28] Opcode  
[27:23] Destination Register (rd)  
[22:18] Source Register 1 (rs1)  
[17:13] Source Register 2 (rs2)

Supported operations:

| Opcode | Operation | Latency |
|--------|-----------|----------|
| 0001   | ADD       | 1 cycle  |
| 0010   | SUB       | 1 cycle  |
| 0011   | MUL       | 3 cycles |
| 0100   | DIV       | 5 cycles |

---

## ⚙ Scoreboard Operation

The scoreboard tracks register availability:

- A register is marked busy when issued.
- Writeback clears the busy bit.
- Issue logic checks:
  - RAW hazards (source busy)
  - WAW hazards (destination busy)
  - Structural hazard (reservation station busy)

Instruction issue is stalled if any hazard is detected.

---

## 🧪 Simulation

Simulation is performed using Vivado Behavioral Simulation.

### Steps:

1. Create RTL project in Vivado
2. Add all files from `rtl/`
3. Add `tb_scoreboard.v` under Simulation Sources
4. Run Behavioral Simulation
5. Observe signals:
   - busy_table
   - issue_en
   - fu_start
   - fu_done
   - wb_en
   - FSM state transitions

Expected behavior:
- Instruction issued only when safe
- Busy bits set during execution
- Writeback clears scoreboard entry
- Variable latency modeled correctly

---

## 🎓 Concepts Demonstrated

- Dynamic scheduling
- Scoreboarding algorithm
- Pipeline hazard control
- Latency modeling
- Microarchitecture partitioning
- RTL modular design
- FSM-based control

---

## 🚀 Possible Extensions

- Multiple reservation stations
- Multiple functional units
- Instruction window FIFO
- Out-of-order completion
- Reorder buffer
- Register renaming (Tomasulo algorithm)
- Performance counters

---

## 📚 Learning Outcome

This project demonstrates understanding of:

- Classic scoreboard scheduling (CDC 6600)
- Hardware-based dependency tracking
- Out-of-order execution principles
- Advanced digital design partitioning
- RTL-level microarchitectural modeling

---

## 👤 Author

TANISHQ HADKE
B.Tech Electronics / Digital Design Enthusiast  

