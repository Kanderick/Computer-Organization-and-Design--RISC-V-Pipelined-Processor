transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/pipe_control.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/MEM_pipe.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/add4.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/WB_stage.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/rv32i_types.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/regfile.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/pc_reg.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/mux2.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/mux4.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/mux8.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/MEM_stage.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/WB_pipe.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/EX_pipe.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/ID_pipe.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/control_memory.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/rdata_out_logic.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/control_word_reg.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/EX_stage.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/alu.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/CMP.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/IF_stage.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/JB_hazard_detection_unit.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/ID_stage.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/mp3_cpu.sv}

vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/mp3_tb.sv}
vlog -sv -work work +incdir+/home/hxu52/ece411/zerotoone {/home/hxu52/ece411/zerotoone/magic_memory_dual_port.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 200 ns
