// CSE141L Win 2018  in-class demo
// 4-element reg_file (yours will have up to 16 elements)
module rf(
  input             clk,
  input  [7:0]      di,				// data to load into reg_file
  input             we,		            // write enable
  input  [3:0]      ptr_w,               // address to write to
  input  [1:0]      ptr_a,               // 2 addresses to read from
  input  [2:0]      ptr_b,

  output logic[7:0] do_a,   		 // 2 data values to be read from reg_file
                    do_b,
		    do_acc);

  logic  [7:0] core[9];				    // our reg_file itself -- 8x4 2-dimensional array
  always_ff @(posedge clk) if(we)		// write only on posedge clock and only if we=1
	core[ptr_w] <= di;

  always_comb do_a = core[ptr_a];		// reads are continuous/combinational instead of 
  always_comb do_b = core[ptr_b];       //   clocked/sequential
  always_comb do_acc = core[8];

endmodule