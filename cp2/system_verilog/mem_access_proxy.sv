/*
avoid repeated read/write to the mem after stall
*/
import rv32i_types::*;
module mem_access_proxy
(
    input clk,
    input stage_read,
    input stage_write,
    output logic mem_read,
    output logic mem_write,
    input mem_resp,
    input rv32i_word mem_rdata,
    input pipe_load,
    output rv32i_word stage_rdata,
    output logic stage_resp 
);

logic ack;
rv32i_word stored_rdata;

always_ff @(posedge clk) begin
    if (pipe_load) begin
        ack <= 0;
    end 
    else if (mem_resp) begin
        ack <= 1;
        stored_rdata <= mem_rdata;
    end    
end

always_comb begin
 stage_rdata = mem_rdata;
 stage_resp = mem_resp;
 mem_read = stage_read;
 mem_write = stage_write; 
 if (ack) begin
    stage_rdata = stored_rdata;
    stage_resp = 1'b1;
    mem_read = 1'b0;
    mem_write = 1'b0;  
 end
    
end

endmodule    