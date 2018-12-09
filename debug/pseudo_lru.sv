module pseudo_lru #(parameter bits = 2)
(
	input clk,
	input load_lru,
	input [bits-1:0] new_access,
	
	output logic [bits-1:0] lru
);
localparam num_state_bits = (1<<bits) - 1;

logic [num_state_bits-1:0] state, next_state;
logic [bits-1:0] levels[bits];
logic [bits-1:0] temp[bits];

initial
begin
	state = 0;
end

always_ff @(posedge clk)
begin
	if (load_lru)
	begin
		state <= next_state;
	end
end

always_comb
begin
	 next_state = state;
	 temp[0] = new_access[0];
	 next_state[0] = ~new_access[0];
	 for (int i = 1; i < bits; i = i + 1) begin
		temp[i] = temp[i-1];
		temp[i][i] = new_access[i];
		next_state[(1<<i) -1 + temp[i-1]] = ~new_access[i];
	 end
end

always_comb
begin
	levels[0] = state[0];
	 for (int i = 1; i < bits; i = i + 1) begin
		levels[i] = levels[i-1];
		levels[i][i] = state[(1<<i) -1 + levels[i-1]];
	 end
end
assign lru = levels[bits-1];

endmodule	: pseudo_lru