import rv32i_types::*;

module cpu_datapath
(
    input clk,
    /* select signals */
    input pcmux_sel,
	 input marmux_sel,
	 input alumux1_sel,
	 input cmpmux_sel,
	 input [2:0] alumux2_sel,
	 input [2:0] regfilemux_sel,
	 /* control signals */
    input load_pc,
	 input load_ir,
	 input load_MDR, 
	 input instr_data,
	 input load_MAR,
	 input load_regfile,
	 input load_mem_data_out,
	 /* ALU info signal */
	 input alu_ops aluop,
	 input branch_funct3_t cmpop,
	 /* memory input */
	 input rv32i_word mem_rdata,
	 
	 /* output signals */
	 output logic [2:0] funct3,
    output logic [6:0] funct7,
    output rv32i_opcode opcode,
	 output rv32i_word mem_address,
	 output rv32i_word mem_wdata,
	 output logic br_en
);

/* declare internal signals */
rv32i_word pcmux_out;
rv32i_word pc_out;
rv32i_word alu_out, alu_out_zero_end;
rv32i_word pc_plus4_out;
	/* internal single-word-length signals */
rv32i_word rs2_out;
rv32i_word i_imm, s_imm, b_imm, u_imm, j_imm;
rv32i_word cmpmux_out;
rv32i_word MDR_data, MAR_data;
rv32i_word rs1_out;
rv32i_word aluinput_a, aluinput_b;
rv32i_word zext_br_en;
rv32i_word regfile_input;
	/* internal register number */
rv32i_reg rs1, rs2, rd;
/* combinational logic */
assign pc_plus4_out = pc_out + 4;
assign zext_br_en = {31'h00000000, br_en};
assign alu_out_zero_end = {alu_out[31:1], 1'b0};

/*
 * PC
 */
mux2 pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus4_out),
    .b(alu_out_zero_end),
    .f(pcmux_out)
);

pc_register pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);


/*
 *	ALU
 */
/*
module alu
(
	 input alu_ops aluop,
	 input [31:0] a, b,
	 output logic [31:0] f
);
*/
alu riscv_ALU
(
	 /*input*/
	 .aluop,
	 .a(aluinput_a),
	 .b(aluinput_b),
	 /*output*/
	 .f(alu_out)
);
mux2 #(.width(32)) alumux1
(
	 .sel(alumux1_sel),
	 .a(rs1_out),
	 .b(pc_out),
	 .f(aluinput_a)
);
mux8 #(.width(32)) alumux2
(
	 .sel(alumux2_sel),
	 .a(i_imm),
	 .b(u_imm),
	 .c(b_imm),
	 .d(s_imm),
	 .e(j_imm),
	 .f(rs2_out),
	 .g(),
	 .h(),
	 .o(aluinput_b)
);

/*
 * regfile
 */
/*
module regfile
(
    input clk,
    input load,
    input [31:0] in,
    input [4:0] src_a, src_b, dest,
    output logic [31:0] reg_a, reg_b
);
*/
regfile regfile
(	
	 /*input*/
	 .clk,
	 .load(load_regfile),
	 .in(regfile_input), 
	 .src_a(rs1),
	 .src_b(rs2),
	 .dest(rd),
	 /*output*/
	 .reg_a(rs1_out),
	 .reg_b(rs2_out)
);
mux8 #(.width(32)) regfilemux
(
	 .sel(regfilemux_sel),
	 .a(alu_out),
	 .b(zext_br_en),
	 .c(u_imm),
	 .d(MDR_data),
	 .e(pc_plus4_out),
	 .f(),
	 .g(),
	 .h(),
	 .o(regfile_input)
);
/*
 * MAR & MDR & mem_data_out
 */
/*
module register #(parameter width = 32)
(
    input clk,
    input load,
    input [width-1:0] in,
    output logic [width-1:0] out
);
*/
register #(.width(32)) mem_data_out 
(
	 /*input*/
	 .clk,
	 .load(load_mem_data_out),
	 .in(rs2_out),
	 /*output*/
	 .out(mem_wdata)
);
MDR riscv_MDR
(
	 /*input*/
	 .clk,
	 .load(load_MDR),
	 .in(mem_rdata),
	 .funct3,
	 .instr_data,
	 /*output*/
	 .out(MDR_data)
);
register #(.width(32)) riscv_MAR
(
	 /*input*/
	 .clk,
	 .load(load_MAR),
	 .in(MAR_data),	/*internal*/
	 /*output*/
	 .out(mem_address)
);
mux2 #(.width(32)) marmux
(
	 .sel(marmux_sel),
	 .a(pc_out),
	 .b(alu_out),
	 .f(MAR_data)
);
/*
 * CMP
 */
/*
module CMP 
(
		input branch_funct3_t cmpop,
		input [31:0] a,
		input [31:0] b,
		output logic br_en
);
*/
mux2 #(.width(32)) cmpmux /*use the default word width 32*/
(
	 /*input*/
	 .sel(cmpmux_sel),
	 .a(rs2_out),
	 .b(i_imm),
	 /*output*/
	 .f(cmpmux_out)
);
CMP riscv_CMP
(
	 .cmpop,
	 .a(rs1_out),
	 .b(cmpmux_out),
	 .br_en
);
/*
 * IR
 */
/*
module ir
(
    input clk,
    input load,
    input [31:0] in,
    output [2:0] funct3,
    output [6:0] funct7,
    output rv32i_opcode opcode,
    output [31:0] i_imm,
    output [31:0] s_imm,
    output [31:0] b_imm,
    output [31:0] u_imm,
    output [31:0] j_imm,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd
);
*/
ir IR
(
	 /*input*/
	 .clk,
	 .load(load_ir),
	 .in(MDR_data), /*should connect to MDR_out */
	 /*output*/
	 .funct3,
	 .funct7,
	 .opcode,
	 .i_imm, /*internal*/
	 .s_imm, /*internal*/
	 .b_imm, /*internal*/
	 .u_imm, /*internal*/
	 .j_imm,
	 .rs1,	/*internal*/
	 .rs2,	/*internal*/
	 .rd		/*internal*/
);

endmodule : cpu_datapath
