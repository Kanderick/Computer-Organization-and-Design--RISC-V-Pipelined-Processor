module mux8 #(parameter width = 32)
(
	input [2:0] sel,
	input [width-1:0] a,
	input [width-1:0] b,
	input [width-1:0] c,
	input [width-1:0]	d,
	input [width-1:0]	e,
	input [width-1:0]	f,
	input [width-1:0]	g,
	input [width-1:0]	h,
	output logic [width-1:0] out
);

always_comb
begin
	case (sel)
		3'b000: out = a;
		3'b001: out = b;
		3'b010: out = c;
		3'b011: out = d;
		3'b100: out = e;
		3'b101: out = f;
		3'b110: out = g;
		default: out = h;
	endcase
end

endmodule : mux8