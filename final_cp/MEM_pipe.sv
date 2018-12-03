module MEM_pipe(
	input clk,
	input reset,
	input load,
	
	input [31:0] EX_pc,
	input [31:0] EX_alu_out,
	input [31:0] EX_rs2_out,
	input EX_cmp_out,
	
	output logic [31:0] MEM_pc,
	output logic [31:0] MEM_alu_out,
	output logic [31:0] MEM_rs2_out,
	output logic MEM_cmp_out,
	//dependency resolver
	input [31:0] EX_jmp_pc,
	input EX_pc_mux_sel,
	input EX_flush,
	output logic [31:0] MEM_jmp_pc,
	output logic MEM_pc_mux_sel,
	output logic flush,
    
        
    input EX_update_BHT,
    input EX_replace_BHT,
    output logic MEM_update_BHT,
    output logic MEM_replace_BHT,
	 
	input [3:0] EX_pattern_used,
	output logic [3:0] MEM_pattern_used,    
	input EX_is_jal,
	output logic MEM_is_jal,
	
	input EX_local_prediction,
	output logic MEM_local_prediction,
	input EX_global_prediction,
	output logic MEM_global_prediction
	
);

initial
begin
	MEM_pc=0;
	MEM_alu_out=0;
	MEM_rs2_out=0;
	MEM_cmp_out=0;
	MEM_jmp_pc=0;
	MEM_pc_mux_sel=0;
	flush=0;
    MEM_update_BHT = 0;
    MEM_replace_BHT = 0;
	 MEM_pattern_used = 0;
	 MEM_is_jal = 0;
	 MEM_local_prediction = 0;
	 MEM_global_prediction = 0;
end
always_ff @ (posedge clk)
begin
	if (reset)
	begin
		MEM_pc <= 0;
		MEM_alu_out <= 0;
		MEM_rs2_out <= 0;
		MEM_cmp_out <= 0;
		MEM_jmp_pc<=0;
		MEM_pc_mux_sel<=0;
		flush<=0;
      MEM_update_BHT <= 0;
      MEM_replace_BHT <= 0;
		MEM_pattern_used <= 0;
		MEM_is_jal <= 0;
		MEM_local_prediction <= 0;
	   MEM_global_prediction <= 0;  
	end
	
	else if(load)
	begin
		MEM_pc <= EX_pc;
		MEM_alu_out <= EX_alu_out;
		MEM_rs2_out <= EX_rs2_out;
		MEM_cmp_out <= EX_cmp_out;
		MEM_jmp_pc<=EX_jmp_pc;
		MEM_pc_mux_sel<=EX_pc_mux_sel;
		flush<=EX_flush;
      MEM_update_BHT <= EX_update_BHT;
      MEM_replace_BHT <= EX_replace_BHT;
		MEM_pattern_used <= EX_pattern_used;
		MEM_is_jal <= EX_is_jal;
		MEM_local_prediction <= EX_local_prediction;
	   MEM_global_prediction <= EX_global_prediction;  
	end
end

endmodule	: MEM_pipe