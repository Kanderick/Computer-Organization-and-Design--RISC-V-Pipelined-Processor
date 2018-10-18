module IF_stage
(
		input clk,
		output [31:0] IF_addr
);

logic [31:0] ID_pc_mux_out;
logic [31:0] ID_p4_pc;
assign ID_p4_pc = IF_addr+4;
pc_register IF_pc
(
	.clk,
	.load(1'b1),
	.in(ID_pc_mux_out),
	.out(IF_addr)
	
);

mux2 #(.width(32)) ID_pc_mux
(
	.a(ID_p4_pc),
	.b(32'b0),
	.sel(1'b0),
	.f(ID_pc_mux_out)
);
endmodule : IF_stage