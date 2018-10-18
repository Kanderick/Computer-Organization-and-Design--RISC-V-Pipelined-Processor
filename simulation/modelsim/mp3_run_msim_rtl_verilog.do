transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/cache_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/array.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/rv32i_types.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/register.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/regfile.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/pc_reg.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/mux2.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/mux8.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/hit_checker.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/simple_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/data_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/dirty_load_module.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/mem_data_convertor.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/datain_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/pmem_addr_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/cache_datapath.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/ir.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/control.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/alu.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/CMP.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/MDR.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/cache.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/datapath.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/mp3_cpu.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/mp3.sv}

vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/mp3_tb.sv}
vlog -sv -work work +incdir+/home/yuanm2/ece411/mp3 {/home/yuanm2/ece411/mp3/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 200 ns
