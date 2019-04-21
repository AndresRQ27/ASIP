/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// This module handles the computation of arithmetic and logical operations
// Based on the chapter 5.2.4 on Digital Design and Computer Architecture Arm Edition Book

module ALU #(parameter ALUSize = 32) (A, B, C, ALUControl, Y, ALUFlags);
	
	// Inputs and outputs
	input logic [ALUSize-1:0] A, B, C;
	input logic [3:0] ALUControl;
	output logic [ALUSize-1:0] Y;
	output logic [3:0] ALUFlags;
	
				 
	logic [ALUSize-1:0] Sum, N, UP, PP;
	logic Cout;

	assign N = ALUControl[1] ? ~B : B;

	ALUAdderCarry #(ALUSize) adderCarry (A, N, ALUControl[1], Sum, Cout);

	always_comb 
		case (ALUControl)
			4'b0000:	Y = A & B;			//AND
			4'b0001:	Y = A ^ B;			//EOR
			4'b0010:	Y = Sum;				//SUB
			4'b0011:	Y = B - A;			//RSB
			4'b0100:	Y = Sum;				//ADD
			4'b0101:	Y = Sum + C;		//ADC
			4'b0110:	Y = Sum + C - 1;	//SBC
			4'b0111:	Y = B - A + C - 1;//RSC
			4'b1000:	Y = A * B;			//MP
			4'b1001:	Y = UP;				//UP
			4'b1010:	Y = Sum;				//CMP
			4'b1011:	Y = Sum;				//CMN
			4'b1100:	Y = A | B;			//ORR
			4'b1101:	Y = PP;				//PP
			4'b1110:	Y = A * B;			//MUL
			4'b1111:	Y = ~B;				//MVN
			default:	Y = 32'bx;			//Unimplemented
		endcase

	// Overflow
	assign ALUFlags[0] = (ALUControl[0] ^ A[ALUSize-1] ^ ~B[ALUSize-1]) & (A[ALUSize-1] ^ Sum[ALUSize-1]) & (~ALUControl[1]);

	// Carry
	assign ALUFlags[1] = ~ALUControl[1] & Cout;

	// Zero
	assign ALUFlags[2] = &(~Y);
	
	// Negative
	assign ALUFlags[3] = Y[ALUSize-1];

endmodule