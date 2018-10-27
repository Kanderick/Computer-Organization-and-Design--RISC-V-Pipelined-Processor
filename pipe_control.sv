module pipe_control
(
	/*add NOP*/
   input flush,
   output logic IF_ID_flush,
   /*freeze the pipes*/
	input read_intr_stall,
	input mem_access_stall,
	output logic load,
	input clk
);

always_comb begin
	 load = 1'b1;
	 if(read_intr_stall|mem_access_stall)
		load = 1'b0;
    IF_ID_flush = flush;
end


endmodule
