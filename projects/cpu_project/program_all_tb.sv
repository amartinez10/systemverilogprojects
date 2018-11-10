// Master Testbench -- runs all three programs in succession
// Winter 2018   CSE141L
module program_all_tb();
  logic       clk,
              reset,		// to your DUT
              init = 1;
  wire        done;		// from your DUT
  logic[15:0] p;		// product computed by test bench
  //program_all pa1(.*);		// personalize to your design
  top strm(.*);
  logic[7:0]  a, b, c;          // program 1 mpy operands
  logic[7:0] dat_ram[256];	// test bench data ram (not yours)
  bit[7:0]   ct;		// program 2 where's Waldo count
  logic signed[ 8:0] dist1,	// program 3 distances
                     dist2;
  logic       [ 7:0] ct3;       // program 3 pair counter (190 unique pairs)
  int  seed  = 14;		// change to vary "random" operands
  //  logic[7:0] test;
  
  initial begin
        reset = 1;
    #20ns reset = 0;
  // initialize multiplication with operands
    	a               =  5;		// randomize or change to other values 
	b               = 15;
	c               =  2;
	/*pa1.data_ram_all[1] =  a;	// initialize DUT data memory
	pa1.data_ram_all[2] =  b;	// personalize these path names
	pa1.data_ram_all[3] =  c;	// to your design
	*/

        strm.dm1.guts[1] = a;
        strm.dm1.guts[2] = b;
        strm.dm1.guts[3] = c;
        strm.rf1.core[0] = 8'd1;
        strm.rf1.core[1] = 8'd0;
        strm.rf1.core[2] = 8'd0;
        strm.rf1.core[3] = 8'd2;
        strm.rf1.core[4] = 8'd4;
        strm.rf1.core[5] = 8'd0;
        strm.rf1.core[6] = 8'd0;
        strm.rf1.core[7] = 8'd0;

	// compute what the product should be
	// under Verilog rules, only the lower 16 bits will be retained
    	$display("program 1 -- multiply three 8-bit numbers");
    	$display(); 
	$display(" %d*%d*%d",a,b,c);
	p = a*b*c;
		#20ns init = 0;
	    wait(done);					        
	
	// diagnostics: compare a*b*c against what the DUT computes 
	// now initialize "where's Waldo?" pattern search     
	//pa1.data_ram_all[6] = 4'b1101;        // Waldo himself -- vary to test
    	strm.dm1.guts[6] = 4'b1101;
        strm.rf1.core[0] = 8'd6;
        strm.rf1.core[5] = 8'd32;
        strm.rf1.core[2] = 8'd0;
        strm.rf1.core[6] = 8'd7;
        strm.rf1.core[3] = 8'd96;
        
        //$display("pattern = %b",pa1.data_ram_all[6][3:0]);
    	$display("patter = %b", strm.dm1.guts[6][3:0]);
        $display();
	//dat_ram[6]          = pa1.data_ram_all[6];
	dat_ram[6] = strm.dm1.guts[6];
        for(int i=32; i<96; i++) begin  :op_ld_loop
	  //pa1.data_ram_all[i] = $random;
	  strm.dm1.guts[i] = $random;
          //dat_ram[i] = pa1.data_ram_all[i];
      	  dat_ram[i] = strm.dm1.guts[i];
          if(dat_ram[i][3:0]==dat_ram[6] ||
         	dat_ram[i][4:1]==dat_ram[6] ||
         	dat_ram[i][5:2]==dat_ram[6] ||
         	dat_ram[i][6:3]==dat_ram[6] ||
         	dat_ram[i][7:4]==dat_ram[6])
		 begin
           		ct++;
			//$display("bench",,,ct,,,i);      
	     	end
	end	   : op_ld_loop
	#20ns init = 0;
	    wait(done);

  // initialize third program
  dist1 = 255;		// reduce for each new smaller distance
  dist2 = 255;		// hold previous smallest distance
  ct3   =   0;

  strm.rf1.core[4] = 8'd128;
  strm.rf1.core[5] = 8'd129;
  strm.rf1.core[6] = 8'd255;
  strm.rf1.core[7] = 8'd124;

  strm.dm1.guts[124] = 8'd147;
  strm.dm1.guts[125] = 8'd147;
  strm.dm1.guts[126] = 8'd127;

  // test   = $random(seed);
  // $display("test = %d",test);
  for(int i=128;i<148;i++) begin
  	dat_ram[i]        =  $random(seed);     // feel free to vary seed
	//pa1.data_ram_all[i] =  dat_ram[i];
	strm.dm1.guts[i] = dat_ram[i];
        // $display(i,,dat_ram[i]);
  end
  for(int k=128; k<148; k++)			// nested loops to cover all
  	for(int j=128; j<k; j++) begin		//  pairs
		ct3++;
		if(k!=j) dist1 = dat_ram[k]-dat_ram[j];		// k!=j to avoid diagonal (element distance from self)
		// need abs(dist1)
		if(dist1[8]) dist1 = dat_ram[j]-dat_ram[k];
		// $display(dist2,,,dist1,,,k,,,j,,,dat_ram[k],,,dat_ram[j],,,ct);
		if(dist1<dist2) begin
			$display("dist1=%d, dist2=%d, %d, %d",dist1,dist2,dat_ram[j],dat_ram[k]);
		  	dist2 = dist1;					        // set a new minimum
		end
		// $display("bench",,,ct,,,i);      
	  end
  
  #10ns init = 1; 	// launch series of 3 programs
  #20ns init = 0;
  wait(done);		// DUT has finished all 3

  // now display results from all 3 programs in succession
  $display();	// display results of mpy
  // display results of first program
  $display ("math prod = %d; DUT prod = %d",p, {strm.dm1.guts[4], strm.dm1.guts[5]}/*{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]}*/);
  if(p=={strm.dm1.guts[4],strm.dm1.guts[5]}/*{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]}*/) $display("program 1 success");
  else $display("program 1 failure");
  //    $displayh("prod=0x%h 0x%h",p,{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]});
  //    $display();
  //    $display("cycle_count = %d",pa1.pr1.cycle_ct);
  $display("\n \n");
  $display("program 2 -- pattern search");
  $display();
  #10ns;

  // display results of second program
  $display("math match count = %d; DUT count = %d",ct,strm.dm1.guts[7]/*pa1.pr2.data_ram[7]*/);
  if(ct==strm.dm1.guts[7]/*pa1.pr2.data_ram[7]*/) $display("program 2 success");
  else $display("program 2 failure");
  $display("\n \n");
  $display("program 3 -- minimum pair distance");
  $display();
  
  // display results of third program
  #20ns $display("math dist = %d, DUT dist = %d",dist2,strm.dm1.guts[127]/*pa1.pr3.data_ram1[127]*/);
  if(dist2==strm.dm1.guts[127]/*pa1.pr3.data_ram1[127]*/) $display("program 3 success");
  else $display("program 3 failure");
  $display("\n \n");
  #10ns;

  /*
  // start a second round of problems -- we can/should randomize in future runs
	a = 12;
	b = 3;
	c = 4;
	pa1.pr1.data_ram[1] =  a;
	pa1.pr1.data_ram[2] =  b;
	pa1.pr1.data_ram[3] =  c;
	init = 1;
	$display(" %d*%d*%d",a,b,c);
	p = a * b * c;
	#20ns init = 0;
    	wait(done);
	$display("prod= %d  %d",p,{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]});
    	$displayh("prod=0x%h 0x%h",p,{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]});
    	$display("cycle_count = %d",pa1.pr1.cycle_ct);	 */

    $stop;	 
  end
   
  // irrespective of what you read in textbooks and online, this is the preferred clock syntax
  always begin
  #5ns clk = 1;
  #5ns clk = 0;

  end

endmodule