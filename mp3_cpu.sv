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
logic [31:0] instr;

/*ID_stage signal*/
logic [31:0] ID_pc;
logic ID_pc_mux_sel;
rv32i_word ID_rs1_out;
rv32i_word ID_rs2_out;
rv32i_word ID_jmp_pc;

/*EX_stage signal*/
rv32i_word EX_pc;
rv32i_word EX_rs1_out;
rv32i_word EX_rs2_out;
rv32i_word EX_jmp_pc;
logic EX_pc_mux_sel;
rv32i_word EX_rs1_forwarded_WB, EX_rs2_forwarded_WB;
rv32i_word EX_rs1_forwarded_MEM, EX_rs2_forwarded_MEM;    
rv32i_word EX_alu_out;
logic EX_cmp_out;
logic [1:0] EX_forwarding_sel1;
logic [1:0] EX_forwarding_sel2;
/*MEM_stage signal*/
logic MEM_cmp_out;
rv32i_word MEM_alu_out;
rv32i_word MEM_pc;
rv32i_word MEM_rs2_out;


/*WB_stage signal*/
logic WB_cmp_out;
rv32i_word WB_alu_out;
rv32i_word WB_rdata;
rv32i_word WB_pc;
rv32i_word WB_in;


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

assign read_intr_stall = (read_a|write_a)&(!resp_a);
assign mem_access_stall = (read_b|write_b)&(!resp_b);
assign read_a = 1'b1;
assign write_a = 1'b0;
assign read_b=MEM_ctrl_word.mem_read;
assign write_b=MEM_ctrl_word.mem_write;
assign wdata_a=32'b0;
assign wmask_b=MEM_ctrl_word.mem_byte_enable;
assign wmask_a=4'b0;
assign EX_forwarding_sel1=0;
assign EX_forwarding_sel2=0;

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
    .control_signal_in(control_memory_out),
    .control_signal_out(ID_ctrl_word), 
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
    .control_signal_out(EX_ctrl_word), 
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
	.load,
	.clk,
	.reset(0)
);

EX_stage EX_stage
(
    .clk,
    /* control signals */
    .EX_alumux1_sel(EX_ctrl_word.alumux1_sel),
    .EX_alumux2_sel(EX_ctrl_word.alumux2_sel),
    .EX_cmpmux_sel(EX_ctrl_word.cmpmux_sel),
    .EX_aluop(EX_ctrl_word.aluop),
    .EX_cmpop(EX_ctrl_word.cmpop),
    /* input data*/
    .EX_pc,
    .EX_rs1_out,
    .EX_rs2_out,
    .EX_i_imm(EX_ctrl_word.i_imm),
    .EX_u_imm(EX_ctrl_word.u_imm),
    .EX_b_imm(EX_ctrl_word.b_imm),
    .EX_s_imm(EX_ctrl_word.s_imm),
    .EX_j_imm(EX_ctrl_word.j_imm),
    .EX_rs1_forwarded_WB,
    .EX_rs2_forwarded_WB,
    .EX_rs1_forwarded_MEM,
    .EX_rs2_forwarded_MEM,    
    /*output data*/
    .EX_alu_out,
    .EX_cmp_out,
    /*to do*/
    .EX_forwarding_sel1,
    .EX_forwarding_sel2
);

control_word_reg MEM_ctrl
 (
    .clk,
    .reset(1'b0),
    .control_signal_in(EX_ctrl_word),
    .control_signal_out(MEM_ctrl_word), 
    .load_control_word(load)
 );
 
MEM_pipe MEM_pipe
(
	.clk,
	.reset(1'b0),
	.load(load),
	
	.EX_pc,
	.EX_alu_out,
	.EX_rs2_out,
	.EX_cmp_out,
	
	.MEM_pc,
	.MEM_alu_out,
	.MEM_rs2_out,
	.MEM_cmp_out
);

MEM_stage MEM_stage
(
	.MEM_rs2_out,
	.MEM_alu_out,
	.MEM_addr(address_b),
	.MEM_data(wdata_b)

);	

control_word_reg WB_ctrl
 (
    .clk,
    .reset(1'b0),
    .control_signal_in(MEM_ctrl_word),
    .control_signal_out(WB_ctrl_word), 
    .load_control_word(load)
 );
 
WB_pipe WB_pipe
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

WB_stage WB_stage
(
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
