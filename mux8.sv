module mux8 #(parameter width = 32)
(
		input [2:0] sel,
		input [width-1:0] a, b, c, d, e, f, g, h, 
		output logic [width-1:0] o
);
always_comb
begin
	case(sel)
	3'b000:
	begin
		o = a;
	end
	3'b001:
	begin
		o = b;
	end
	3'b010:
	begin
		o = c;
	end
	3'b011:
	begin
		o = d;
	end
	3'b100:
	begin
		o = e;
	end
	3'b101:
	begin
		o = f;
	end
	3'b110:
	begin
		o = g;
	end
	3'b111:
	begin
		o = h;
	end
	default:
	begin
		o = 0;
	end
	endcase 
end
endmodule : mux8