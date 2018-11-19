module L1Icache_data_assembler
(
	input [7:0] datain [32],
	input [4:0] index,
	output logic [31:0] dataout
);

	logic [2:0] word_index;
	
always_comb
begin
	word_index = index[4:2];
	case(word_index)
		default:;
		3'b000:
		begin
			dataout = {datain[3], datain[2], datain[1], datain[0]};
		end
		3'b001:
		begin
			dataout = {datain[7], datain[6], datain[5], datain[4]};
		end
		3'b010:
		begin
			dataout = {datain[11], datain[10], datain[9], datain[8]};
		end
		3'b011:
		begin
			dataout = {datain[15], datain[14], datain[13], datain[12]};
		end
		3'b100:
		begin
			dataout = {datain[19], datain[18], datain[17], datain[16]};
		end
		3'b101:
		begin
			dataout = {datain[23], datain[22], datain[21], datain[20]};
		end
		3'b110:
		begin
			dataout = {datain[27], datain[26], datain[25], datain[24]};
		end
		3'b111:
		begin
			dataout = {datain[31], datain[30], datain[29], datain[28]};
		end
	endcase
end

endmodule	: L1Icache_data_assembler