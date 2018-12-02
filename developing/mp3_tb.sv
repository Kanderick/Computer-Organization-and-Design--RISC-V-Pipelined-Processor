import rv32i_types::*;

module mp3_tb;
timeunit 1ns;
timeprecision 1ns;
logic clk;
logic halt; 

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;



assign halt = ((mp3.mp3_cpu.rdata_a == 32'h00000063) | (mp3.mp3_cpu.rdata_a == 32'h0000006F));

logic read;
logic write;
logic [31:0] address;
logic [255:0] wdata;
logic resp;
logic [255:0] rdata;
logic clk_by_2;
mp3 mp3
(
    .clk,
    .read,
    .write,
    .address,
    .wdata,
    .resp,
    .rdata
);

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

endmodule : mp3_tb

