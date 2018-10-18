import rv32i_types::*; /* Import types defined in rv32i_types.sv */

module rdata_out_logic(
	input [2:0] funct3;
	input [31:0] data_in;
	output logic [31:0] data_out;
);

load_funct3_t load_op;
assign load_op = load_funct3_t'(funct3);

always_comb
begin
	case(load_op)
		lb:
		begin	
			data_out = {{25{data_in[7]}},data_in[6:0]};
		end
		lh:
		begin
			data_out = {{17{data_in[15]}}, data_in[14:0]};
		end
		lw:
		begin
			data_out = data_in;
		end
		lbu:
		begin
			data_out = {24'b0,data_in[7:0]};
		end
		lhu:
		begin
			data_out = {16'b0, data_in[15:0]};
		end
		default:
		begin
			data_out = data_in;
		end
	endcase
end

endmodule	: rdata_out_logic