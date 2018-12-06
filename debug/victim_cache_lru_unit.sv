module victim_cache_lru_unit
(
	input clk,
	input load_lru,
	input [1:0] new_access,
	
	output logic [1:0] lru
);

/*For four way fully associative victim cache, we have four four-bit register to store lru information*/

	logic [3:0] row0;
	logic [3:0] row1;
	logic [3:0] row2;
	logic [3:0] row3;

initial
begin
	row0 = 4'b0000;
	row1 = 4'b0000;
	row2 = 4'b0000;
	row3 = 4'b0000;
end

always_ff @(posedge clk)
begin
	if (load_lru)
	begin
		if (new_access == 2'b00)
		begin
			row0 <= 4'b0111;
			row1[3] <= 0;
			row2[3] <= 0;
			row3[3] <= 0;
		end
		
		else if (new_access == 2'b01)
		begin
			row1 <= 4'b1011;
			row0[2] <= 0;
			row2[2] <= 0;
			row3[2] <= 0;
		end
		
		else if (new_access == 2'b10)
		begin
			row2 <= 4'b1101;
			row0[1] <= 0;
			row1[1] <= 0;
			row3[1] <= 0;
		end
		
		else
		begin
			row3 <= 4'b1110;
			row0[0] <= 0;
			row1[0] <= 0;
			row2[0] <= 0;
		end
	end
end

always_comb
begin
	if((row0 <= row1) && (row0 <= row2) && (row0 <= row3)) lru = 2'b00;
	else if ((row1 <= row0) && (row1 <= row2) && (row1 <= row3)) lru = 2'b01;
	else if ((row2 <= row0) && (row2 <= row1) && (row2 <= row3)) lru = 2'b10;
	else lru = 2'b11;
end

endmodule	: victim_cache_lru_unit