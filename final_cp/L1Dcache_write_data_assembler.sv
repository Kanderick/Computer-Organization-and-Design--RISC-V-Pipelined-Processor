module L1Dcache_write_data_assembler
(
	input [4:0] index,
	input [3:0] mem_byte_enable,
	input [31:0] mem_wdata,
	
	input [7:0] data0 [32],
	input [7:0] data1 [32],
	
	output logic [7:0] data_in0 [32],
	output logic [7:0] data_in1 [32]
);

	logic [7:0] byte3;
	logic [7:0] byte2;
	logic [7:0] byte1;
	logic [7:0] byte0;
	
	logic enable3;
	logic enable2;
	logic enable1;
	logic enable0;
	
assign byte3 = mem_wdata[31:24];
assign byte2 = mem_wdata[23:16];
assign byte1 = mem_wdata[15:8];
assign byte0 = mem_wdata[7:0];

assign enable3 = mem_byte_enable[3];
assign enable2 = mem_byte_enable[2];
assign enable1 = mem_byte_enable[1];
assign enable0 = mem_byte_enable[0];

always_comb
begin
	data_in0 = data0;
	data_in1 = data1;

	case(index)
		default:;
		5'b00000:
		begin
			if (enable3)	begin data_in0[3] = byte3; data_in1[3] = byte3; end
			if (enable2)	begin data_in0[2] = byte2; data_in1[2] = byte2; end
			if (enable1)	begin data_in0[1] = byte1; data_in1[1] = byte1; end
			if (enable0)	begin data_in0[0] = byte0; data_in1[0] = byte0; end
		end
		5'b00001:
		begin
			if (enable3)	begin data_in0[4] = byte3; data_in1[4] = byte3; end
			if (enable2)	begin data_in0[3] = byte2; data_in1[3] = byte2; end
			if (enable1)	begin data_in0[2] = byte1; data_in1[2] = byte1; end
			if (enable0)	begin data_in0[1] = byte0; data_in1[1] = byte0; end
		end
		5'b00010:
		begin
			if (enable3)	begin data_in0[5] = byte3; data_in1[5] = byte3; end
			if (enable2)	begin data_in0[4] = byte2; data_in1[4] = byte2; end
			if (enable1)	begin data_in0[3] = byte1; data_in1[3] = byte1; end
			if (enable0)	begin data_in0[2] = byte0; data_in1[2] = byte0; end
		end
		5'b00011:
		begin
			if (enable3)	begin data_in0[6] = byte3; data_in1[6] = byte3; end
			if (enable2)	begin data_in0[5] = byte2; data_in1[5] = byte2; end
			if (enable1)	begin data_in0[4] = byte1; data_in1[4] = byte1; end
			if (enable0)	begin data_in0[3] = byte0; data_in1[3] = byte0; end
		end
		
		5'b00100:
		begin
			if (enable3)	begin data_in0[7] = byte3; data_in1[7] = byte3; end
			if (enable2)	begin data_in0[6] = byte2; data_in1[6] = byte2; end
			if (enable1)	begin data_in0[5] = byte1; data_in1[5] = byte1; end
			if (enable0)	begin data_in0[4] = byte0; data_in1[4] = byte0; end
		end
		5'b00101:
		begin
			if (enable3)	begin data_in0[8] = byte3; data_in1[8] = byte3; end
			if (enable2)	begin data_in0[7] = byte2; data_in1[7] = byte2; end
			if (enable1)	begin data_in0[6] = byte1; data_in1[6] = byte1; end
			if (enable0)	begin data_in0[5] = byte0; data_in1[5] = byte0; end
		end
		5'b00110:
		begin
			if (enable3)	begin data_in0[9] = byte3; data_in1[9] = byte3; end
			if (enable2)	begin data_in0[8] = byte2; data_in1[8] = byte2; end
			if (enable1)	begin data_in0[7] = byte1; data_in1[7] = byte1; end
			if (enable0)	begin data_in0[6] = byte0; data_in1[6] = byte0; end
		end
		5'b00111:
		begin
			if (enable3)	begin data_in0[10] = byte3; data_in1[10] = byte3; end
			if (enable2)	begin data_in0[9] = byte2;  data_in1[9] = byte2; end
			if (enable1)	begin data_in0[8] = byte1;  data_in1[8] = byte1; end
			if (enable0)	begin data_in0[7] = byte0;  data_in1[7] = byte0; end
		end
		
		5'b01000:
		begin
			if (enable3)	begin data_in0[11] = byte3; data_in1[11]= byte3; end
			if (enable2)	begin data_in0[10] = byte2; data_in1[10]= byte2; end
			if (enable1)	begin data_in0[9] = byte1;  data_in1[9] = byte1; end
			if (enable0)	begin data_in0[8] = byte0;  data_in1[8] = byte0; end
		end
		5'b01001:
		begin
			if (enable3)	begin data_in0[12] = byte3; data_in1[12] = byte3; end
			if (enable2)	begin data_in0[11] = byte2; data_in1[11] = byte2; end
			if (enable1)	begin data_in0[10] = byte1; data_in1[10] = byte1; end
			if (enable0)	begin data_in0[9] = byte0;  data_in1[9]  = byte0; end
		end
		5'b01010:
		begin
			if (enable3)	begin data_in0[13] = byte3; data_in1[13] = byte3; end
			if (enable2)	begin data_in0[12] = byte2; data_in1[12] = byte2; end
			if (enable1)	begin data_in0[11] = byte1; data_in1[11] = byte1; end
			if (enable0)	begin data_in0[10] = byte0; data_in1[10] = byte0; end
		end
		5'b01011:
		begin
			if (enable3)	begin data_in0[14] = byte3; data_in1[14] = byte3; end
			if (enable2)	begin data_in0[13] = byte2; data_in1[13] = byte2; end
			if (enable1)	begin data_in0[12] = byte1; data_in1[12] = byte1; end
			if (enable0)	begin data_in0[11] = byte0; data_in1[11] = byte0; end
		end
		
		5'b01100:
		begin
			if (enable3)	begin data_in0[15] = byte3; data_in1[15] = byte3; end
			if (enable2)	begin data_in0[14] = byte2; data_in1[14] = byte2; end
			if (enable1)	begin data_in0[13] = byte1; data_in1[13] = byte1; end
			if (enable0)	begin data_in0[12] = byte0; data_in1[12] = byte0; end
		end
		5'b01101:
		begin
			if (enable3)	begin data_in0[16] = byte3; data_in1[16] = byte3; end
			if (enable2)	begin data_in0[15] = byte2; data_in1[15] = byte2; end
			if (enable1)	begin data_in0[14] = byte1; data_in1[14] = byte1; end
			if (enable0)	begin data_in0[13] = byte0; data_in1[13] = byte0; end
		end
		5'b01110:
		begin
			if (enable3)	begin data_in0[17] = byte3; data_in1[17] = byte3; end
			if (enable2)	begin data_in0[16] = byte2; data_in1[16] = byte2; end
			if (enable1)	begin data_in0[15] = byte1; data_in1[15] = byte1; end
			if (enable0)	begin data_in0[14] = byte0; data_in1[14] = byte0; end
		end
		5'b01111:
		begin
			if (enable3)	begin data_in0[18] = byte3; data_in1[18] = byte3; end
			if (enable2)	begin data_in0[17] = byte2; data_in1[17] = byte2; end
			if (enable1)	begin data_in0[16] = byte1; data_in1[16] = byte1; end
			if (enable0)	begin data_in0[15] = byte0; data_in1[15] = byte0; end
		end
		
		5'b10000:
		begin
			if (enable3)	begin data_in0[19] = byte3; data_in1[19] = byte3; end
			if (enable2)	begin data_in0[18] = byte2; data_in1[18] = byte2; end
			if (enable1)	begin data_in0[17] = byte1; data_in1[17] = byte1; end
			if (enable0)	begin data_in0[16] = byte0; data_in1[16] = byte0; end
		end
		5'b10001:
		begin
			if (enable3)	begin data_in0[20] = byte3; data_in1[20] = byte3; end
			if (enable2)	begin data_in0[19] = byte2; data_in1[19] = byte2; end
			if (enable1)	begin data_in0[18] = byte1; data_in1[18] = byte1; end
			if (enable0)	begin data_in0[17] = byte0; data_in1[17] = byte0; end
		end
		5'b10010:
		begin
			if (enable3)	begin data_in0[21] = byte3; data_in1[21] = byte3; end
			if (enable2)	begin data_in0[20] = byte2; data_in1[20] = byte2; end
			if (enable1)	begin data_in0[19] = byte1; data_in1[19] = byte1; end
			if (enable0)	begin data_in0[18] = byte0; data_in1[18] = byte0; end
		end
		5'b10011:
		begin
			if (enable3)	begin data_in0[22] = byte3; data_in1[22] = byte3; end
			if (enable2)	begin data_in0[21] = byte2; data_in1[21] = byte2; end
			if (enable1)	begin data_in0[20] = byte1; data_in1[20] = byte1; end
			if (enable0)	begin data_in0[19] = byte0; data_in1[19] = byte0; end
		end
		
		5'b10100:
		begin
			if (enable3)	begin data_in0[23] = byte3; data_in1[23] = byte3; end
			if (enable2)	begin data_in0[22] = byte2; data_in1[22] = byte2; end
			if (enable1)	begin data_in0[21] = byte1; data_in1[21] = byte1; end
			if (enable0)	begin data_in0[20] = byte0; data_in1[20] = byte0; end
		end
		5'b10101:
		begin
			if (enable3)	begin data_in0[24] = byte3; data_in1[24] = byte3; end
			if (enable2)	begin data_in0[23] = byte2; data_in1[23] = byte2; end
			if (enable1)	begin data_in0[22] = byte1; data_in1[22] = byte1; end
			if (enable0)	begin data_in0[21] = byte0; data_in1[21] = byte0; end
		end
		5'b10110:
		begin
			if (enable3)	begin data_in0[25] = byte3; data_in1[25] = byte3; end
			if (enable2)	begin data_in0[24] = byte2; data_in1[24] = byte2; end
			if (enable1)	begin data_in0[23] = byte1; data_in1[23] = byte1; end
			if (enable0)	begin data_in0[22] = byte0; data_in1[22] = byte0; end
		end
		5'b10111:
		begin
			if (enable3)	begin data_in0[26] = byte3; data_in1[26] = byte3; end
			if (enable2)	begin data_in0[25] = byte2; data_in1[25] = byte2; end
			if (enable1)	begin data_in0[24] = byte1; data_in1[24] = byte1; end
			if (enable0)	begin data_in0[23] = byte0; data_in1[23] = byte0; end
		end
		
		5'b11000:
		begin
			if (enable3)	begin data_in0[27] = byte3; data_in1[27] = byte3; end
			if (enable2)	begin data_in0[26] = byte2; data_in1[26] = byte2; end
			if (enable1)	begin data_in0[25] = byte1; data_in1[25] = byte1; end
			if (enable0)	begin data_in0[24] = byte0; data_in1[24] = byte0; end
		end
		5'b11001:
		begin
			if (enable3)	begin data_in0[28] = byte3; data_in1[28] = byte3; end
			if (enable2)	begin data_in0[27] = byte2; data_in1[27] = byte2; end
			if (enable1)	begin data_in0[26] = byte1; data_in1[26] = byte1; end
			if (enable0)	begin data_in0[25] = byte0; data_in1[25] = byte0; end
		end
		5'b11010:
		begin
			if (enable3)	begin data_in0[29] = byte3; data_in1[29] = byte3; end
			if (enable2)	begin data_in0[28] = byte2; data_in1[28] = byte2; end
			if (enable1)	begin data_in0[27] = byte1; data_in1[27] = byte1; end
			if (enable0)	begin data_in0[26] = byte0; data_in1[26] = byte0; end
		end
		5'b11011:
		begin
			if (enable3)	begin data_in0[30] = byte3; data_in1[30] = byte3; end
			if (enable2)	begin data_in0[29] = byte2; data_in1[29] = byte2; end
			if (enable1)	begin data_in0[28] = byte1; data_in1[28] = byte1; end
			if (enable0)	begin data_in0[27] = byte0; data_in1[27] = byte0; end
		end
		
		5'b11100:
		begin
			if (enable3)	begin data_in0[31] = byte3; data_in1[31] = byte3; end
			if (enable2)	begin data_in0[30] = byte2; data_in1[30] = byte2; end
			if (enable1)	begin data_in0[29] = byte1; data_in1[29] = byte1; end
			if (enable0)	begin data_in0[28] = byte0; data_in1[28] = byte0; end
		end
		5'b11101:
		begin
			if (enable2)	begin data_in0[31] = byte2; data_in1[31] = byte2; end
			if (enable1)	begin data_in0[30] = byte1; data_in1[30] = byte1; end
			if (enable0)	begin data_in0[29] = byte0; data_in1[29] = byte0; end
		end
		5'b11110:
		begin
			if (enable1)	begin data_in0[31] = byte1; data_in1[31] = byte1; end
			if (enable0)	begin data_in0[30] = byte0; data_in1[30] = byte0; end
		end              
		5'b11111:          
		begin
			if (enable0)	begin data_in0[31] = byte0; data_in1[31] = byte0; end
		end
	endcase
end

endmodule	: L1Dcache_write_data_assembler