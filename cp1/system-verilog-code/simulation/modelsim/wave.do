onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp3_tb/clk
add wave -noupdate /mp3_tb/halt
add wave -noupdate /mp3_tb/read_a
add wave -noupdate /mp3_tb/write_a
add wave -noupdate /mp3_tb/wmask_a
add wave -noupdate /mp3_tb/address_a
add wave -noupdate /mp3_tb/wdata_a
add wave -noupdate /mp3_tb/resp_a
add wave -noupdate /mp3_tb/rdata_a
add wave -noupdate /mp3_tb/read_b
add wave -noupdate /mp3_tb/write_b
add wave -noupdate /mp3_tb/wmask_b
add wave -noupdate /mp3_tb/address_b
add wave -noupdate /mp3_tb/wdata_b
add wave -noupdate /mp3_tb/resp_b
add wave -noupdate /mp3_tb/rdata_b
add wave -noupdate /mp3_tb/mp3_cpu/control_memory/ctrl.opcode
add wave -noupdate /mp3_tb/mp3_cpu/ID_stage/ID_JB_unit/jb_sel
add wave -noupdate /mp3_tb/mp3_cpu/ID_stage/ID_JB_unit/flush
add wave -noupdate /mp3_tb/mp3_cpu/pipe_control/IF_ID_flush
add wave -noupdate /mp3_tb/mp3_cpu/IF_stage/pcmux_sel
add wave -noupdate -radix hexadecimal /mp3_tb/mp3_cpu/IF_stage/EX_jmp_pc
add wave -noupdate -radix hexadecimal /mp3_tb/mp3_cpu/IF_stage/ID_pc_mux_out
add wave -noupdate -radix hexadecimal /mp3_tb/mp3_cpu/ID_stage/ID_JB_unit/ID_rs1_out
add wave -noupdate -radix hexadecimal /mp3_tb/mp3_cpu/ID_stage/ID_JB_unit/ID_rs2_out
add wave -noupdate -radix hexadecimal -childformat {{{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[0]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[1]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[2]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[3]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[4]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[5]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[6]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[7]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[8]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[9]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[10]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[11]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[12]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[13]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[14]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[15]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[16]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[17]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[18]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[19]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[20]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[21]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[22]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[23]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[24]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[25]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[26]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[27]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[28]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[29]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[30]} -radix hexadecimal} {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[31]} -radix hexadecimal}} -expand -subitemconfig {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[0]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[1]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[2]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[3]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[4]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[5]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[6]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[7]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[8]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[9]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[10]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[11]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[12]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[13]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[14]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[15]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[16]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[17]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[18]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[19]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[20]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[21]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[22]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[23]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[24]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[25]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[26]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[27]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[28]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[29]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[30]} {-height 15 -radix hexadecimal} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[31]} {-height 15 -radix hexadecimal}} /mp3_tb/mp3_cpu/ID_stage/ID_regfile/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {435187 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 344
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {196720 ps} {688523 ps}
