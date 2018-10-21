import rv32i_types::*;

module mp3_cpu
(
    input clk,

    /* instruction cache */
    output logic read_a,
    output logic write_a,
    output logic [3:0] wmask_a,
    output logic [31:0] address_a,
    output logic [31:0] wdata_a,
    input resp_a,
    input [31:0] rdata_a,

    /* data cache */
    output logic read_b,
    output logic write_b,
    output logic [3:0] wmask_b,
    output logic [31:0] address_b,
    output logic [31:0] wdata_b,
    input resp_b,
    input [31:0] rdata_b
);

/*IF_stage signal*/
logic [31:0] IF_addr;
assign address_a = IF_addr;
logic {31:0} instr;

/*ID_stage signal*/
logic [31:0] ID_pc;
logic ID_pc_mux_sel;
rv32i_word ID_rs1_out;
rv32i_word ID_rs1_out;
rv32i_word ID_jmp_pc;

/*EX_stage signal*/
rv32i_word EX_pc;
rv32i_word EX_rs1_out;
rv32i_word EX_rs2_out;
rv32i_word EX_jmp_pc;
logic EX_pc_mux_sel;

/*MEM_stage signal*/
logic MEM_cmp_out;
logic [31:0] MEM_alu_out;
logic [31:0] MEM_pc;

/*WB_stage signal*/
logic WB_cmp_out;
logic [31:0] WB_alu_out;
logic [31:0] WB_rdata;
logic [31:0] WB_pc;
logic [31:0] WB_in;


/*control word*/
rv32i_control_word control_memory_out;
rv32i_control_word ID_ctrl_word;
rv32i_control_word EX_ctrl_word;
rv32i_control_word MEM_ctrl_word;
rv32i_control_word WB_ctrl_word;

/*pipe control signal*/
logic flush;
logic IF_ID_flush;
logic read_intr_stall;
logic mem_access_stall;
logic load;

pipe_control pipe_control
(
	/*add NOP*/
    .flush,
    .IF_ID_flush,
   /*freeze the pipes*/
	.read_intr_stall,
	.mem_access_stall,
	.load,
	.clk
);

IF_stage IF_stage
(
		.clk,
		.EX_jmp_pc,
		.IF_addr
);

control_memory control_memory
(
    .instr(rdata_a),
    .ctrl(control_memory_out)
);

control_word_reg ID_ctrl
 (
    .clk,
    .reset(IF_ID_flush),
    .rv32i_control_word control_signal_in(control_memory_out),
    .rv32i_control_word control_signal_out(ID_ctrl_word), 
    .load_control_word(load) 
 );
 
ID_pipe ID_pipe
(
	.IF_pc(IF_addr),
	.ID_pc,
	.clk,
    .load,
	.reset(IF_ID_flush)
);

ID_stage ID_stage
(
		.clk,
		.ID_rs1(ID_ctrl_word.rs1),
		.ID_rs2(ID_ctrl_word.rs2),
		.WB_in,
		.ID_rd(ID_ctrl_word.rd),
		.ID_load_regfile(ID_ctrl_word.load_regfile),
		.ID_pc,
		.ID_b_imm(ID_ctrl_word.b_imm),
		.ID_j_imm(ID_ctrl_word.j_imm),
		.ID_i_imm(ID_ctrl_word.i_imm),
		.jb_sel(ID_ctrl_word.jb_sel),
		.cmpop(ID_ctrl_word.cmpop),
		.ID_pc_mux_sel,
		.flush,
		.ID_rs1_out,
		.ID_rs2_out,
		.ID_jmp_pc
);

 control_word_reg EX_ctrl
 (
    .clk,
    .reset(0),
    .control_signal_in(ID_ctrl_word),
    .control_signal_out(IF_ctrl_word), 
    .load_control_word(load)
 );

EX_pipe EX_pipe
(
	.ID_pc,
	.ID_rs1_out,
	.ID_rs2_out,
	.ID_jmp_pc,
	.ID_pc_mux_sel,
	
	.EX_pc,
	.EX_rs1_out,
	.EX_rs2_out,
	.EX_jmp_pc,
	.EX_pc_mux_sel,
	/*other signals*/
	.clk,
	.reset(0)
);

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
    input load_funct3_t EX_loadop,
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

 module control_word_reg
 (
    input clk,
    input reset,
    input rv32i_control_word control_signal_in,
    output rv32i_control_word control_signal_out, 
    input load_control_word 
 );
 
module MEM_pipe(
	input clk,
	input reset,
	// input load,
	
	input [31:0] EX_pc,
	input [31:0] EX_alu_out,
	input [31:0] EX_rs2_out,
	input EX_cmp_out,
	
	.MEM_pc,
	.MEM_alu_out,
	output logic [31:0] MEM_rs2_out,
	.MEM_cmp_out
);

module MEM_stage
(
	input [31:0] MEM_rs2_out,
	.MEM_alu_out,
	output [31:0] MEM_addr,
	output [31:0] MEM_dataoutput rv32i_control_word 

);	

control_word_reg WB_ctrl
 (
    .clk,
    .reset(1'b0),
    .control_signal_in(MEM_ctrl_word),
    .control_signal_out(WB_ctrl_word), 
    .load_control_word(load)
 );
 
module WB_pipe
(
	.MEM_cmp_out,
	.MEM_alu_out,
	.MEM_rdata(rdata_b),	/*read from data cache*/
	.MEM_pc,
	.WB_cmp_out,
	.WB_alu_out,
	.WB_rdata,
	.WB_pc,
	/*other signals*/
	.clk,
	.load,
	.reset(1'b0)
);

module WB_stage(
	.WB_pc,
	.WB_funct3(WB_ctrl_word.funct3),
	.WB_rdata,
	.WB_cmp_out,
	.WB_alu_out,
	.WB_u_imm(WB_ctrl_word.u_imm),
	.WB_regfilemux_sel(WB_ctrl_word.regfilemux_sel),
	.WB_in
);


endmodule : mp3_cpu
