module victim_cache_control
(
	input clk,
	
	input l2_vc_read,
	input l2_vc_write,
	output logic l2_vc_resp,
	
	output logic vc_pmem_read,
	output logic vc_pmem_write,
	input vc_pmem_resp,
	
	input hit,
	output logic update_victim,
	output logic rdata_sel,
	
	input valid_lru_way
);

	logic [15:0] readhit_count;
	
initial
begin
	readhit_count = 0;
end

/*States*/
enum int unsigned {
    idle,
    write_request,
    readhit,
	 readmiss,
	 readmiss_hold
} state, next_state;


always_comb
begin	: state_actions
	l2_vc_resp = vc_pmem_resp;
	vc_pmem_read = 0;
	vc_pmem_write = 0;
	update_victim = 0;
	rdata_sel = 1;
	
	case (state)
		default:;
		
		idle:;
		
		write_request:
		begin
			vc_pmem_write = 1;
		end
		
		readhit:
		begin
			rdata_sel = 0;
			update_victim = 1;
			l2_vc_resp = 1;
		end
		
		readmiss:
		begin
			vc_pmem_read = 1;
			update_victim = 1;
		end
		
		readmiss_hold:
		begin
			vc_pmem_read = 1;
			update_victim = 0;
		end
	endcase
end

always_comb
begin	: next_state_logic
	next_state = state;
	
	case(state)
		default: next_state = idle;
		
		idle:
		begin
			if (l2_vc_write) next_state = write_request;
			else if (l2_vc_read && hit) next_state = readhit;
			//else if (l2_vc_read && !hit) next_state = readmiss;
			else if (l2_vc_read && !hit && valid_lru_way) next_state = readmiss;
			else if (l2_vc_read && !hit && !valid_lru_way) next_state = readmiss_hold;
		end
		
		write_request:
		begin
			if (vc_pmem_resp) next_state = idle;
		end
		
		readhit:
		begin
			next_state = idle;
		end
		
		readmiss:
		begin
			next_state = readmiss_hold;
		end
		
		readmiss_hold:
		begin
			if (vc_pmem_resp) next_state = idle;
		end
	endcase

end

always_ff @(posedge clk)
begin: next_state_assignment
    state <= next_state;
	 if (state == readhit)
		readhit_count += 1'b1;
end

endmodule	: victim_cache_control