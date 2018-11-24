import rv32i_types::*; /* Import types defined in rv32i_types.sv */
module performance_unit
(
	input clk,
	input reset,
	input if_stall,
	input resp_l2,
	/*br miss prediction*/
	input flush,
	input jb_sel,
	/*L1I miss*/
	input l1i_miss_sig,
	input read_a,
	/*L1D miss*/
	input l1d_miss_sig,
	input read_b,
	input write_b,
	/*L2 miss*/
	input l2_miss_sig,
	input write_l2,
	input read_l2,
	/*arbitor conflict*/
	input read_I,
	input read_D,
	input write_D
);
/*attention to overflow*/
reg [31:0] br_miss;   /*l1d_arbi_address==32'h0*/
reg [31:0] br_total;  /*l1d_arbi_address==32'h1*/
reg [31:0] l1i_miss;  /*l1d_arbi_address==32'h2*/
reg [31:0] l1i_total; /*l1d_arbi_address==32'h3*/
reg [31:0] l1d_miss;  /*l1d_arbi_address==32'h4*/
reg [31:0] l1d_total; /*l1d_arbi_address==32'h5*/
reg [31:0] l2_miss;   /*l1d_arbi_address==32'h6*/
reg [31:0] l2_total;  /*l1d_arbi_address==32'h7*/
reg [31:0] ID_conf;
/*edge detection buffer*/
reg flush_buff;
initial 
begin
	flush_buff=0;
	br_miss=0;
	br_total=0;
	l1i_miss=0;
	l1i_total=0;
	l1d_miss=0;
	l1d_total=0;
	l2_miss=0;
	l2_total=0;
	ID_conf=0;
end
always_ff @(posedge clk)
begin
	if(reset)
	begin
		flush_buff<=0;
		br_miss<=0;
		br_total<=0;
		l1i_miss<=0;
		l1i_total<=0;
		l1d_miss<=0;
		l1d_total<=0;
		l2_miss<=0;
		l2_total<=0;
		ID_conf<=0;
	end
	else
	begin
		/*br miss prediction*/
		if(flush&&!flush_buff&&br_miss<=br_total)
			br_miss<=br_miss+1;
		else if(flush&&!flush_buff&&br_miss>br_total)
			br_miss<=1;
		if(jb_sel&&!if_stall)
			br_total<=br_total+1;
		/*L1I miss*/
		if(l1i_miss_sig&&l1i_miss<=l1i_total)
			l1i_miss<=l1i_miss+1;
		else if(l1i_miss&&l1i_miss>l1i_total)
			l1i_miss<=1;
		if(!if_stall&&read_a==1'b1)
			l1i_total<=l1i_total+1;
		/*L1D miss*/
		if(l1d_miss_sig&&l1d_miss<=l1d_total)
			l1d_miss<=l1d_miss+1;
		else if(l1d_miss_sig&&l1d_miss>l1d_total)
			l1d_miss<=1;
		if((read_b|write_b)==1'b1&&!if_stall)
			l1d_total<=l1d_total+1;
		/*L2 miss*/
		if(l2_miss_sig&&l2_miss<=l2_total+1)
			l2_miss<=l2_miss+1;
		else if(l2_miss_sig&&l2_miss>l2_total+1)
			l2_miss<=1;
		if((read_l2|write_l2)==1'b1&&resp_l2)
			l2_total<=l2_total+1;
		/*Icache Dcache conflict*/
		if((read_I&&read_D)||(read_I&&write_D))
			ID_conf<=ID_conf+1;
		flush_buff<=flush;
	end
end

endmodule : performance_unit
