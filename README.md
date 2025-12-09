FIFO Verification using SystemVerilog – Testbench Project

This project implements a class-based SystemVerilog testbench for verifying a parameterized FIFO (First-In First-Out) design. The environment includes clock/reset generation, functional condition testing, and waveform analysis suitable for EDA Playground, Icarus Verilog, or any simulator supporting SystemVerilog.

📁 Project Structure
fifo_verification/
 ├── src/                     # RTL FIFO source files
 ├── tb/                      # Testbench classes & modules
 │    ├── fifo_tb.sv
 │    ├── signals.sv
 │    ├── clk_gen.sv
 │    ├── reset_gen.sv
 │    ├── condition_test.sv
 │    └── run.sv
 ├── waves/                   # Dumped VCD files (optional)
 ├── README.md
 └── eda_playground_link.txt  # Direct link to simulation (optional)

🚀 Features

Parameterized FIFO Verification
Configurable DATA_WIDTH, DEPTH, and ADDR_WIDTH.

Class-Based SystemVerilog Environment
Includes separate classes for:

Clock generation

Reset generation

Condition-based test execution

Simulation controller

Error Detection & Reporting
Detects invalid writes, reads, underflow, overflow, and flag mismatches.

Waveform Dump Support
Generates dump.vcd for waveform viewing in GTKWave.

Clear Console Output
Structured $display messages to trace simulation flow.

🛠️ How to Run
Option 1: Run in EDA Playground

Open the provided link (optional)

Select SystemVerilog / Icarus

Enable VCD Dump (GTKWave)

Click Run

Option 2: Run Locally (Icarus Verilog)
iverilog -g2012 -o fifo_tb tb/*.sv src/*.sv
vvp fifo_tb
gtkwave dump.vcd

🧪 Verification Scenarios Covered

✔ FIFO write test
✔ FIFO read test
✔ Full flag behavior
✔ Empty flag behavior
✔ Almost full / almost empty
✔ Underflow
✔ Overflow
✔ Simultaneous read/write
✔ Data integrity checks

📘 Testbench Flow

Initialize FIFO signals

Generate clock

Apply reset

Run each verification scenario

Display pass/fail status

Dump waveform

End simulation

📸 Waveform (Optional Screenshot)

You may add a screenshot of your GTKWave output here.

📄 Future Enhancements

Add SystemVerilog Assertions (SVA)

Add random stimulus

Add coverage (functional & code)

Add scoreboard/monitor (towards UVM structure)

Convert to full UVM testbench

👩‍💻 Author

Priyanka S
Chennai Institute of Technology
Electronics and Communication Engineering