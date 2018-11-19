onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp3_tb/clk
add wave -noupdate /mp3_tb/halt
add wave -noupdate /mp3_tb/read
add wave -noupdate /mp3_tb/write
add wave -noupdate /mp3_tb/address
add wave -noupdate /mp3_tb/wdata
add wave -noupdate /mp3_tb/resp
add wave -noupdate /mp3_tb/rdata
add wave -noupdate -expand /mp3_tb/mp3/mp3_cpu/control_memory/ctrl
add wave -noupdate -expand /mp3_tb/mp3/mp3_cpu/ID_stage/ID_regfile/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {249012 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {5250 ns}
