module pipe_control
(
    input flush,
    output IF_ID_flush,
   
);

enum int unsigned {
	 no_flush,
	 flush_1,
     flush_2,
} flush_state, flush_next_states;

always_comb begin
    flush_next_states = flush_state
    case(flush_state)
        no_flush: 
            if (flush):
                flush_next_states = flush_1;
        flush_1:
            flush_next_states = flush_2;
        flush_2:
            flush_next_states = no_flush;
        default: ;    
    endcase
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
    flush_state <= flush_next_states
end

endmodule
