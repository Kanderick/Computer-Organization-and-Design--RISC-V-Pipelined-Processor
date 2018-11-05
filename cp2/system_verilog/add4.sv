module add4 #(parameter width = 32)
(
input logic [width-1:0] a,
output logic [width-1:0] f
);

always_comb
begin
	f = a + 4;
end

endmodule : add4
