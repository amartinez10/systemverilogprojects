// ALU for class demo
// CSE141L Win 2018
import definitions::*;              // declares ALU opcodes 
module alu (			         
  input             ci,			    // carry in
  input       [3:0] op,			    // opcode
  input signed      [1:0] in_imm,
  input       [7:0] in_a,		    // operands in
                    in_b,
                  in_acc,
  output logic[7:0] rslt,		    // result out
  output logic      co,			    // carry out
  output logic      z); 		    // zero flag, like ARM Z flag
  op_mne op_mnemonic;			    // type enum: used for convenient waveform viewing

  always_comb begin   
    /*begin
       if((op != kBNE) || (op != kBGT))
		 begin
          z = 1'b0;
		 end
		 elses
		 begin
		 end
    //end*/
    rslt  = 8'b0;
	 z     = 1'b0;
    case(op)						// selective override one or more defaults
      kLDR: rslt = in_b + 0;		    // load reg_file from data_mem
      kPULL: rslt = in_acc;  // pulls from accumulator
      kINCR: rslt = in_imm + $signed(in_b);	// increment in_a by in_b
      kSUB:  rslt = ((in_a - in_b)==0) ? 0 : 1;		// branch relative: if(in_a=0), set z flag=1
      //kSUB: rslt = in_b;
      kBNE: z = in_acc!=0;		        // branch lut: same test in ALU
      kSTOR: rslt = in_b;			// store in data_mem from reg_file
      //kHALT: rslt = 8'b1111_11_11;
      kADDI: rslt = ci + in_a + in_b;
      kADDZ: rslt = ci + 0 + in_b;
      kADDO: {co, rslt} = in_a + in_b;
      kBEQ: z = in_acc==0;
      kCLR: rslt = 0;
      kSUBA:
        begin
          if($signed(in_a) > $signed(in_b)) rslt = ($signed(in_a) - $signed(in_b));
          else if($signed(in_a) < $signed(in_b)) rslt = ($signed(in_b) - $signed(in_a));
          else rslt = 0;
        end
      kPUSH: rslt = in_b;
      kMIN:
        begin
          if(in_a <= in_b) rslt = in_a;
          else rslt = in_b;
        end
      kMATCH: 
        begin
          integer i;
          for(i=0; i<5; i=i+1)
	    begin
              if(((in_a << i) >> 4) == in_b) // check if string matches the 4 bits by shifts
                rslt = rslt + 1;                    
	      end
	       rslt = (rslt==0)? 1 : 0;
            end
     endcase
  end
  assign  op_mnemonic = op_mne'(op);  // creates ALU opcode mnemonics in timing diagram

endmodule