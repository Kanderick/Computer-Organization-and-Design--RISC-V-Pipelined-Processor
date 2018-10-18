import rv32i_types::*;
module EX_stage
(
    input clk,
    /* control signals */
    input logic alumux1_sel,
    input logic [2:0] alumux2_sel,
    input logic [2:0] regfilemux_sel,
    input logic marmux_sel,
    input logic cmpmux_sel,
    input alu_ops aluop,
    input branch_funct3_t cmpop,
    input load_funct3_t loadop,
    /* input data*/
    input rv32i_word pc,
    input rv32i_word rs1_out, rs2_out,
    input rv32i_word i_imm, u_imm, b_imm, s_imm, j_imm,
    input rv32i_word rs1_forwarded_WB, rs2_forwarded_WB,
    input rv32i_word rs1_forwarded_MEM, rs2_forwarded_MEM,    
    /*output data*/
    output rv32i_word alu_out,
    output rv32i_word cmp_out,
    /*to do*/
    input logic forwarding_sel1,
    input logic forwarding_sel2
);

rv32i_word alumux1_out, alumux2_out, cmpmux_out;
mux2 almux1
(
    .sel(alumux1_sel),
    .a(rs1_out),
    .b(pc),
    .f(alumux1_out)
);

mux8 almux2
(
    .sel(alumux2_sel),
    .a(i_imm),
    .b(u_imm),
    .c(b_imm),
    .d(s_imm),
    .e(rs2_out),
    .f(j_imm),
    .g(0),
    .h(0),
    .o(alumux2_out)
);

mux2 cmpmux
(
.sel(cmpmux_sel),
.a(rs2_out),
.b(i_imm),
.f(cmpmux_out)
);

rv32i_word fowarding_mux1_out, fowarding_mux2_out;
mux4 fowarding_mux1
(
.sel(forwarding_sel1),
.a(alumux1_out),
.b(rs1_forwarded_WB),
.c(rs1_forwarded_MEM), 
.d(0),
.f(fowarding_mux1_out)
);

mux4 fowarding_mux2
(
.sel(forwarding_sel2),
.a(alumux2_out),
.b(rs2_forwarded_WB),
.c(rs2_forwarded_MEM),
.d(0),
.f(fowarding_mux2_out)
);

alu alu_inst
(
    .aluop,
    .a(fowarding_mux1_out),
    .b(fowarding_mux2_out),
    .f(alu_out)
);

logic br_en;
CMP CMP
(
    .cmpop,
    .a(rs1_out),
    .b(cmpmux_out),
    .br_en(br_en)
);

assign cmp_out = {31'h0,br_en};
endmodule