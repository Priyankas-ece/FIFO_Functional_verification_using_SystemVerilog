//-------------------------------------------------------------
// File      : clk_gen.sv
// Author    : Priyanka S
// Description: Clock generation class for FIFO testbench
//-------------------------------------------------------------


//=====================================================================
//  CLOCK GENERATOR CLASS
//=====================================================================
// This class continuously toggles the clock signal with a 10-time-unit
// period (5-time-unit high, 5-time-unit low).
//=====================================================================

class clk_gen;

  task clock_gen();
    // Initialize clock before starting generation
    clk = 1'b0;

    $display("\n----------------------------------------------");
    $display("                CLOCK GENERATION STARTED       ");
    $display("----------------------------------------------");

    forever begin
      #5 clk = ~clk;
      $display("Time=%0t : Clock toggled -> clk = %b", $time, clk);
    end
  endtask

endclass