module load_bits_generator
(
	input [4:0] offset,
	input load_sig,
	input data_in_sel,
	input [3:0] byte_enable,
	output [31:0] load_bits
);
logic [3:0] adjust_byte_enable;
logic [7:0] mux_sel_array;

always_comb
begin	: adjust_enable_bits
	if(!data_in_sel)
	begin
		adjust_byte_enable=4'b1111;
	end
	else
	begin
		if(offset[1:0]==2'b0)
		begin
			adjust_byte_enable=byte_enable;
		end
		else if(offset[0]==1'b0)
		begin
			adjust_byte_enable={2'b0, byte_enable[1:0]};
		end
		else 
		begin
			adjust_byte_enable={3'b0, byte_enable[0]};
		end
	end
end

always_comb
begin	: select_right_MUX
	for (int i=0; i<8; i++)
	begin
		mux_sel_array[i]=((offset[4:2]==i)|(!data_in_sel))&&load_sig;
	end
end

genvar i;
generate 
	for (i=0; i<8; i++)
	begin : generate_load_bits
		mux2#(.width(4)) load_mux_array(
			.b(adjust_byte_enable),
			.a(4'b0),
			.f(load_bits[(i*4+3):(i*4)]),
			.sel(mux_sel_array[i])
		);
	end
endgenerate
endmodule : load_bits_generator