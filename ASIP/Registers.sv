/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// This module handles the processor registers
// Are 15 + PC based on the ARM Architecture

module Registers #(	parameter RegisterSize = 32, 
							parameter AmountOfRegisters = 16)
						(	clk, reset, pc, writeRegister, writeValue, readRegister, readValue);
	
	// Inputs and outputs
	input logic clk, reset;
	input logic [3:0] writeRegister;
	input logic [RegisterSize-1:0] writeValue;
	input logic [3:0] readRegister;
	
	output logic [RegisterSize-1:0] pc;
	output logic [RegisterSize-1:0] readValue;
	
	// Auxiliar for initialization
	integer initCount;
	
	// Module Data
	reg [RegisterSize-1:0] RegisterBank [AmountOfRegisters-1:0];	//16 registers, 32 bits each of it
	
	// Run once at initialization
	initial begin
		
		// Set each register in 0
		for (initCount = 0; initCount < AmountOfRegisters; initCount = initCount + 1) begin
			RegisterBank[initCount] = 0;
		end
	end	
	
	always @(posedge clk) begin
		
		// reset signal 1 sets all the registers in 0, except pc
		if(reset) begin
			// Set each register in 0
			for (initCount = 0; initCount < AmountOfRegisters-1; initCount = initCount + 1) begin
				RegisterBank[initCount] = 0;
			end
		end
		
		// Write Process
		RegisterBank[writeRegister] <= writeValue;
		
		// Read Process
		readValue <= RegisterBank[readRegister];
	
	end
	
	// The PC output will always be connected to the last register
	assign pc = RegisterBank[AmountOfRegisters-1];
	
	
endmodule