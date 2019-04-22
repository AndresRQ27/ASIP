/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Top Module

module CPU #(	parameter ALUSize =  32,
					parameter RegisterSize =  32,
					parameter AmountOfRegisters =  16,
					parameter ImageWidth =  10,
					parameter ImageHeight =  5,
					parameter ColorBits =  3,
					parameter PCSize =  32,
					parameter InstructionSize =  32,
					parameter AmountOfInstructions =  128) 
				( 	clk, 
					Control, A,B,C,Result, Flags,
					reset, MOVRegisterOrigin, MOVRegisterDestiny, writeRegister, writeValue, readRegister, PC_Read, readValue,
					XWrite, YWrite, writeValueMemory, XRead, YRead, readValueMemory,
					PC_Get, Instruction );

	
	
	// Inputs by Group
	input logic clk;
	// ALU
	output logic [3:0] Control;
	output logic [ALUSize-1:0] A,B,C;
	input logic [ALUSize-1:0] Result;
	input logic [3:0] Flags;
	// Registers
	output logic reset;
	output logic [3:0] MOVRegisterOrigin;
	output logic [3:0] MOVRegisterDestiny;
	output logic [3:0] writeRegister;
	output logic [RegisterSize-1:0] writeValue;
	output logic [3:0] readRegister;
	input logic [RegisterSize-1:0] PC_Read;
	input logic [RegisterSize-1:0] readValue;
	// Memory
	output logic [9-1:0] XWrite;
	output logic [8-1:0] YWrite;
	output logic [ColorBits-1:0] writeValueMemory;
	output logic [9-1:0] XRead;
	output logic [8-1:0] YRead;
	input logic [ColorBits-1:0] readValueMemory;
	//Instruction Memory
	output logic [PCSize-1:0] PC_Get;
	input logic [InstructionSize-1:0] Instruction;
	
	
	
	
	// CPU auxiliar
	logic [PCSize-1:0] PC;
	logic [3:0] InstructionId;
	
	// SUB
	logic [2:0] SUB_State;
	logic [RegisterSize-1:0] Op1;
	logic [RegisterSize-1:0] Op2;
	//logic [RegisterSize-1:0] Result;
	
	
	// CANVAS
	logic [ColorBits-1:0] COLOR;
	
	
	
	initial begin
		
		// First run
		PC = 0;
		InstructionId = 0;
		SUB_State = 0;
		COLOR = 3'b101;
		
		PC_Get = PC;
		
	end

	always @(clk) begin
		
		PC_Get = PC;
		InstructionId = Instruction[31:28];
		
		if (InstructionId == 4'b0000) begin // MOV instruction
		
				MOVRegisterOrigin = Instruction[23:20];
				MOVRegisterDestiny = Instruction[27:24];
				
				PC = PC + 4;
		
		end else if (InstructionId == 4'b0001) begin // SUBS instruction
				
				if (Instruction[0] == 1'b0) begin // SUBS from Register
					
					if (SUB_State == 3'b000) begin
						// Get value from OP1
						readRegister = Instruction[23:20];
					 
						SUB_State = SUB_State + 1;
					 
					end else if (SUB_State == 3'b001) begin
						
						readRegister = Instruction[19:16];
						
						SUB_State = SUB_State + 1;
					
					end else if (SUB_State == 3'b010) begin
						Op1 = readValue;
						
						SUB_State = SUB_State + 1;
					
					end else if (SUB_State == 3'b011) begin
						Op2 = readValue;
						
						A = Op1;
						B = Op2;
						Control = 4'b0010;
						
						SUB_State = SUB_State + 1;
					
					end else if (SUB_State == 3'b100) begin
						writeRegister = Instruction[27:24];
						writeValue = Result; 
						
						
						SUB_State = 0;
						PC = PC + 4;
					
					end else begin
						SUB_State = 0;
						
						
						
					end
					
				end else begin // SUBS from Inmediate
					PC = PC;
				end

		end else if (InstructionId == 4'b0100) begin // ADDS instruction
				
				if (Instruction[0] == 1'b0) begin // SUBS from Register
					
					if (SUB_State == 3'b000) begin
						// Get value from OP1
						readRegister = Instruction[23:20];
					 
						SUB_State = SUB_State + 1;
					 
					end else if (SUB_State == 3'b001) begin
						
						readRegister = Instruction[19:16];
						
						SUB_State = SUB_State + 1;
					
					end else if (SUB_State == 3'b010) begin
						Op1 = readValue;
						
						SUB_State = SUB_State + 1;
					
					end else if (SUB_State == 3'b011) begin
						Op2 = readValue;
						
						A = Op1;
						B = Op2;
						Control = 4'b0100;
						
						SUB_State = SUB_State + 1;
					
					end else if (SUB_State == 3'b100) begin
						writeRegister = Instruction[27:24];
						writeValue = Result; 
						
						
						SUB_State = 0;
						PC = PC + 4;
					
					end else begin
						SUB_State = 0;
						
						
						
					end
					
				end else begin // SUBS from Inmediate
					PC = PC;
				end

		end else if (InstructionId == 4'b1001) begin // PLOT instruction
				XWrite = Instruction[27:19];
				YWrite = Instruction[18:11];
				writeValueMemory = COLOR;
				PC = PC + 4;

		end else if (InstructionId == 4'b1000) begin // COL instruction
				COLOR = Instruction[27:25];
				PC = PC + 4;

		end else begin
			PC = PC;
		end
		
		// Reset flags
		if (InstructionId != 4'b0001 && InstructionId != 4'b0100) begin
			SUB_State = 0;
		end
		
	end

endmodule