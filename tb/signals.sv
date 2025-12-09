//=====================================================================
//  FIFO PARAMETERS
//=====================================================================

// DATA_WIDTH  : Number of bits per data word
// DEPTH       : Total number of entries in FIFO
// ADDR_WIDTH  : Number of address bits required to index DEPTH entries
parameter DATA_WIDTH = 16;
parameter DEPTH      = 8;
parameter ADDR_WIDTH = 3;


//=====================================================================
//  INPUT / OUTPUT SIGNAL DECLARATIONS
//=====================================================================

//---------------------------
// Clock & Reset Signals
//---------------------------
logic clk;             // System clock
logic reset_n;         // Active-low synchronous reset


//---------------------------
// Control Signals
//---------------------------
logic write_en;        // Write enable signal
logic read_en;         // Read enable signal


//---------------------------
// Data Signals
//---------------------------
logic [DATA_WIDTH-1:0] data_in;        // Input data to FIFO
logic [DATA_WIDTH-1:0] data_out;       // Output data from FIFO
logic [DATA_WIDTH-1:0] data_out_check; // Expected data (used for TB verification)


//---------------------------
// FIFO Status Flags
//---------------------------
logic full;            // FIFO is completely full
logic empty;           // FIFO is completely empty
logic almost_full;     // FIFO is nearly full
logic almost_empty;    // FIFO is nearly empty
logic overflow;        // Write attempted when FIFO is full
logic underflow;       // Read attempted when FIFO is empty


//=====================================================================
//  TESTBENCH VARIABLES
//=====================================================================

// Tracks the number of mismatches found between data_out and data_out_check
int error_count;