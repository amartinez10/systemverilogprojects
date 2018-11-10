// CSE141L Winter 2018  
// in class demo -- instruction memory ROM
// This is the case statement (if ... else if ... else if ...) version;
//   good for small lookup tables and arrays, awkward for larger ones, perhaps

module imem(
	input	[7:0] PC,
	output logic[8:0] inst);
	always_comb case (PC)
                /* PRODUCT */
		0: inst = 'b0100_00_000;	// LOAD R0
		1: inst = 'b1011_10100;		// BEQ 20  
		2: inst = 'b0000_00_000;	// PULL R0
		3: inst = 'b0100_00_011;	// LOAD R3
		4: inst = 'b1011_10001;		// BEQ 17 
		5: inst = 'b0000_00_011;	// PULL R3
		6: inst = 'b1100_00_010;	// ADDO R0 R2
		7: inst = 'b1110_00_001;	// ADDZ 0 R1
		8: inst = 'b0001_01_101;	// INCR 1 R5
		9: inst = 'b0111_11_101;	// SUB R3 R5
		10: inst = 'b1000_11000;	// BNE -4  
		11: inst = 'b0001_11_100;	// INCR -1 R4
		12: inst = 'b0100_00_100;	// LOAD R4
		13: inst = 'b0001_01_100;	// INCR 1 R4
		14: inst = 'b1011_00111;	// BEQ 7
		15: inst = 'b0000_00_000;	// PULL R0  store c
                16: inst = 'b1001_00_101;	// CLEAR R5
		17: inst = 'b1100_10_111;	// ADDO R2 R7  todo
		18: inst = 'b1101_01_110;	// ADDI R1 R6  todo 
		19: inst = 'b0001_01_101;	// INCR 1 R5
		20: inst = 'b0111_00_101;	// SUB R0 R5
		21: inst = 'b1000_11000;	// BNE -4  
                22: inst = 'b0010_00_110;                               // PUSH R6
                23: inst = 'b0000_00_001;                                // PULL R1
		24: inst = 'b0101_01_100;	// STOR R1 R4
		25: inst = 'b0001_01_100;	// INCR 1 R4
                26: inst = 'b0010_00_111;                               // PUSH R7
                27: inst = 'b0000_00_010;                                 // PULL R2
		28: inst = 'b0101_10_100;	// STOR R2 R4
		29: inst = 'b1111_11_111;	// HALT
		//default: inst = 'b1111_11111;
                /* STRING MATCH */
  	        30: inst = 'b0100_00000;	// LOAD R0
		31: inst = 'b0000_00111;	// PULL R7
		32: inst = 'b0100_00101;	// LOAD R5
		33: inst = 'b0000_00000;	// PULL R0
		34: inst = 'b0011_00_111;	// MATCH R0 R7
		35: inst = 'b1000_00010;	// BNE 2
		36: inst = 'b0001_01_010;	// INCR 1 R2
		37: inst = 'b0001_01_101;	// INCR 1 R5
		38: inst = 'b0111_11_101;	// SUB R3 R5
		39: inst = 'b1000_11001;	// BNE -7
		40: inst = 'b0101_10_110;	// STOR R2 R6
		41: inst = 'b1111_11_111;	// HALT
		//default: inst = 'b1111_11111;
                /* CLOSEST PAIR */
                42: inst = 'b0100_00100;	// LOAD R4
		43: inst = 'b0000_00001;	// PULL R1
		44: inst = 'b0100_00101;	// LOAD R5
		45: inst = 'b0000_00000;	// PULL R0
		46: inst = 'b0110_00_001;	// SUBA R0 R1
		47: inst = 'b0000_00010;	// PULL R2
		48: inst = 'b1010_10_110;	// MIN R2 R6
		49: inst = 'b0000_00110;	// PULL R6
		50: inst = 'b0001_01_101;	// INCR 1 R5
		51: inst = 'b0100_00111;	// LOAD R7
		52: inst = 'b0000_00011;	// PULL R3
		53: inst = 'b0001_01_011;	// INCR 1 R3
		54: inst = 'b0111_11_101;	// SUB R3 R5
		55: inst = 'b1000_00100;	// BNE 4
		56: inst = 'b0001_01_100;	// INCR 1 R4
		57: inst = 'b0010_00100;	// PUSH R4
		58: inst = 'b0000_00101;	// PULL R5
		59: inst = 'b0001_01_101;	// INCR 1 R5
		60: inst = 'b0001_01_111;	// INCR 1 R7
		61: inst = 'b0100_00111;	// LOAD R7
		62: inst = 'b0000_00011;	// PULL R3
		63: inst = 'b0001_11_111;	// INCR -1 R7
		64: inst = 'b0111_11_100;	// SUB R3 R4
		65: inst = 'b1000_00101;	// BNE 5
		66: inst = 'b0010_00110;	// PUSH R6
		67: inst = 'b0000_00000;	// PULL R0
		68: inst = 'b0001_01_111;	// INCR 1 R7
		69: inst = 'b0001_01_111;	// INCR 1 R7
		70: inst = 'b0100_00111;	// LOAD R7
		71: inst = 'b0000_00001;	// PULL R1
		72: inst = 'b0101_00_001;	// STOR R0 R1
		73: inst = 'b1111_11_111;	// HALT
		default: inst = 'b1111_11111;
	endcase
