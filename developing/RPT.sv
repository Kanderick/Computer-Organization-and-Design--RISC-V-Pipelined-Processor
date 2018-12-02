module RPT // reference predition table
(
	input clk,
	// read & generate prefetching
	input [31:0] IF_PC,
	input new_instr,
	output logic [31:0] ORB, // outstanding request buffer
	output logic prefetch_en,
	// modify & update RPT on L2 data missing
	input [31:0] MEM_addr,
	input if_MEM_datamiss,
	input [31:0] MEM_PC
	
);

logic [2:0] set;
logic [4:0] offset;
logic hit; 
logic update_enable;
assign set=(!update_enable)?IF_PC[7:5]:MEM_PC[7:5];
assign offset=(!update_enable)?IF_PC[4:0]:MEM_PC[4:0];

// tag array
logic [23:0] tag_out [32];
logic [1:0] state_out [32];
logic [31:0] prev_addr_out [32];
logic [31:0] stride_out [32];
logic [31:0] load;
logic [23:0] tag_in;
logic [1:0] state_in;
logic [31:0] prev_addr_in;
logic [31:0] stride_in;
logic control_load;
logic if_predict_right;

initial
begin
	update_enable=0;
	hit=0;
	load=0;
	if_predict_right=0;
end


always_comb
begin
	hit=(tag_out[offset]==IF_PC[31:8]);
	prefetch_en=hit&(state_out[offset]==2'b10);
	ORB=prev_addr_out[offset]+stride_out[offset];
	tag_in=MEM_PC[31:8];
	prev_addr_in=MEM_addr;
	stride_in=MEM_addr-prev_addr_out[offset];
	if_predict_right=(MEM_addr==ORB);
	load=update_enable<<offset;
	// 00    01     10      11
	// init  trans steady no-pre
	case(state_out[offset])
		2'b0:
		begin
			if(if_predict_right)
				state_in=2'b10;
			else
				state_in=2'b01;
		end
		2'b01:
		begin
			if(if_predict_right)
				state_in=2'b10;
			else
				state_in=2'b11;
		end
		2'b10:
		begin
			if(if_predict_right)
				state_in=2'b10;
			else
				state_in=2'b00;
		end
		2'b11:
		begin
			if(if_predict_right)
				state_in=2'b01;
			else
				state_in=2'b11;
		end
		default:
		begin
			state_in=0;
		end
	endcase
end

genvar i;
generate
	for(i=0; i<32; i=i+1) begin : generate_prev_addr
		array #(.width(32)) prev_addr(
		  .clk,
        .write(load[i]),
        .index(set),
        .datain(prev_addr_in),
        .dataout(prev_addr_out[i])
		);
	end

	for(i=0; i<32; i=i+1) begin : generate_stride
		array #(.width(32)) stride(
		  .clk,
        .write(load[i]),
        .index(set),
        .datain(stride_in),
        .dataout(stride_out[i])
		);
	end
	
	// 00    01     10      11
	// init  trans steady no-pre
	for(i=0; i<32; i=i+1) begin : generate_state
		array #(.width(4)) state(
		  .clk,
        .write(load[i]),
        .index(set),
        .datain(state_in),
        .dataout(state_out[i])
		);
	end
	for(i=0; i<32; i=i+1) begin : generate_tag
	array #(.width(24)) tag(
		.clk,
      .write(load[i]),
      .index(set),
      .datain(tag_in),
      .dataout(tag_out[i])
	);
	end
endgenerate




/*below is the finite state machine*/
enum int unsigned {
    /* List of states */
	 check_IF_PC, // the ROT cannot be updated during this 
	 done_check,
	 update_RPT,
	 done_update_RPT
} state, next_state;

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end
initial
begin
	next_state=check_IF_PC;
end
/*state transition*/
always_comb
begin
	next_state=state;
	case(state)
		check_IF_PC:
		begin
			if(if_MEM_datamiss)
				next_state=update_RPT;
		end
		update_RPT:
		begin
			next_state=done_update_RPT;
		end
		done_update_RPT:
		begin
			if(!if_MEM_datamiss)
				next_state=check_IF_PC;
		end
		default:
		begin
		end
	endcase
end

/*state implementation*/
always_comb
begin
		update_enable=0;
		case(state)
		check_IF_PC:
		begin
		end
		update_RPT:
		begin
			update_enable=1;
		end
		done_update_RPT:
		begin
			
		end
		default:
		begin
		end
	endcase
end
endmodule : RPT