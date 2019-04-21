/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

module ALUAdderCarry #(parameter ALUSize = 32) (a, b, Cin, s, Cout);
	
	// Inputs and outputs
	input logic [ALUSize-1:0] a, b;
	input logic Cin;
	output logic [ALUSize-1:0] s;
	output logic Cout;
							
	assign {Cout, s} = a + b + Cin;

endmodule