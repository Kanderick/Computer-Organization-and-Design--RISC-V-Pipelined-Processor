import rv32i_types::*;

module dual_port_array #(parameter idx_bits = 4, parameter way_bits=2)
(
    input clk,
    input write,
    input [idx_bits-1:0] read_only_index,
	 input [idx_bits-1:0] read_write_index,
    input array_signals  write_datain,
	 output array_signals read_only_dataout,
    output array_signals read_write_dataout,
	 /* bracnch prediction table signals*/
	 input branch_result,
	 input update,
	 input replace,
	 output logic BHT_prediction
);

localparam data_size = 1 << idx_bits;
array_signals  data [data_size]; 
logic BHT_prediction_array[data_size];
/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 0;
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[read_write_index] = write_datain;
    end
end
always_comb
begin
	BHT_prediction = BHT_prediction_array[read_only_index];
end
genvar i;
generate
	for (i=0; i<data_size; i++) begin : branch_history_table
		branch_history_table local_hist_table(
            .clk,
            .branch_result,
            .update(update),
            .flush(replace),
            .prediction(BHT_prediction_array[i])  
        );
	end
endgenerate
assign read_only_dataout = data[read_only_index];
assign read_write_dataout = data[read_write_index];

endmodule : dual_port_array

