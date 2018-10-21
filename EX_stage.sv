import rv32i_types::*;
module EX_stage
(
    input clk,
    /* control signals */
    input logic EX_alumux1_sel,
    input logic [2:0] EX_alumux2_sel,
    input logic [2:0] EX_regfilemux_sel,
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
    output rv32i_word EX_cmp_out,
    /*to do*/
    input logic EX_forwarding_sel1,
    input logic EX_forwarding_sel2
);

rv32i_word alumux1_out, alumux2_out, cmpmux_out;
mux2 almux1
(
    .sel(EX_alumux1_sel),
    .a(EX_rs1_out),
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
    .e(EX_rs2_out),
    .f(EX_j_imm),
    .g(0),
    .h(0),
    .o(alumux2_out)
);

mux2 cmpmux
(
    .sel(EX_cmpmux_sel),
    .a(EX_rs2_out),
    .b(EX_i_imm),
    .f(cmpmux_out)
);

rv32i_word fowarding_mux1_out, fowarding_mux2_out;
mux4 fowarding_mux1
(
    .sel(EX_forwarding_sel1),
    .a(alumux1_out),
    .b(EX_rs1_forwarded_WB),
    .c(EX_rs1_forwarded_MEM), 
    .d(0),
    .f(fowarding_mux1_out)
);

mux4 fowarding_mux2
(
    .sel(EX_forwarding_sel2),
    .a(alumux2_out),
    .b(EX_rs2_forwarded_WB),
    .c(EX_rs2_forwarded_MEM),
    .d(0),
    .f(fowarding_mux2_out)
);

alu alu_inst
(
    .aluop(EX_aluop),
    .a(fowarding_mux1_out),
    .b(fowarding_mux2_out),
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

assign EX_cmp_out = {31'h0,br_en};
endmodule : EX_stage
