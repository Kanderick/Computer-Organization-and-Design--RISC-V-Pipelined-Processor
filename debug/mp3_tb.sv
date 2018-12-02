import rv32i_types::*;
//`define NO_CACHE
module mp3_tb;
timeunit 1ns;
timeprecision 1ns;
logic clk;
logic halt; 

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;



assign halt = ((mp3.mp3_cpu.rdata_a == 32'h00000063) | (mp3.mp3_cpu.rdata_a == 32'h0000006F));
`ifndef NO_CACHE
logic read;
logic write;
logic [31:0] address;
logic [255:0] wdata;
logic resp;
logic [255:0] rdata;
logic clk_by_2;
`endif
`ifdef NO_CACHE
logic read;
logic write;
logic [31:0] address;
logic [31:0] wdata;
logic resp;
logic [31:0] rdata;
logic [3:0] wmask;
`endif

mp3 mp3
(
    .clk,
    .read,
    .write,
    .address,
    .wdata,
    .resp,
    .rdata
	 `ifdef NO_CACHE
	 ,
	 .wmask
	 `endif
);

`ifndef NO_CACHE
physical_memory physical_memory
(
    .clk,
    .read,
    .write,
    .address,
    .wdata,
    .resp,
    .rdata
);
`endif
`ifdef NO_CACHE
memory memory
(
    .clk,

    /* Port A */
    .read ,
    .write ,
    .wmask ,
    .address ,
    .wdata ,
    .resp,
    .rdata
);

`endif 
endmodule : mp3_tb

