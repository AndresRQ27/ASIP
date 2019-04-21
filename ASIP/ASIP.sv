/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Top Module

`include "constants.sv"

module ASIP (a,b,c);


	input logic a,b;
	output logic c;
	
	assign c = a & b;
	
	

endmodule