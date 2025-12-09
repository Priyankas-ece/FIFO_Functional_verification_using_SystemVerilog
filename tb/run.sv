//-------------------------------------------------------------
// File      : run_tb.sv
// Author    : Priyanka S
// Description: Master controller class for executing all TB tasks
//-------------------------------------------------------------

//===============================================================
// CLASS TO RUN ALL TASKS
//===============================================================

class run_tb;

  // Object creation for condition test class
  condition_test cth = new();

  //=============================================================
  // Task: run_code
  // Description:
  //   - Central execution point of the testbench flow
  //   - Calls all functionality tests sequentially
  //   - Adds useful logs for readability
  //=============================================================
  task run_code();
    $display("\n===============================================================");
    $display("                 RUN TB : Starting Testbench Execution         ");
    $display("===============================================================\n");

    // Call all condition-based tests
    $display("[RUN_TB] --> Calling condition tests...");
    cth.calling();
    $display("[RUN_TB] --> Condition tests completed.\n");

    $display("==================================================================");
    $display("[End Time = %0t]        All tasks called successfully!          ",$time);
    $display("==================================================================\n");
  endtask

endclass