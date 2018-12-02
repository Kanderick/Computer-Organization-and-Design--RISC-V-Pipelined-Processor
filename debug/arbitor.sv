import rv32i_types::*;
module arbitor  #(parameter width = 32)
(
    input clk,
    // instruction cache signal
    input icache_read,
    input rv32i_word icache_address,
    output [width-1:0] icache_rdata,
    output logic icache_resp,
    
    // data cache signal
    input dcache_read,
    input dcache_write,    
    input rv32i_word dcache_address,
    input [width-1:0] dcache_wdata,
    input [3:0] dcache_byte_enable, //remember to comment it out
    output [width-1:0] dcache_rdata,
    output logic dcache_resp,

    //L2 cache signal
    output logic L2cache_read,
    output logic L2cache_write,
    output rv32i_word L2cache_address,
    output [width-1:0] L2cache_wdata,
    output logic [3:0] L2cache_byte_enable, //remember to comment it out
    input [width-1:0] L2cache_rdata,
    input logic L2cache_resp        
);

logic cache_sel;

decoder2 resp_decoder
(
    .i0(cache_sel),
    .en(L2cache_resp),
    .o0(icache_resp),
    .o1(dcache_resp)
);

mux2 #(.width(1)) read_mux
(
    .sel(cache_sel),
	.a(icache_read),
    .b(dcache_read),
	.f(L2cache_read)
);

mux2 #(.width(1)) write_mux
(
    .sel(cache_sel),
	.a(1'b0),
    .b(dcache_write),
	.f(L2cache_write)
);

mux2 #(.width(32)) addr_mux
(
    .sel(cache_sel),
	.a(icache_address),
    .b(dcache_address),
	.f(L2cache_address)
);

assign icache_rdata = L2cache_rdata;
assign dcache_rdata = L2cache_rdata;
assign L2cache_wdata = dcache_wdata;
assign L2cache_byte_enable = dcache_byte_enable; //remember to comment it out

arbitor_controller arbitor_controller
(
    .clk,
    .dcache_write,
    .icache_read,
    .dcache_read,
    .L2cache_resp,
    .cache_sel
);


endmodule

module arbitor_controller  
(
    input clk,
    input dcache_write,
    input icache_read,
    input dcache_read,
    input L2cache_resp,
    output logic cache_sel
);

enum int unsigned {
    idle,
    serving_icache,
    serving_dcache
} state, next_state;

always_comb begin
    next_state = state;
    case(state)
        idle: if (icache_read &!L2cache_resp) 
                next_state = serving_icache;
              else if (dcache_read | dcache_write &!L2cache_resp) 
                next_state = serving_dcache;
        serving_icache: 
              if (L2cache_resp &!
              (dcache_read | dcache_write)) 
                next_state = idle;
              else if (L2cache_resp & (dcache_read | dcache_write) )
                next_state = serving_dcache;
        serving_dcache:
              if (L2cache_resp &
                !icache_read) 
                next_state = idle;
              else if (L2cache_resp & icache_read) 
                next_state = serving_icache; 
        default: ;
    endcase
end

always_comb begin
    cache_sel = 0;
    case(state)
        idle:
            cache_sel = icache_read? 1'b0 : 1'b1;
        serving_dcache:
            cache_sel = 1;
        default: ;
    endcase 
end

always_ff @ (posedge clk) begin
    state <= next_state;     
end
endmodule : arbitor_controller