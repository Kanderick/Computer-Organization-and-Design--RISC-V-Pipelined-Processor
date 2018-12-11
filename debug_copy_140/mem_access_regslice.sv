import rv32i_types::*;

module mem_access_regslice  #(parameter width = 32, parameter custom_sig_width  = 1, parameter custom_sig_width_2 = 1)
(
    input clk,

    //L2 cache signal from l1
    input  L2cache_read,
    input  L2cache_write,
    input rv32i_word L2cache_address,
    input [width-1:0] L2cache_wdata,
    input [3:0] L2cache_byte_enable, //remember to comment it out
    //output logic [width-1:0] L2cache_rdata_reg,
   // output logic L2cache_resp_reg,      
	 input [custom_sig_width-1:0]  custom_signal,
	 input [custom_sig_width_2-1:0]  custom_signal_2,
    //signal to L2 cach 
    output logic L2cache_read_reg,
    output logic L2cache_write_reg,
    output  rv32i_word L2cache_address_reg,
    output logic [width-1:0] L2cache_wdata_reg,
    output logic [3:0] L2cache_byte_enable_reg, //remember to comment it out
	 output logic [custom_sig_width-1:0]  custom_signal_reg,
	 output logic [custom_sig_width_2-1:0]  custom_signal_2_reg,
    input [width-1:0] L2cache_rdata,
    input L2cache_resp   
	 
);
initial begin

    L2cache_read_reg = 0;
    L2cache_write_reg = 0;
    L2cache_address_reg = 0;
    L2cache_wdata_reg = 0;
    L2cache_byte_enable_reg = 0;
   // L2cache_rdata_reg = 0;
   // L2cache_resp_reg = 0;
	 custom_signal_reg  = 0;
end

always_ff @ (posedge clk) begin
	if (L2cache_resp) begin
		 L2cache_read_reg <= 0;
		 L2cache_write_reg <= 0;
		 L2cache_address_reg <= 0;
		 L2cache_wdata_reg <= 0;
		 L2cache_byte_enable_reg <= 0;
		 //L2cache_rdata_reg <= L2cache_rdata;
		 //L2cache_resp_reg <= 1;	
		 custom_signal_reg = 0;
		 custom_signal_2_reg = 0;
	 end	 
	 else	 begin
		 L2cache_read_reg <= L2cache_read;
		 L2cache_write_reg <= L2cache_write;
		 L2cache_address_reg <= L2cache_address;
		 L2cache_wdata_reg <= L2cache_wdata;
		 L2cache_byte_enable_reg <= L2cache_byte_enable;
		 //L2cache_rdata_reg <= 0;
		// L2cache_resp_reg <= 0;
		 custom_signal_reg <= custom_signal;
		 custom_signal_2_reg = custom_signal_2;
	 end 	 
end

endmodule