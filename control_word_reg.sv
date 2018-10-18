 import rv32i_types::*;

 module control_word_reg
 (
    input clk,
    input reset,
    input rv32i_control_word control_signal_in,
    output rv32i_control_word control_signal_out, 
    input load_control_word 
 );
 
 rv32i_control_word control_signal_reg;
 always_ff @ (posedge clk) begin
    if(reset)
        control_signal_reg <= 0;  
    else
        control_signal_reg <=  control_signal_in;
 end
 
 assign control_signal_out = control_signal_reg;
 endmodule