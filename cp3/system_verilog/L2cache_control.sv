module L2cache_control
(
	input clk,
	
	input mem_read,
	input mem_write,
	input pmem_resp,
	
	/*input from cache_datapath*/
	input hit,
	input dirty,
	
	output logic mem_resp,
	output logic pmem_read,
	output logic pmem_write,
	
	/*output to cache_datapath*/
	output logic pmem_addr_sel,
	output logic load_lru,
	output logic load_tag,
	output logic load_data,
	output logic load_valid,
	output logic data_in_sel,
	output logic set_dirty,
	output logic clr_dirty
);

enum int unsigned {
    /* List of states */
	 idle,
	 write_to_pmem,
	 pmem_to_cache
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	 pmem_addr_sel = 1;
	 load_lru = 0;
	 load_tag = 0;
	 load_data = 0;
	 load_valid = 0;
	 data_in_sel = 0;
	 set_dirty = 0;
	 clr_dirty = 0;
	 pmem_read = 0;
	 pmem_write = 0;
	 mem_resp = 0;
	 
	 /*Actions for each state*/
	case(state)
		default:;
		
		idle:
		begin
			if (hit && mem_read)
			begin
				load_lru = 1;
				mem_resp = 1;
			end
			
			else if (hit && mem_write && dirty)
			begin
				load_data = 1;
				data_in_sel = 1;
				load_lru = 1;
				mem_resp = 1;
			end
			
			else if (hit && mem_write && (!dirty))
			begin
				load_data = 1;
				data_in_sel = 1;
				set_dirty = 1;
				load_lru = 1;
				mem_resp = 1;
			end
			
			else
			begin
			end
		end
		
		write_to_pmem:
		begin
			pmem_addr_sel = 1;
			pmem_write = 1;
			clr_dirty = 1;
		end
		
		pmem_to_cache:
		begin
			pmem_addr_sel = 0;
			pmem_read = 1;
			data_in_sel = 0;
			load_tag = pmem_resp;
			load_data = pmem_resp;
			load_valid = 1;
			clr_dirty = 1;
		end
	endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	next_state = state;
	case(state)
		default:	next_state = idle;
		idle:
		begin
			if ((mem_read || mem_write) && (!hit) && (dirty))
				next_state = write_to_pmem;
			else if ((mem_read || mem_write) && (!hit) && (!dirty))
				next_state = pmem_to_cache;
			else
				next_state = idle;
		end
		
		write_to_pmem:
		begin
			if (pmem_resp)
				next_state = pmem_to_cache;
			else
				next_state = write_to_pmem;
		end
		
		pmem_to_cache:
		begin
			if (pmem_resp)
				next_state = idle;
			else
				next_state = pmem_to_cache;
		end
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : L2cache_control