onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 /mp3_tb/clk
add wave -noupdate -height 15 /mp3_tb/halt
add wave -noupdate -height 15 /mp3_tb/read_a
add wave -noupdate -height 15 /mp3_tb/write_a
add wave -noupdate -height 15 /mp3_tb/wmask_a
add wave -noupdate -height 15 /mp3_tb/address_a
add wave -noupdate -height 15 /mp3_tb/wdata_a
add wave -noupdate -height 15 /mp3_tb/resp_a
add wave -noupdate -height 15 /mp3_tb/rdata_a
add wave -noupdate -height 15 /mp3_tb/read_b
add wave -noupdate -height 15 /mp3_tb/write_b
add wave -noupdate -height 15 /mp3_tb/wmask_b
add wave -noupdate -height 15 /mp3_tb/address_b
add wave -noupdate -height 15 /mp3_tb/wdata_b
add wave -noupdate -height 15 /mp3_tb/resp_b
add wave -noupdate -height 15 /mp3_tb/rdata_b
add wave -noupdate -height 15 /mp3_tb/mp3_cpu/control_memory/instr
add wave -noupdate -height 15 /mp3_tb/mp3_cpu/control_memory/ctrl
add wave -noupdate -height 15 /mp3_tb/mp3_cpu/control_memory/ctrl.opcode
add wave -noupdate -height 15 /mp3_tb/mp3_cpu/WB_stage/WB_alu_out
add wave -noupdate -height 15 /mp3_tb/mp3_cpu/ID_stage/ID_regfile/load
add wave -noupdate -height 15 -expand -subitemconfig {{/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[0]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[1]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[2]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[3]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[4]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[5]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[6]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[7]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[8]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[9]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[10]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[11]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[12]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[13]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[14]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[15]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[16]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[17]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[18]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[19]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[20]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[21]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[22]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[23]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[24]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[25]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[26]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[27]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[28]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[29]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[30]} {-height 15} {/mp3_tb/mp3_cpu/ID_stage/ID_regfile/data[31]} {-height 15}} /mp3_tb/mp3_cpu/ID_stage/ID_regfile/data
add wave -noupdate -height 15 /mp3_tb/mp3_cpu/WB_stage/WB_regfilemux_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {156017 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 304
configure wave -valuecolwidth 126
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
WaveRestoreZoom {0 ps} {496186 ps}
