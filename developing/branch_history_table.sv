module branch_history_table  #(parameter history_bits = 2) // history num = 2 ^ history_bits
(
    input clk,
    input branch_result,
    input update,
    input flush,
    output prediction // 1 = take
);

logic signed [history_bits:0] branch_history;
logic signed [history_bits:0] branch_hist_max;
logic signed [history_bits:0] branch_hist_min;
assign branch_hist_max = 1'b1 << (history_bits-1'b1) - 1'b1;
assign branch_hist_min = -(1'b1 << (history_bits-1'b1));

initial begin
    branch_history = 0;
end
always_ff @ (posedge clk) begin
    if (flush)
        branch_history = 0;
    if (update)
        if (branch_result == 1) begin
            if (branch_history != branch_hist_max) 
                branch_history = branch_history + 1'b1;    
        end     
        else 
            if (branch_history != branch_hist_min)
                branch_history = branch_history - 1'b1;   
end

assign prediction = (branch_history >= 0) ;

endmodule