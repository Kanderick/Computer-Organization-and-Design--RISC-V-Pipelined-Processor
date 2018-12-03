module L1Icache_control
(
	input clk,
	
	input cpu_l1i_read,
	output logic cpu_l1i_resp,
	output logic l1i_arbi_read,
	input l1i_arbi_resp,
	
	/*From and to L1Icache_datapath*/
	input hit,
	
	output logic ld_lru,
	output logic ld_tag,
	output logic ld_valid,
	output logic ld_data,
	/*performance tracking*/
	output logic l1i_miss_sig
);

enum int unsigned {
    /* List of states */
	 idle,
	 fetch_from_arbitor
} state, next_state;

always_comb
begin : state_actions
	/* Default output assignments */
	ld_lru = 0;
	ld_tag = 0;
	ld_valid = 0;
	ld_data = 0;
	l1i_arbi_read = 0;
	cpu_l1i_resp = 0;
	 
	/*Actions for each state*/
	case(state)
		default:;
		
		idle:
		begin
			if (cpu_l1i_read && hit)
			begin
				ld_lru = 1;
				cpu_l1i_resp = 1;
			end
		end
		
		fetch_from_arbitor:
		begin
			l1i_arbi_read = 1;
			ld_tag = l1i_arbi_resp;
			ld_data = l1i_arbi_resp;
			ld_valid = l1i_arbi_resp;
		end
	endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	next_state = state;
	l1i_miss_sig=0;
	case(state)
		default: next_state = idle;
		
		idle:
		begin
			if (cpu_l1i_read && (!hit))
			begin
				next_state = fetch_from_arbitor;
				l1i_miss_sig=1'b1;
			end
			else
				next_state = idle;
		end
		
		fetch_from_arbitor:
		begin
			
			if (l1i_arbi_resp)
				next_state = idle;
			else
				next_state = fetch_from_arbitor;
		end
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule	: L1Icache_control