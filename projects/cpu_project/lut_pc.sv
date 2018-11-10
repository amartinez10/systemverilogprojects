// CSE141L Winter 2018
// in-class demo -- program counter lookup table
// tells PC what do do on an absolute or a relative jump/branch
module lut_pc(
  input[4:0] ptr,					  // lookup table's incoming address pointer
  output logic signed[7:0] dout);	  // goes to input port on PC

  always_comb case (ptr)
	5'b11001: dout = -8'd7;		          // Alias = -7 // String Match - jump -7 instructions
	5'b00010: dout = 8'd2;			  // Alias = 2 // String Match - jump 2 instructions
        5'b00011: dout = 8'd3;                    // Alias = 3 // Closest Pair - jump 3 instructions 
        5'b00100: dout = -8'd11;                  // Alias = 4 // Closest Pair - jump -11 instructions 
        5'b00101: dout = -8'd23;                  // Alias = 5 // Closest Pair - jump -23 instructions 
        5'b11000: dout = -8'd4;                  // Alias = -4 // product - jump -4 instructions   todo
        5'b10100: dout = 8'd20;                  // Alias = 20 // product - jump 20 instructions   todo
        5'b10001: dout = 8'd17;                  // Alias = 17 // product - jump 17 instructions   todo
        5'b00111: dout = 8'd7;                  // Alias = 7 // product - jump 7 instructions   todo
	default: dout = 8'd1;			  // default: PC advances to next value (PC+4 in ARM or MIPS)
  endcase

endmodule