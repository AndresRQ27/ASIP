/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// ALU's testbench

module ALU_tb ();

parameter bits = 4;

// Internal Logic
logic [3:0] Control;
logic [bits-1:0] A,B,C,Result;
logic [3:0] Flags;

// Device Under Test
ALU #(bits) DUT (A,B,C,Control, Result, Flags);


initial 
	begin
	
		$display("Testbench para Sumador");
		Control = 4'b0100; A = 4'b0001; B = 4'b1110; 
		#10;
		assert (Result === 4'b1111) $display("Test OK"); else $error("Test Failed");
		assert (Flags[2] === 0) $display("Test OK"); else $error("Test Failed");
		assert (Flags[3] === 1) $display("Test OK"); else $error("Test Failed");
		assert (Flags[1] === 0) $display("Test OK"); else $error("Test Failed");
		assert (Flags[0] === 0) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0100; A = 4'b0000; B = 4'b0000; 
		#10;
		assert (Result === 4'b0000) $display("Test OK"); else $error("Test Failed");
		assert (Flags[2] === 1) $display("Test OK"); else $error("Test Failed");
		assert (Flags[3] === 0) $display("Test OK"); else $error("Test Failed");
		assert (Flags[0] === 0) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0100; A = 4'b0001; B = 4'b1111; 
		#10;
		assert (Result === 4'b0000) $display("Test OK"); else $error("Test Failed");
		assert (Flags[2] === 1) $display("Test OK"); else $error("Test Failed");
		assert (Flags[3] === 0) $display("Test OK"); else $error("Test Failed");
		assert (Flags[1] === 1) $display("Test OK"); else $error("Test Failed");
		assert (Flags[0] === 0) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0100; A = 4'b0100; B = 4'b0101; 
		#10;
		assert (Result === 4'b1001) $display("Test OK"); else $error("Test Failed");
		assert (Flags[2] === 0) $display("Test OK"); else $error("Test Failed");
		assert (Flags[3] === 1) $display("Test OK"); else $error("Test Failed");
		assert (Flags[1] === 0) $display("Test OK"); else $error("Test Failed");
		assert (Flags[0] === 1) $display("Test OK"); else $error("Test Failed");
		#10;
		
		$display("Testbench para Restador");
		Control = 4'b0010; A = 4'b0010; B = 4'b0001; 
		#10;
		assert (Result === 4'b0001) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0010; A = 4'b0000; B = 4'b1101; 
		#10;
		assert (Result === 4'b0011) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0010; A = 4'b0111; B = 4'b0010; 
		#10;
		assert (Result === 4'b0101) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0010; A = 4'b0100; B = 4'b0010; 
		#10;
		assert (Result === 4'b0010) $display("Test OK"); else $error("Test Failed");
		#10;
		
		$display("Testbench para AND");
		Control = 4'b0000; A = 4'b0100; B = 4'b0010; 
		#10;
		assert (Result === 4'b0000) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0000; A = 4'b0110; B = 4'b0010; 
		#10;
		assert (Result === 4'b0010) $display("Test OK"); else $error("Test Failed");
		#10;
		
		$display("Testbench para OR");
		Control = 4'b1100; A = 4'b0001; B = 4'b1110;
		#10;
		assert (Result === 4'b1111) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b1100; A = 4'b1001; B = 4'b0101; 
		#10;
		assert (Result === 4'b1101) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b1100; A = 4'b0111; B = 4'b0100;
		#10;
		assert (Result === 4'b0111) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b1100; A = 4'b0011; B = 4'b0011; 
		#10;
		assert (Result === 4'b0011) $display("Test OK"); else $error("Test Failed");
		#10;
	
		$display("Testbench para NOT");
		Control = 4'b1111; B = 4'b0001;
		#10;
		assert (Result === 4'b1110) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b1111; B = 4'b1001; 
		#10;
		assert (Result === 4'b0110) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b1111; B = 4'b0111;
		#10;
		assert (Result === 4'b1000) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b1111; B = 4'b0011;
		#10;
		assert (Result === 4'b1100) $display("Test OK"); else $error("Test Failed");
		#10;
		
		$display("Testbench para XOR");
		Control = 4'b0001; A = 4'b0001; B = 4'b1110;
		#10;
		assert (Result === 4'b1111) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0001; A = 4'b1001; B = 4'b0101; 
		#10;
		assert (Result === 4'b1100) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0001; A = 4'b0111; B = 4'b0100;
		#10;
		assert (Result === 4'b0011) $display("Test OK"); else $error("Test Failed");
		#10;
		Control = 4'b0001; A = 4'b0011; B = 4'b0011; 
		#10;
		assert (Result === 4'b0000) $display("Test OK"); else $error("Test Failed");
		#10;
		
	end

endmodule 