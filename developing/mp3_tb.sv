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
logic [3:0] wmask;
logic [31:0] address;
logic [31:0] wdata;
logic resp;
logic [31:0] rdata;
     
mp3 mp3
(
    .clk,
    .read,
    .write,
    .wmask,
    .address,
    .wdata,
    .resp,
    .rdata
);

magic_memory magic_memory
(
    .clk,
    .read,
    .write,
    .wmask,
    .address,
    .wdata,
    .resp,
    .rdata
);

endmodule : mp3_tb

