
module array #(parameter width = 256, parameter idx_bits = 3)
(
    input clk,
    input write,
    input [idx_bits-1:0] index,
    input [width-1:0] datain,
    output logic [width-1:0] dataout
);

localparam data_size = 1 << idx_bits;
logic [width-1:0] data [data_size-1:0] /* synthesis ramstyle = "logic" */;

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[index] = datain;
    end
end

assign dataout = data[index];

endmodule : array

