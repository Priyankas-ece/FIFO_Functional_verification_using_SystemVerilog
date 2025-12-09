# FIFO Functional Verification using SystemVerilog   

This project implements a class-based SystemVerilog testbench for verifying a parameterized FIFO (First-In First-Out) design. The environment includes clock/reset generation, functional condition testing and waveform analysis suitable for EDA Playground, Icarus Verilog or any simulator supporting SystemVerilog.   

## 📁 Project Structure   
fifo_verification/   
 ├── src/                     # RTL FIFO source files   
 │    └── Design.sv   
 ├── tb/                      # Testbench classes & modules   
 │    ├── testbench.sv   
 │    ├── signals.sv   
 │    ├── clk_gen.sv   
 │    ├── reset_gen.sv   
 │    ├── condition_test.sv   
 │    └── run.sv   
 ├── outputs/                   # Waveforms and Log file   
 │    ├── stimulation_log.txt     
 │    └── fifo_waveform.png     
 └── README.md   

## 🚀 Features
- Parameterized FIFO Verification   
  - Configurable DATA_WIDTH, DEPTH, and ADDR_WIDTH.   
- Class-Based SystemVerilog Environment   
  Includes separate classes for:   
  - Clock generation
  - Reset generation
  - Condition-based test execution
  - Simulation controller
- Error Detection & Reporting   
  Detects invalid writes, reads, underflow, overflow, and flag mismatches.
- Waveform Dump Support   
  Generates dump.vcd for waveform viewing in GTKWave.
- Clear Console Output   
  Structured $display messages to trace simulation flow.

## 🛠️ How to Run
- Option 1: Run in EDA Playground (online)
1. Create new playground
2. Copy and Paste the code of Design and Testbench
3. Select Aldec Riviera as Tools and Stimulators
4. Check open EPWave after run
5. Save and Click Run

- Option 2: Run Locally (Icarus Verilog)
```bash
iverilog -g2012 -o fifo_tb tb/*.sv src/*.sv
vvp fifo_tb
gtkwave dump.vcd
```

## 🧪 Verification Scenarios Covered
✔ FIFO write test
✔ FIFO read test
✔ Full flag behavior
✔ Empty flag behavior
✔ Almost full / almost empty
✔ Underflow
✔ Overflow
✔ Simultaneous read/write
✔ Data integrity checks

## 📘 Testbench Flow
1. Initialize FIFO signals
2. Generate clock
3. Apply reset
4. Run each verification scenario
5. Display pass/fail status
6. Dump waveform
7. End simulation

## 📸 Waveform
<img width="1772" height="611" alt="fifo_waveform" src="https://github.com/user-attachments/assets/607a22f7-4318-4e64-b666-c742f0e6b622" />

## 🔗 EDA Playground Link
https://www.edaplayground.com/x/WSXk   

## 📄 Future Enhancements
- Add SystemVerilog Assertions (SVA)
- Add random stimulus
- Add coverage (functional & code)
- Add scoreboard/monitor (towards UVM structure)
- Convert to full UVM testbench

## 👩‍💻 Author
Priyanka S   
Chennai Institute of Technology   
Electronics and Communication Engineering   
