module clk_divder
(
	input clk,
	output logic clk_by_2
);

initial
begin
	clk_by_2=1'b0;
end

always_ff @(posedge clk)
begin
	clk_by_2<=~clk_by_2;
end



endmodule : clk_divder