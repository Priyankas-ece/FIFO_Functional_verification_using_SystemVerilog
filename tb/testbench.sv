//-------------------------------------------------------------
// File      : testbench.sv
// Author    : Priyanka S
// Description: Testbench module for FIFO testbench
//-------------------------------------------------------------


//===============================================================
//  FIFO VERIFICATION TESTBENCH
//===============================================================

// Include all required design and package files

`include "files.sv"

//---------------------------------------------------------------
// Testbench Module
//---------------------------------------------------------------
module fifo_tb;

  
  //=============================================================
  // DUT Instantiation
  //=============================================================
  fifo #(                      // Parameters Instantiation
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)) 
  uut (                        // uut signals Instantiation
    .clk(clk),
    .reset_n(reset_n),
    .write_en(write_en),
    .read_en(read_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty),
    .almost_full(almost_full),
    .almost_empty(almost_empty),
    .overflow(overflow),
    .underflow(underflow)
  );
  
  
  //-------------------------------------------------------------
  // Create Class Object for Running Test Sequences
  //-------------------------------------------------------------
  run_tb rh = new();
  
  
  //-------------------------------------------------------------
  // Initialize Signals
  //-------------------------------------------------------------
  initial begin
    clk = 0;
    reset_n = 0;
    write_en = 0;
    read_en = 0;
    data_in = 0;
    data_out_check = 0;
    error_count = 0;
  end
  
  
  //-------------------------------------------------------------
  // Start the Run-Test Sequence
  //-------------------------------------------------------------
  initial begin
    $display("------------------------------------------------------");
    $display("        FIFO TEST SEQUENCE STARTED FROM TB            ");
    $display("------------------------------------------------------");
    
    rh.run_code();      // Calling user-defined run TB task
    
    $display("------------------------------------------------------");
    $display("               FIFO TEST SEQUENCE ENDED               ");
    $display("------------------------------------------------------");
    #10
    $finish;
  end
  
  
  //-------------------------------------------------------------
  // Dump VCD Waveform
  //-------------------------------------------------------------
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

endmodule