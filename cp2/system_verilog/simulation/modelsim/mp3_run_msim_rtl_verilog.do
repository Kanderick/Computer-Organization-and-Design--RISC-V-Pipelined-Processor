transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/array.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Icache_tag_comparator.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Icache_data_assembler.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Icache_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Icache_array_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Icache_address_decoder.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_write_data_assembler.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_valid_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_tag_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_tag_comparator.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_pmem_address_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_dirty_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_data_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_data_assembler.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_address_decoder.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/WB_MEM_EX_forwarding.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/decoder2.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/pc_reg.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/pipe_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/MEM_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/add4.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/WB_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/rv32i_types.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/regfile.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mux2.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mux4.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mux8.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/WB_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/EX_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/ID_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Icache_datapath.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache_datapath.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/rdata_out_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/control_memory.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/control_word_reg.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/EX_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/alu.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/CMP.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/MEM_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/IF_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/arbitor.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mem_access_proxy.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Icache.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/L1Dcache.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/JB_hazard_detection_unit.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/ID_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mp3_cpu.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mp3.sv}

vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mp3_tb.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/mp3.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/cp2 {/home/yuanm2/yuanm2/zerotoone/cp2/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 200 ns
