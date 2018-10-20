module ID_pipe
(
	input [31:0] IF_pc,
	output logic [31:0] ID_pc,
	input clk,
	input reset
);

always_ff @ (posedge clk) begin

	if(reset) begin
		ID_pc<=0;
	end
	else begin
		ID_pc<=IF_pc;
	end

end
endmodule : ID_pipe