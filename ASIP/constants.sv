/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/


// This file will be included in the other system verilog components
// will allow the change of the processor parameters easily

`define ALUSize 32 // size of the operands in bits that can handle the ALU
`define RegisterSize 32 // register's size in bits
`define AmountOfRegisters 16 // quantity of registers in the processor
`define ImageWidth 10 // Canvas size
`define ImageHeigth 5 // Canvas size
`define ColorBits 3 // Code of 3 bits => 8 colors
`define PCSize 32 // Equal to register size
`define InstructionSize 32 // Instruction size in bits
`define AmountOfInstructions 128 // Memory size in terms of amount of instructions