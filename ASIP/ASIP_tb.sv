/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Memory's testbench

module ASIP_tb ();
	
	/* Clock Signal */
	reg clk;

	// Device Under Test
	ASIP DUT (	clk );


	// The testbench values
	initial begin
	
		$display("Testbench for ASIP");
		
		clk = 1'b0;
		
		#100;
		
		$finish;
		
	end
	
	/* Toggle the clock */
	always begin
		#1 clk = ~clk;
	end

endmodule 