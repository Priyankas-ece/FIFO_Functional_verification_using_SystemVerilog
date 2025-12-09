//-------------------------------------------------------------
// File      : condition_test.sv
// Author    : Priyanka S
// Description: Conditions checking class for FIFO testbench
//-------------------------------------------------------------


//=====================================================================
//  TESTING ALL FIFO CONDITIONS
//=====================================================================

class condition_test;
  
  // Main test sequence task
  task calling();
    $display("\n========== STARTING ALL FIFO TESTS ==========\n");
    reset_test();                                  // Call reset
    basic_write_read_test();                       // Test basic FIFO ops
    underflow_test();                              // Test underflow condition
    overflow_test();                               // Test overflow condition
    simultaneous_read_write_empty_test();          // Test simultaneous R/W on empty FIFO
    simultaneous_read_write_full_test();           // Test simultaneous R/W on full FIFO
    error_counting();                              // Display final results
  endtask
  

  //=====================================================================
  // Task: BASIC FIFO WRITE/READ OPERATION TEST
  //=====================================================================
  task basic_write_read_test();
    begin
      $display("\n----- BASIC WRITE/READ TEST STARTED -----");

      for (int i = 0; i < DEPTH; i++) begin
        write_en = 1;
        data_in = i;
        #10;
        write_en = 0;
        #10;
      end
      $display("Writing completed… Checking FULL flag");

      // Check full flag
      if (!full) begin
        $error("Basic Write/Read Test: FIFO should be full");
        error_count++;
      end

      $display("Reading and verifying FIFO contents...");

      // Read values back and verify
      for (int i = 0; i < DEPTH; i++) begin
        read_en = 1;
        #10;
        read_en = 0;
        if (data_out != i) begin
          $error("Basic Write/Read Test: Data mismatch at index %0d: expected %0d, got %0d", i, i, data_out);
          error_count++;
        end
        #10;
      end

      // Status flag checks
      $display("Checking EMPTY, OVERFLOW, and UNDERFLOW flags...");

      if (!empty) begin
        $error("Basic Write/Read Test: FIFO should be empty");
        error_count += 1;
      end

      if (overflow) begin
        $error("Basic Write/Read Test: FIFO should not overflow");
        error_count += 1;
      end
      
      if (underflow) begin
        $error("Basic Write/Read Test: FIFO should not underflow");
        error_count += 1;
      end

      $display("----- BASIC WRITE/READ TEST COMPLETED -----\n");
    end
  endtask
  

  //=====================================================================
  // Task: FIFO UNDERFLOW TEST
  //=====================================================================
  task underflow_test();
    begin
      $display("\n----- UNDERFLOW TEST STARTED -----");

      data_out_check = data_out;
      write_en = 1;
      data_in = 16'hA5A5;
      #10;
      write_en = 0;
      #10;

      reset_test();

      // Attempt to read while empty
      $display("Reading from empty FIFO to trigger UNDERFLOW...");
      read_en = 1;
      #10;
      read_en = 0;

      if (!underflow) begin
        $error("Underflow Test: Underflow flag should be asserted");
        error_count++;
      end

      if (data_out != data_out_check) begin
        $error("Underflow Test: Data out should remain unchanged after underflow.");
        error_count++;
      end

      $display("----- UNDERFLOW TEST COMPLETED -----\n");
    end
  endtask
  

  //=====================================================================
  // Task: FIFO OVERFLOW TEST
  //=====================================================================
  task overflow_test();
    begin
      $display("\n----- OVERFLOW TEST STARTED -----");

      for (int i = 0; i < DEPTH; i++) begin
        write_en = 1;
        data_in = i;
        #10;
        write_en = 0;
        #10;
      end

      $display("Attempting extra write to trigger OVERFLOW...");

      // Attempt to write additional data
      write_en = 1;
      data_in = 16'hFFFF;
      #10;
      write_en = 0;

      if (!overflow) begin
        $error("Overflow Test: Overflow flag should be asserted");
        error_count++;
      end

      $display("Reading and verifying FIFO contents...");

      // Read out all values and verify
      for (int i = 0; i < DEPTH; i++) begin
        read_en = 1;
        #10;
        read_en = 0;
        if (data_out != i) begin
          $error("Overflow Test: Data mismatch at index %0d: expected %0d, got %0d", i, i, data_out);
          error_count++;
        end
        #10;
      end

      $display("Checking FIFO emptiness after draining...");

      // Ensure the overflowed value is not in FIFO
      read_en = 1;
      #10;
      read_en = 0;
      if (!empty) begin
        $error("Overflow Test: FIFO should be empty after reading all values");
        error_count++;
      end

      $display("----- OVERFLOW TEST COMPLETED -----\n");
    end
  endtask
  

  //=====================================================================
  // Task: SIMULTANEOUS READ/WRITE WHEN FIFO EMPTY
  //=====================================================================
  task simultaneous_read_write_empty_test();
    begin
      $display("\n----- SIMULTANEOUS R/W WHILE EMPTY TEST STARTED -----");

      data_out_check = data_out; 
      
      reset_test();

      $display("Performing simultaneous read/write while FIFO is EMPTY...");

      // Attempt to write and read simultaneously
      write_en = 1;
      read_en = 1;
      data_in = 16'h1234;
      #10;
      read_en = 0;
      #10;

      if (data_out != data_out_check) begin
        $error("Simultaneous Read/Write Empty Test: Data should remain unchanged on invalid R/W.");
        error_count++;
      end

      if (!underflow) begin
        $error("Simultaneous Read/Write Empty Test: Underflow flag must be set.");
        error_count++;
      end

      // Status flag checks
      if (empty) begin
        $error("Simultaneous Read/Write Empty Test: FIFO should not be empty after write.");
        error_count++;
      end
      if (!almost_empty) begin
        $error("Simultaneous Read/Write Empty Test: FIFO must be almost empty after first write.");
        error_count++;
      end
      $display("Performing valid simultaneous read/write...");

      // Test valid simultaneous read and write
      write_en = 1;
      read_en = 1;
      data_in = 16'h5678;
      #10;
      write_en = 0;
      read_en = 0;
      #10;

      if (data_out != 16'h1234) begin
        $error("Simultaneous Read/Write Empty Test: Data mismatch after R/W.");
        error_count++;
      end

      if (empty) begin
        $error("Simultaneous Read/Write Empty Test: FIFO should not be empty now.");
        error_count++;
      end

      if (!almost_empty) begin
        $error("Simultaneous Read/Write Empty Test: FIFO must be almost empty.");
        error_count++;
      end

      $display("----- SIMULTANEOUS R/W WHILE EMPTY TEST COMPLETED -----\n");
    end
  endtask
  

  //=====================================================================
  // Task: SIMULTANEOUS READ/WRITE WHEN FIFO FULL
  //=====================================================================
  task simultaneous_read_write_full_test();
    begin
      $display("\n----- SIMULTANEOUS R/W WHILE FULL TEST STARTED -----");
      
      reset_test();

      $display("Filling FIFO completely...");

      // Write FIFO to full
      write_en = 1;
      for (int i = 0; i < DEPTH ; i++) begin 
        data_in = i;
        #10;
      end

      write_en = 0;
      data_out_check = data_in; 
      #10;

      // Verify full flag
      if (!full) 
        $error("Simultaneous R/W Full Test: FIFO should be full");

      $display("Performing simultaneous R/W on FULL FIFO...");

      // Enable simultaneous read and write
      write_en = 1;
      read_en = 1;
      data_in = 16'h9ABC;
      #10;
      write_en = 0;
      #10;
        
      // overflow check
      if (!overflow) begin
        $error("Simultaneous R/W Full Test: Overflow should be triggered.");
        error_count++;
      end
        
      $display("Continuing R/W to test behavior after overflow…");

      write_en = 1;
      for (int k = 0; k < DEPTH+5; k++) begin
        #10;
        if (k == DEPTH-3 && data_out != data_out_check) begin 
          $error("Simultaneous R/W Full Test: Data should match saved value.");
          error_count++;
        end
        else if (k > DEPTH-3 && data_out != data_in) begin
          $error("Simultaneous R/W Full Test: Data must match continuous input.");
          error_count++;
        end
      end

      write_en = 0;
      read_en = 0;
        
      $display("----- SIMULTANEOUS R/W WHILE FULL TEST COMPLETED -----\n");
    end
  endtask
  

  //=====================================================================
  // Task: RESET GENERATION
  //=====================================================================
  task reset_test();
    $display("Applying RESET...");
    #10 reset_n=1'b0;
    #10 reset_n=1'b1;
    $display("RESET released.\n");
  endtask
  

  //=====================================================================
  // Task: FINAL ERROR SUMMARY
  //=====================================================================
  task error_counting();
    if (error_count == 0) begin
      $display("\n!!  All tests completed successfully  !!\n");
    end else begin
      $display("Test completed with %0d errors", error_count);
    end
  endtask
  
endclass