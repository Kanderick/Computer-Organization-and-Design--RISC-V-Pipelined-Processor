//import rv32i_types::*; /* Import types defined in rv32i_types.sv */
module performance_unit_user_enable
(
	input clk,
	input reset,
	input if_stall,
	input resp_l2,
	/*br miss prediction*/
	input flush,
	input [1:0] jb_sel,
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
	input write_D,
	/*user interface*/
	output logic cpu_l1d_read,
	input [31:0] address_b,
	output logic [31:0] cpu_l1d_address,
	input [31:0] cpu_l1d_rdata,
	output logic [31:0] rdata_b,
	output logic resp_b,
	input cpu_l1d_resp
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
reg [31:0] ID_conf;	 /*l1d_arbi_address==32'h8*/
reg [31:0] total_stall;	 /*l1d_arbi_address==32'h9*/
/*edge detection buffer*/
reg flush_buff;
/*real read detection*/
logic read_b_sig;

assign read_b_sig=(read_b&(address_b>32'h8));

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
	total_stall=0;
end
always_comb
begin
	if(read_b&&address_b<=32'h9)
	begin
		resp_b=1'b1;
		cpu_l1d_read=0;
		cpu_l1d_address=0;
		if(address_b==32'h0)
		begin
			rdata_b=br_miss;
		end
		else if(address_b==32'h1)
		begin
			rdata_b=br_total;
		end
		else if(address_b==32'h2)
		begin
			rdata_b=l1i_miss;
		end
		else if(address_b==32'h3)
		begin
			rdata_b=l1i_total;
		end
		else if(address_b==32'h4)
		begin
			rdata_b=l1d_miss;
		end
		else if(address_b==32'h5)
		begin
			rdata_b=l1d_total;
		end
		else if(address_b==32'h6)
		begin
			rdata_b=l2_miss;
		end
		else if(address_b==32'h7)
		begin
			rdata_b=l2_total;
		end
		else if(address_b==32'h8)
		begin
			rdata_b=ID_conf;
		end
		else if(address_b==32'h9)
		begin
			rdata_b=total_stall;
		end
		else
		begin
			rdata_b=ID_conf;
		end
	end
	else
	begin
		cpu_l1d_read=read_b;
		cpu_l1d_address=address_b;
		rdata_b=cpu_l1d_rdata;
		resp_b=cpu_l1d_resp;
	end
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
		total_stall<=0;
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
		if((read_b_sig|write_b)==1'b1&&!if_stall)
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
		if(if_stall)
			total_stall<=total_stall+1;
		flush_buff<=flush;
	end
end

endmodule : performance_unit_user_enable