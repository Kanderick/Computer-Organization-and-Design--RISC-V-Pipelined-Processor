module victim_cache_victim_update_logic
(
	input update_victim,
	input [3:0] hit_way,
	input [1:0] lru,
	output logic [1:0] new_access,
	output logic load0,
	output logic load1,
	output logic load2,
	output logic load3
);
/*
	logic load0_update;
	logic load1_update;
	logic load2_update;
	logic load3_update;
	logic [1:0] new_access_update;
	
	logic load0_update_lru;
	logic load1_update_lru;
	logic load2_update_lru;
	logic load3_update_lru;
	logic [1:0] new_access_update_lru;


always_comb
begin
	case (update_victim)
		default:
		begin
			load0 = 0;
			load1 = 0;
			load2 = 0;
			load3 = 0;
			new_access = 2'b00;
		end
		1'b1:
		begin
			load0 = load0_update;
			load1 = load1_update;
			load2 = load2_update;
			load3 = load3_update;
			new_access = new_access_update;
		end
	endcase
	
case (hit_way)
	4'b0000:
	begin
		load0_update = load0_update_lru;
		load1_update = load1_update_lru;
		load2_update = load2_update_lru;
		load3_update = load3_update_lru;
		new_access_update = new_access_update_lru;
	end
	4'b0001:
	begin
		load0_update = 1;
		load1_update = 0;
		load2_update = 0;
		load3_update = 0;
		new_access_update = 2'b00;
	end
	4'b0010:
	begin
		load0_update = 0;
		load1_update = 1;
		load2_update = 0;
		load3_update = 0;
		new_access_update = 2'b01;
	end
	4'b0100:
	begin
		load0_update = 0;
		load1_update = 0;
		load2_update = 1;
		load3_update = 0;
		new_access_update = 2'b10;
	end
	default:
	begin
		load0_update = 0;
		load1_update = 0;
		load2_update = 0;
		load3_update = 1;
		new_access_update = 2'b11;
	end
endcase
			
case (lru)
	2'b00:
	begin
		load0_update_lru = 1;
		load1_update_lru = 0;
		load2_update_lru = 0;
		load3_update_lru = 0;
		new_access_update_lru = 2'b00;
	end
	2'b01:
	begin
		load0_update_lru = 0;
		load1_update_lru = 1;
		load2_update_lru = 0;
		load3_update_lru = 0;
		new_access_update_lru = 2'b01;
	end
	2'b10:
	begin
		load0_update_lru = 0;
		load1_update_lru = 0;
		load2_update_lru = 1;
		load3_update_lru = 0;
		new_access_update_lru = 2'b10;
	end
	default:
	begin
		load0_update_lru = 0;
		load1_update_lru = 0;
		load2_update_lru = 0;
		load3_update_lru = 1;
		new_access_update_lru = 2'b11;
	end
endcase
			
end
*/

always_comb
begin
	if (!update_victim)
	begin
		load0 = 0;
		load1 = 0;
		load2 = 0;
		load3 = 0;
		new_access = 2'b00;
	end
	
	else
	begin
		if (hit_way == 4'b0000)
		begin
			if (lru == 2'b00)
			begin
				load0 = 1;
				load1 = 0;
				load2 = 0;
				load3 = 0;
				new_access = 2'b00;
			end
			
			else if (lru == 2'b01)
			begin
				load0 = 0;
				load1 = 1;
				load2 = 0;
				load3 = 0;
				new_access = 2'b01;
			end
			
			else if (lru == 2'b10)
			begin
				load0 = 0;
				load1 = 0;
				load2 = 1;
				load3 = 0;
				new_access = 2'b10;
			end
			
			else
			begin
				load0 = 0;
				load1 = 0;
				load2 = 0;
				load3 = 1;
				new_access = 2'b11;
			end
		end
		
		else if (hit_way == 4'b0001)
		begin
				load0 = 1;
				load1 = 0;
				load2 = 0;
				load3 = 0;
				new_access = 2'b00;
		end
		
		else if (hit_way == 4'b0010)
		begin
				load0 = 0;
				load1 = 1;
				load2 = 0;
				load3 = 0;
				new_access = 2'b01;
		end
		
		else if (hit_way == 4'b0100)
		begin
				load0 = 0;
				load1 = 0;
				load2 = 1;
				load3 = 0;
				new_access = 2'b10;
		end
		
		else
		begin
				load0 = 0;
				load1 = 0;
				load2 = 0;
				load3 = 1;
				new_access = 2'b11;
		end
	end

end


endmodule	: victim_cache_victim_update_logic