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
//--------------------------------------------------------------------

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
/*
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
*/

always_comb begin
    cache_sel = 0;
    case(state)
        idle:
            cache_sel = icache_read? 1'b0 : 1'b1;
        serving_dcache:
            cache_sel = 1;
		  serving_icache:
				cache_sel = 0;
        default: ;
    endcase 
end
always_comb begin
    next_state = state;
    case(state)
        idle: if (icache_read &!L2cache_resp) 
                next_state = serving_icache;
				  else if ((dcache_read|dcache_write) &!L2cache_resp)	
					next_state = serving_dcache;
        serving_icache: 
              if (L2cache_resp) 
                next_state = idle;
        serving_dcache:
              if (L2cache_resp) 
                next_state = idle;
        default: ;
    endcase
end
always_ff @ (posedge clk) begin
    state <= next_state;     
end
endmodule : arbitor_controller
//--------------------------------------------------------------------



//--------------------------------------------------------------------
module arbitor_with_reg  #(parameter width = 32)
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

    logic internal_L2cache_read;
    logic internal_L2cache_write;
    rv32i_word internal_L2cache_address;
    logic [width-1:0] internal_L2cache_wdata;
    logic [3:0] internal_L2cache_byte_enable; //remember to comment it out
    //logic [width-1:0] internal_L2cache_rdata;
    //logic internal_L2cache_resp;    

	arbitor  #(.width(width)) arbitor
	(
		 .clk,
		 // instruction cache signal
		 .icache_read,
		 .icache_address,
		 .icache_rdata,
		 .icache_resp,
		 
		 // data cache signal
		 .dcache_read,
		 .dcache_write,    
		 .dcache_address,
		 .dcache_wdata,
		 .dcache_byte_enable, //remember to comment it out
		 .dcache_rdata,
		 .dcache_resp,

		 //L2 cache signal
		 .L2cache_read(internal_L2cache_read),
		 .L2cache_write(internal_L2cache_write),
		 .L2cache_address(internal_L2cache_address),
		 .L2cache_wdata(internal_L2cache_wdata),
		 .L2cache_byte_enable(internal_L2cache_byte_enable), //remember to comment it out
		 .L2cache_rdata(L2cache_rdata), // connect directly for now
		 .L2cache_resp(L2cache_resp)   // connect directly for now     
	);

	mem_access_regslice  #(.width(width)) arbitor_L2_regslice
	(
		 .clk,

		 //L2 cache signal
		 .L2cache_read(internal_L2cache_read),
		 .L2cache_write(internal_L2cache_write),
		 .L2cache_address(internal_L2cache_address),
		 .L2cache_wdata(internal_L2cache_wdata),
		 .L2cache_byte_enable(internal_L2cache_byte_enable), //remember to comment it out
		 //.L2cache_rdata_reg(internal_L2cache_rdata),
		 //.L2cache_resp_reg(internal_L2cache_resp),      

		 //L2 cache signalreg
		 .L2cache_read_reg(L2cache_read),
		 .L2cache_write_reg(L2cache_write),
		 .L2cache_address_reg(L2cache_address),
		 .L2cache_wdata_reg(L2cache_wdata),
		 .L2cache_byte_enable_reg(L2cache_byte_enable), //remember to comment it out
		 .L2cache_rdata(L2cache_rdata),
		 .L2cache_resp(L2cache_resp),  
		
		 .custom_signal(),
	    .custom_signal_2(),
		 .custom_signal_reg(),
	    .custom_signal_2_reg()	 
	);
		 
endmodule

 
	 

