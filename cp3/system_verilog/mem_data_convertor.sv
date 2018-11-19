module mem_data_convertor
(
	input [255:0] data_1,
	input [255:0] data_2,
	input hit_way,
	input [2:0] offset,
	input [1:0] byte_offset,
	
	output logic [31:0]mem_rdata
);

always_comb
begin
	if(hit_way)
	begin
		if(offset==7 && byte_offset!=0)
		begin
			case(byte_offset)
			2'b01:
			begin
				mem_rdata={8'b0, data_2[31-:24]};
			end
			2'b10:
			begin
				mem_rdata={16'b0, data_2[31-:16]};
			end
			2'b11:
			begin
				mem_rdata={24'b0, data_2[31-:8]};
			end
			default
			begin
				mem_rdata=32'b0;
			end
			endcase
		end
		else
			mem_rdata=data_2[(32*offset+8*byte_offset+31)-:32];
	end
	else
	begin
		if(offset==7 && byte_offset!=0)
		begin
			case(byte_offset)
			2'b01:
			begin
				mem_rdata={8'b0, data_1[31-:24]};
			end
			2'b10:
			begin
				mem_rdata={16'b0, data_1[31-:16]};
			end
			2'b11:
			begin
				mem_rdata={24'b0, data_1[31-:8]};
			end
			default
			begin
				mem_rdata=32'b0;
			end
			endcase
		end
		else
			mem_rdata=data_1[(32*offset+8*byte_offset+31)-:32];
	end
end

endmodule : mem_data_convertor