endmodule
/*module imem(
  input       [7:0] PC,      // program counter = pointer to imem
  output logic[8:0] inst);	 // machine code values (yours are 9 bits; my demo is only 7)
  always_comb case(PC)
     		0: inst = 'b0100_00000;	// LOAD R0
		1: inst = 'b0000_00111;	// PULL R7
		2: inst = 'b0100_00101;	// LOAD R5
		3: inst = 'b0000_00000;	// PULL R0
		4: inst = 'b0011_00_111;	// MATCH R0 R7
		5: inst = 'b1000_00010;	// BNE 2
		6: inst = 'b0001_01_010;	// INCR 1 R2
		7: inst = 'b0001_01_101;	// INCR 1 R5
		8: inst = 'b0111_11_101;	// SUB R3 R5
		9: inst = 'b1000_11001;	// BNE -7
		10: inst = 'b0101_10_110;	// STOR R2 R6
		11: inst = 'b1111_11_111;	// HALT
		default: inst = 'b1111_11111;
  endcase
endmodule*/

/*module imem(
	input	[7:0] PC,
	output logic[8:0] inst);
	always_comb case (PC)
		0: inst = 'b0100_00100;	// LOAD R4
		1: inst = 'b0000_00001;	// PULL R1
		2: inst = 'b0100_00101;	// LOAD R5
		3: inst = 'b0000_00000;	// PULL R0
		4: inst = 'b0110_00_001;	// SUBA R0 R1
		5: inst = 'b0000_00010;	// PULL R2
		6: inst = 'b1010_10_110;	// MIN R2 R6
		7: inst = 'b0000_00110;	// PULL R6
		8: inst = 'b0001_01_101;	// INCR 1 R5
		9: inst = 'b0100_00111;	// LOAD R7
		10: inst = 'b0000_00011;	// PULL R3
		11: inst = 'b0001_01_011;	// INCR 1 R3
		12: inst = 'b0111_11_101;	// SUB R3 R5
		13: inst = 'b1000_00100;	// BNE 4
		14: inst = 'b0001_01_100;	// INCR 1 R4
		15: inst = 'b0010_00100;	// PUSH R4
		16: inst = 'b0000_00101;	// PULL R5
		17: inst = 'b0001_01_101;	// INCR 1 R5
		18: inst = 'b0001_01_111;	// INCR 1 R7
		19: inst = 'b0100_00111;	// LOAD R7
		20: inst = 'b0000_00011;	// PULL R3
		21: inst = 'b0001_11_111;	// INCR -1 R7
		22: inst = 'b0111_11_100;	// SUB R3 R4
		23: inst = 'b1000_00101;	// BNE 5
		24: inst = 'b0010_00110;	// PUSH R6
		25: inst = 'b0000_00000;	// PULL R0
		26: inst = 'b0001_01_111;	// INCR 1 R7
		27: inst = 'b0001_01_111;	// INCR 1 R7
		28: inst = 'b0100_00111;	// LOAD R7
		29: inst = 'b0000_00001;	// PULL R1
		30: inst = 'b0101_00_001;	// STOR R0 R1
		31: inst = 'b1111_11_111;	// HALT
		default: inst = 'b1111_11111;
	endcase
endmodule*/

/*
LOAD R0    //ACC = M[6]
PULL R7    //R7 = ACC
Loop:
LOAD R5 // ACC = M[32]
PULL R0 // R0 = ACC
MATCH R0, R7
BNE 2
INCR R6 1
INCR R5 1
SUB R3 R5
BNE -7
STOR R2 R6
HALT


LOAD  0100
PULL  0000
INCR  0001
MOV  0010
SUBA 0110
SUB   0111
BGT   1001
BNE  1000
STOR  0101 
HALT   1111
MATCH 0011*/

