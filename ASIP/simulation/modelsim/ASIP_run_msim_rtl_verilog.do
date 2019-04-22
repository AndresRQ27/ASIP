transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP {C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP/ALU.sv}
vlog -sv -work work +incdir+C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP {C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP/ALUAdderCarry.sv}
vlog -sv -work work +incdir+C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP {C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP/ASIP.sv}
vlog -sv -work work +incdir+C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP {C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP/Registers.sv}
vlog -sv -work work +incdir+C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP {C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP/Memory.sv}
vlog -sv -work work +incdir+C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP {C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP/CPU.sv}
vlog -sv -work work +incdir+C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP {C:/Users/ebsadmin/Desktop/TEC/ASIP-Repository/ASIP/InstructionMemory.sv}

