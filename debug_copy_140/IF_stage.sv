module IF_stage
(
		input clk,
		input [31:0] MEM_jmp_pc,
		input pcmux_sel,
		input pc_load,
		output logic [31:0] IF_addr,
        
        input [31:0] BTB_target,
        input IF_prediction
);

logic [31:0] ID_pc_mux_out;
logic [31:0] ID_p4_pc;
logic [31:0] next_pc;

assign ID_p4_pc = IF_addr+4;

mux2 #(.width(32)) ID_pc_predict_mux
(
	.a(ID_p4_pc),
	.b({BTB_target[31:1], 1'b0}),
	.sel(IF_prediction),
	.f(next_pc)
);


mux2 #(.width(32)) ID_pc_mux
(
	.a(next_pc),
	.b({MEM_jmp_pc[31:1], 1'b0}),
	.sel(pcmux_sel),
	.f(ID_pc_mux_out)
);

pc_register IF_pc
(
	.clk,
	.load(pc_load),
	.in({ID_pc_mux_out[31:1],1'b0}),
	.out(IF_addr)
	
);

endmodule : IF_stage