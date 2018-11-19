import rv32i_types::*;
module EX_stage
(
    input clk,
    /* control signals */
    input logic EX_alumux1_sel,
    input logic [2:0] EX_alumux2_sel,
    input logic EX_cmpmux_sel,
    input alu_ops EX_aluop,
    input branch_funct3_t EX_cmpop,
    /* input data*/
    input rv32i_word EX_pc,
    input rv32i_word EX_rs1_out, EX_rs2_out,
    input rv32i_word EX_i_imm, EX_u_imm, EX_b_imm, EX_s_imm, EX_j_imm,
    input rv32i_word EX_rs1_forwarded_WB, EX_rs2_forwarded_WB,
    input rv32i_word EX_rs1_forwarded_MEM, EX_rs2_forwarded_MEM,    
    /*output data*/
    output rv32i_word EX_alu_out,
    output logic EX_cmp_out,
	 output rv32i_word fowarding_mux2_out,
	 /*dependency resolver*/
	 input [1:0] jb_sel,
	 input [31:0] ID_b_imm,
	 input [31:0] ID_j_imm,
	 input [31:0] ID_i_imm,
	 output logic [31:0] EX_jmp_pc,
	 output logic EX_pc_mux_sel,
	 output logic flush,
	 //output logic [31:0] ID_rs1_out,
	 //output logic [31:0] ID_rs2_out,
    /*to do*/
    input [1:0] EX_forwarding_sel1,
    input [1:0] EX_forwarding_sel2
);
rv32i_word fowarding_mux1_out;
rv32i_word alumux1_out, alumux2_out, cmpmux_out;
/*dependency resolver*/
logic [31:0] imm;
logic [31:0] pc_rs1_add_rst;

assign EX_jmp_pc = imm + pc_rs1_add_rst;

mux4 imm_mux(
	.sel(jb_sel),
	.a(0),
	.b(ID_j_imm),
	.c(ID_i_imm),
	.d(ID_b_imm),
	.f(imm)
);

mux2 pc_rs1_mux(
	.sel(jb_sel[0]),
	.a(fowarding_mux1_out),
	.b(EX_pc),
	.f(pc_rs1_add_rst)
);

JB_hazard_detection_unit ID_JB_unit
(
	.jb_sel,
	.cmpop(EX_cmpop),
	.rs1_out(fowarding_mux1_out),
	.rs2_out(fowarding_mux2_out),
	.pcmux_sel(EX_pc_mux_sel),
	.flush
);



mux2 almux1
(
    .sel(EX_alumux1_sel),
    .a(fowarding_mux1_out),
    .b(EX_pc),
    .f(alumux1_out)
);

mux8 almux2
(
    .sel(EX_alumux2_sel),
    .a(EX_i_imm),
    .b(EX_u_imm),
    .c(EX_b_imm),
    .d(EX_s_imm),
    .e(fowarding_mux2_out),
    .f(EX_j_imm),
    .g(0),
    .h(0),
    .o(alumux2_out)
);

mux2 cmpmux
(
    .sel(EX_cmpmux_sel),
    .a(fowarding_mux2_out),
    .b(EX_i_imm),
    .f(cmpmux_out)
);


mux4 fowarding_mux1
(
    .sel(EX_forwarding_sel1),
    .a(EX_rs1_out),
    .c(EX_rs1_forwarded_WB),
    .b(EX_rs1_forwarded_MEM), 
    .d(0),
    .f(fowarding_mux1_out)
);

mux4 fowarding_mux2
(
    .sel(EX_forwarding_sel2),
    .a(EX_rs2_out),
    .c(EX_rs2_forwarded_WB),
    .b(EX_rs2_forwarded_MEM),
    .d(0),
    .f(fowarding_mux2_out)
);

alu alu_inst
(
    .aluop(EX_aluop),
    .a(alumux1_out),
    .b(alumux2_out),
    .f(EX_alu_out)
);

logic br_en;
CMP CMP
(
    .cmpop(EX_cmpop),
    .a(EX_rs1_out),
    .b(cmpmux_out),
    .br_en(br_en)
);

assign EX_cmp_out = br_en;
endmodule : EX_stage
