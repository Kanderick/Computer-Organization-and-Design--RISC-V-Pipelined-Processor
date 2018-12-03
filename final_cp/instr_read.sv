import rv32i_types::*;

module instr_read
(
    input load_pc,
    input rv32i_word IF_addr,
    //icache signal
    output logic icache_read,
    input icache_resp,
    input rv32i_word icache_rdata,
    //stall signal
    output rv32i_word instr_out;
);

logic last_IF_addr;

always_comb begin
    next_state = state;
    case(state)
        ready:
            if (icache_read && !icache_resp)
                next_state = read;
        read:
    endcase
end

always_comb begin
    icache_read = 0;
    case(state)
        idle:
            if (last_IF_addr != IF_addr)
                icache_read = 1; 
        read:
            if 
    endcase
end

always_ff begin
    
    
end
endmodule