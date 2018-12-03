module L1Dcache_data_assembler
(
	input [7:0] datain [32],
	input [4:0] index,
	output logic [31:0] dataout
);
	
always_comb
begin
	case(index)
		default:;
		5'b00000:
		begin
			dataout = {datain[3], datain[2], datain[1], datain[0]};
		end
		5'b00001:
		begin
			dataout = {datain[4], datain[3], datain[2], datain[1]};
		end
		5'b00010:
		begin
			dataout = {datain[5], datain[4], datain[3], datain[2]};
		end
		5'b00011:
		begin
			dataout = {datain[6], datain[5], datain[4], datain[3]};
		end
		
		5'b00100:
		begin
			dataout = {datain[7], datain[6], datain[5], datain[4]};
		end
		5'b00101:
		begin
			dataout = {datain[8], datain[7], datain[6], datain[5]};
		end
		5'b00110:
		begin
			dataout = {datain[9], datain[8], datain[7], datain[6]};
		end
		5'b00111:
		begin
			dataout = {datain[10], datain[9], datain[8], datain[7]};
		end
		
		5'b01000:
		begin
			dataout = {datain[11], datain[10], datain[9], datain[8]};
		end
		5'b01001:
		begin
			dataout = {datain[12], datain[11], datain[10], datain[9]};
		end
		5'b01010:
		begin
			dataout = {datain[13], datain[12], datain[11], datain[10]};
		end
		5'b01011:
		begin
			dataout = {datain[14], datain[13], datain[12], datain[11]};
		end
		
		5'b01100:
		begin
			dataout = {datain[15], datain[14], datain[13], datain[12]};
		end
		5'b01101:
		begin
			dataout = {datain[16], datain[15], datain[14], datain[13]};
		end
		5'b01110:
		begin
			dataout = {datain[17], datain[16], datain[15], datain[14]};
		end
		5'b01111:
		begin
			dataout = {datain[18], datain[17], datain[16], datain[15]};
		end
		
		5'b10000:
		begin
			dataout = {datain[19], datain[18], datain[17], datain[16]};
		end
		5'b10001:
		begin
			dataout = {datain[20], datain[19], datain[18], datain[17]};
		end
		5'b10010:
		begin
			dataout = {datain[21], datain[20], datain[19], datain[18]};
		end
		5'b10011:
		begin
			dataout = {datain[22], datain[21], datain[20], datain[19]};
		end
		
		5'b10100:
		begin
			dataout = {datain[23], datain[22], datain[21], datain[20]};
		end
		5'b10101:
		begin
			dataout = {datain[24], datain[23], datain[22], datain[21]};
		end
		5'b10110:
		begin
			dataout = {datain[25], datain[24], datain[23], datain[22]};
		end
		5'b10111:
		begin
			dataout = {datain[26], datain[25], datain[24], datain[23]};
		end
		
		5'b11000:
		begin
			dataout = {datain[27], datain[26], datain[25], datain[24]};
		end
		5'b11001:
		begin
			dataout = {datain[28], datain[27], datain[26], datain[25]};
		end
		5'b11010:
		begin
			dataout = {datain[29], datain[28], datain[27], datain[26]};
		end
		5'b11011:
		begin
			dataout = {datain[30], datain[29], datain[28], datain[27]};
		end
		
		5'b11100:
		begin
			dataout = {datain[31], datain[30], datain[29], datain[28]};
		end
		5'b11101:
		begin
			dataout = {8'b00000000, datain[31], datain[30], datain[29]};
		end
		5'b11110:
		begin
			dataout = {8'b00000000, datain[8'b00000000], datain[31], datain[30]};
		end
		5'b11111:
		begin
			dataout = {8'b00000000, datain[8'b00000000], datain[8'b00000000], datain[31]};
		end
	endcase
end

endmodule	: L1Dcache_data_assembler