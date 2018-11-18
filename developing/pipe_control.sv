module pipe_control
(
	/*add NOP*/
   input flush,
   output logic IF_ID_flush,
	output logic MEM_flush,
   /*freeze the pipes*/
	input read_intr_stall,
	input mem_access_stall,
	input MEM_EX_rdata_hazard,
	output logic pc_load,
	output logic ID_load,
	output logic EX_load,
	output logic MEM_load,
	output logic WB_load,
	input clk
);

always_comb begin
	 pc_load=1'b1;
	 ID_load=1'b1;
	 EX_load=1'b1;
	 MEM_load=1'b1;
	 WB_load=1'b1;
	 MEM_flush=0;
	 if(MEM_EX_rdata_hazard)
	 begin
		pc_load=1'b0;
		ID_load=1'b0;
		EX_load=1'b0;
		MEM_flush=1'b1;
	 end
	 if(read_intr_stall|mem_access_stall)
	 begin
		pc_load=1'b0;
		ID_load=1'b0;
		EX_load=1'b0;
		MEM_load=1'b0;
		WB_load=1'b0;
	 end
    IF_ID_flush = flush;
	 MEM_flush = MEM_flush|flush;
end


endmodule
