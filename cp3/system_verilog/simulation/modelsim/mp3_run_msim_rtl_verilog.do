transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/array_16.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/array.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/ID_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mux8.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mux4.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mux2.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/rv32i_types.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/regfile.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/EX_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/WB_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/WB_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/MEM_pipe.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/pipe_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/pc_reg.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/decoder2.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/WB_MEM_EX_forwarding.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/add4.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_valid_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_tag_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_tag_comparator.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_pmem_address_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_dirty_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_data_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_address_decoder.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Icache_tag_comparator.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Icache_data_assembler.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Icache_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Icache_array_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Icache_address_decoder.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_write_data_assembler.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_valid_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_tag_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_tag_comparator.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_pmem_address_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_dirty_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_data_load_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_data_assembler.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_control.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_address_decoder.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/MEM_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/alu.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mem_access_proxy.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/arbitor.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/IF_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/ID_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/CMP.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/control_word_reg.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/control_memory.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/rdata_out_logic.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache_datapath.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Icache_datapath.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache_datapath.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/JB_hazard_detection_unit.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L2cache.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Icache.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/L1Dcache.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/EX_stage.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mp3_cpu.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mp3.sv}

vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mp3_tb.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/mp3.sv}
vlog -sv -work work +incdir+/home/yuanm2/yuanm2/zerotoone/developing {/home/yuanm2/yuanm2/zerotoone/developing/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 200 ns
