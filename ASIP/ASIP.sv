/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Top Module

module ASIP ( clk );

	// constants
	parameter ALUSize =  32; // size of the operands in bits that can handle the ALU
	parameter RegisterSize =  32; // register's size in bits
	parameter AmountOfRegisters =  16; // quantity of registers in the processor
	parameter ImageWidth =  320; // Canvas size
	parameter ImageHeight =  240; // Canvas size
	parameter ColorBits =  3; // Code of 3 bits => 8 colors
	parameter PCSize =  32; // Equal to register size
	parameter InstructionSize =  32; // Instruction size in bits
	parameter AmountOfInstructions =  128; // Memory size in terms of amount of instructions
	
		// Inputs
	input logic clk;
	
	
	// SubModules
	
	// ALU
	wire [3:0] Control;
	wire[ALUSize-1:0] A,B,C,Result;
	wire[3:0] Flags;
	
	// Registers
	wire reset;
	wire [3:0] MOVRegisterOrigin;
	wire [3:0] MOVRegisterDestiny;
	wire [3:0] writeRegister;
	wire [RegisterSize-1:0] writeValue;
	wire [3:0] readRegister;
	wire [RegisterSize-1:0] PC_Read;
	wire [RegisterSize-1:0] readValue;
	
	// Memory
	wire [9-1:0] XWrite;
	wire [8-1:0] YWrite;
	wire [ColorBits-1:0] writeValueMemory;
	
	wire [9-1:0] XRead;
	wire [8-1:0] YRead;
	wire [ColorBits-1:0] readValueMemory;
	
	// Instruction Memory
	wire [PCSize-1:0] PC_Get;
	wire [InstructionSize-1:0] Instruction;

	
	// Devices
	ALU 							#( ALUSize ) 
	ALUDevice 					( A, B, C, 	Control, Result, Flags );
	Registers 					#(	RegisterSize, AmountOfRegisters ) 
	RegistersDevice 			( clk, reset, PC_Read, MOVRegisterOrigin, MOVRegisterDestiny, writeRegister, writeValue, readRegister, readValue );
	Memory 						#(	ImageWidth, ImageHeight, ColorBits ) 
	MemoryDevice 				(	clk, 
										XWrite, YWrite, writeValueMemory,
										XRead, YRead, readValueMemory );
	InstructionMemory 		#(	PCSize, InstructionSize, AmountOfInstructions) 
	InstructionMemoryDevice	(	PC_Get, Instruction );
	VGA #( ColorBits )
	VGADevice(	
		.clk(clk), 
		.readValueMemory(readValueMemory),
		.hsync(hsync), 
		.vsync(vsync), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.blank(blank), 
		.clkVGA(clkVGA)
	);
	
	// Main Core
	CPU #(	ALUSize,
					RegisterSize,
					AmountOfRegisters,
					ImageWidth,
					ImageHeight,
					ColorBits,
					PCSize,
					InstructionSize,
					AmountOfInstructions) 
	core		( 	clk, 
					Control, A,B,C,Result, Flags,
					reset, MOVRegisterOrigin, MOVRegisterDestiny, writeRegister, writeValue, readRegister, PC_Read, readValue,
					XWrite, YWrite, writeValueMemory, XRead, YRead, readValueMemory,
					PC_Get, Instruction );
	
	initial begin
		
		
	end

	always @(clk) begin
		
	end

endmodule