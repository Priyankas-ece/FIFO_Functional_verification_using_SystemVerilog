//-------------------------------------------------------------
// File      : reset_gen.sv
// Author    : Priyanka S
// Description: Reset generation class for FIFO testbench
//-------------------------------------------------------------


//=====================================================================
//  RESET GENERATOR CLASS
//=====================================================================
// This class generates a clean reset pulse for the FIFO testbench.
// The reset sequence:
//   1. Assert reset (reset_n = 0)
//   2. Wait for a few clock cycles
//   3. Release reset (reset_n = 1)
//=====================================================================

class reset_gen;

  task rst_gen();
    $display("\n----------------------------------------------");
    $display("               RESET SEQUENCE STARTED         ");
    $display("----------------------------------------------");

    // Assert reset
    reset_n = 1'b0;
    $display("Time=%0t : Reset ASSERTED (reset_n = 0)", $time);

    // Hold reset for 2 clock edges
    repeat (2) @(posedge clk);

    // Deassert reset
    reset_n = 1'b1;
    $display("Time=%0t : Reset DEASSERTED (reset_n = 1)", $time);

    $display("----------------------------------------------");
    $display("               RESET SEQUENCE ENDED           ");
    $display("----------------------------------------------\n");
  endtask

endclass