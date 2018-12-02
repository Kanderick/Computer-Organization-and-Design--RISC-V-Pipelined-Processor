`define GRACE_TIME 20
module prefetcher
(
	input clk,
	input [31:0] ORB,
	input prefetch_en,
	// L2 cache
	input [31:0] L2_req_address,
	input L2_req_read,
	input L2_req_write,
	input [255:0] L2_req_wdata,
	output logic [255:0] L2_req_rdata,
	output logic L2_req_resp,
	// pmem
	output logic [31:0] pmem_address,
	output logic pmem_read,
	output logic pmem_write,
	input logic [255:0] pmem_rdata,
	output logic  [255:0] pmem_wdata,
	input logic pmem_resp
);

reg [31:0] PREFETCH_COUNTER;
reg [31:0] prefetch_addr[4];
reg [255:0] prefetch_data[4];
reg [3:0]prefetch_data_valid;
reg [3:0]prefetch_data_ready;	
reg [1:0] list_update_counter;
logic data_ready_enable; // busy bit to block new data_ready when current data is process
logic prefetch_counter_reset;
logic prefetch_counter_accum;
logic cmp_0;
logic cmp_1;
logic cmp_2;
logic cmp_3;
logic hit;
logic [1:0] hit_index;
logic load_ORB;
logic suc;
initial
begin
	PREFETCH_COUNTER=0;
	prefetch_data_ready=0;
	prefetch_data_valid=0;
	list_update_counter=0;
end

always_comb
begin
	cmp_0=prefetch_addr[0]==L2_req_address;
	cmp_1=prefetch_addr[1]==L2_req_address;
	cmp_2=prefetch_addr[2]==L2_req_address;
	cmp_3=prefetch_addr[3]==L2_req_address;
	if(cmp_0&&prefetch_data_valid[0])
	begin 
		hit=1'b1;
		hit_index=0;
	end
	else if(cmp_1&&prefetch_data_valid[1])
	begin
		hit=1'b1;
		hit_index=2'b01;
	end
	else if(cmp_2&&prefetch_data_valid[2])
	begin
		hit=1'b0;
		hit_index=2'b10;
	end
	else if(cmp_3&&prefetch_data_valid[3])
	begin
		hit=1'b0;
		hit_index=2'b11;
	end
	else 
	begin
		hit=1'b0;
		hit_index=0;
	end

end

/*below is the finite state machine*/
enum int unsigned {
    /* List of states */
	 idle,
	 prefetch,
	 L2_miss,
	 check_hit,
	 hit_shake_hand
} state, next_state;

/*state implementaion*/
always_comb
begin
	data_ready_enable=1'b0;
	prefetch_counter_reset=1'b0;
	prefetch_counter_accum=1'b0;
	suc=1'b0;
	/*
	L2
	input [31:0] L2_req_address,
	input L2_req_read,
	input L2_req_write,
	input [255:0] L2_req_wdata
	output logic [255:0] L2_req_rdata,
	output logic L2_req_resp
	pmem
	output logic [31:0] pmem_address,
	output logic pmem_read,
	output logic pmem_write,
	input logic [255:0] pmem_rdata,
	output logic  [255:0] pmem_wdata,
	input logic pmem_resp
	*/
	pmem_address=L2_req_address;
	pmem_read=1'b0;
	pmem_write=1'b0;
	pmem_wdata=L2_req_wdata;
	L2_req_rdata=pmem_rdata;
	L2_req_resp=1'b0;
	load_ORB=1'b0;
	case(state)
		idle:
		begin
			prefetch_counter_reset=1'b1;
			if( (L2_req_read|L2_req_write)==0 && prefetch_en)		
				load_ORB=1'b1;
		end
		prefetch:
		begin
			prefetch_counter_accum=1'b1;
			if(pmem_resp)
			begin
				data_ready_enable=1'b1;
			end
			pmem_address=prefetch_addr[list_update_counter];
			pmem_read=1'b1;
			pmem_write=1'b0;
		end
		L2_miss:
		begin
			prefetch_counter_reset=1'b1;
			pmem_address=L2_req_address;
			pmem_read=L2_req_read;
			pmem_write=L2_req_write;
			pmem_wdata=L2_req_wdata;
			L2_req_rdata=pmem_rdata;
			L2_req_resp=pmem_resp;
		end
		check_hit:
		begin
			
		end
		hit_shake_hand:
		begin
			prefetch_counter_reset=1'b1;
			L2_req_rdata=prefetch_data[hit_index];
			L2_req_resp=1'b1;
			suc=1'b1;
		end
		default:
		begin
		end
	
	endcase;
end
/*state transition*/
always_comb
begin
	next_state=state;
	case(state)
		idle:
		begin
			if(L2_req_read|L2_req_write)
			begin
				next_state=check_hit;
			end
			else if(prefetch_en)
				next_state=prefetch;
			else if(prefetch_data_ready[list_update_counter]==1'b0 && prefetch_data_valid[list_update_counter])
				next_state=prefetch;
			
		end
		prefetch:
		begin
			if(L2_req_read|L2_req_write && PREFETCH_COUNTER<=`GRACE_TIME)
			begin
					next_state=check_hit;
			end
			else if(pmem_resp)
			begin
				next_state=idle;
			end
		end
		L2_miss:
		begin
			if(pmem_resp)
			begin
				next_state=idle;
			end
		end
		check_hit:
		begin
			// no need to fetch from pmem
			if(hit && prefetch_data_ready[hit_index] && !L2_req_write)
			begin
				next_state=hit_shake_hand;
			end
			// need to fetch from pmem
			else 
				next_state=L2_miss;
		end
		hit_shake_hand:
		begin
			next_state=idle;
		end
		default:
		begin
		end
	
	endcase;
end

always_ff @(posedge clk)
begin
	state<=next_state;
	// update prefetch_addr
	if(load_ORB)
	begin
		prefetch_addr[list_update_counter+2'b1]<=ORB;
		list_update_counter<=list_update_counter+2'b01;
		//list_prefetch_counter<=list_update_counter;
		prefetch_data_valid[list_update_counter+2'b1]<=1'b1;
		prefetch_data_ready[list_update_counter+2'b1]<=1'b0;
	end
	// prefetch data ready
	if(data_ready_enable)
	begin
		prefetch_data_ready[list_update_counter]<=1'b1;
		prefetch_data[list_update_counter]<=pmem_rdata;
	end
	
	if(prefetch_counter_accum)
		PREFETCH_COUNTER<=PREFETCH_COUNTER+1;
	else if(prefetch_counter_reset)
		PREFETCH_COUNTER<=0;
end
endmodule : prefetcher