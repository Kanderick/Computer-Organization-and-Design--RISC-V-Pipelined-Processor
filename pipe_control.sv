module pipe_control
(
	/*add NOP*/
   input flush,
   output logic IF_ID_flush,
   /*freeze the pipes*/
	input read_intr_stall,
	input mem_access_stall,
	output logic load,
	input clk
);

enum int unsigned {
	 no_flush,
	 flush_1,
    flush_2
} flush_state, flush_next_states;

always_comb begin
    flush_next_states = flush_state;
    case(flush_state)
        no_flush: 
            if (flush)
                flush_next_states = flush_1;
        flush_1:
            flush_next_states = flush_2;
        flush_2:
            flush_next_states = no_flush;
        default: ;    
    endcase
	 load = (read_intr_stall|mem_access_stall)? 0: 1;
end

always_comb begin
    IF_ID_flush = 0;
    case(flush_state)
        flush_1:
            IF_ID_flush = 1;
        flush_2:
            IF_ID_flush = 1;
        default: ;          
    endcase
end

always_ff @ (posedge clk) begin
    flush_state <= flush_next_states;
end

endmodule
