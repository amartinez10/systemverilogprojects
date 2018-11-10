//This file defines the parameters used in the alu
// CSE141L Win 2018 in-class demo
package definitions;
    
// Instruction map
    const logic [3:0]kLDR  = 4'b0100;      // LOAD
    //const logic [3:0]kCLR  = 3'b001;	  // clear ALU output
    const logic [3:0]kPULL  = 4'b0000;	  // PULL from ACC
    const logic [3:0]kINCR  = 4'b0001;	  // increment A
    //const logic [3:0]kMOV  = 4'b;	  // set z flag if A=0
    const logic [3:0]kSUB  = 4'b0111;	  // subtract A - B
    const logic [3:0]kBNE  = 4'b1000;	  // Branch, ACC not equal to 0
    const logic [3:0]kSTOR  = 4'b0101;	  // Store A
    const logic [3:0]kHALT  = 4'b1111;	  // Halts program
    const logic [3:0]kMATCH  = 4'b0011;	  // Mathces two register to check if equal
    const logic [3:0]kSUBA = 4'b0110; // subtract absolute
    const logic [3:0]kPUSH = 4'b0010; // PUSH into ACC
    const logic [3:0]kMIN = 4'b1010; // signed subtraction
    const logic [3:0]kADDI = 4'b1101;  //add with cin 
    const logic [3:0]kADDO = 4'b1100; //add to produce cout
    const logic [3:0]kADDZ = 4'b1110;  //add a zero and cin
    const logic [3:0]kBEQ = 4'b1011;  //branch if acc equals 0
    const logic [3:0]kCLR = 4'b1001;  //Clear the register
    
// enum names will appear in timing diagram
    typedef enum logic[3:0] {			  // mnemonic equivs of the above
        LDR, PULL, INCR, SUB, BNE,STOR, HALT, MATCH, SUBA, PUSH, MIN, ADDI, ADDO, ADDZ, BEQ, CLR // strictly for user convnience in timing diagram
         } op_mne;
    
endpackage // definitions
