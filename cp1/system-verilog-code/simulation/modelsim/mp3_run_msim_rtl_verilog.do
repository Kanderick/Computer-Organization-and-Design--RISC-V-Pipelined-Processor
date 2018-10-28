transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/WB_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/WB_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/rv32i_types.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/regfile.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/pipe_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/pc_reg.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/mux8.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/mux4.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/mux2.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/MEM_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/MEM_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/ID_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/EX_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/add4.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/rdata_out_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/IF_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/EX_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/control_word_reg.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/control_memory.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/CMP.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/alu.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/JB_hazard_detection_unit.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/ID_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/mp3_cpu.sv}

vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/mp3_tb.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code {/home/yuanm2/yuanm2/zerotoone/cp1/system-verilog-code/magic_memory_dual_port.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 0 sec
