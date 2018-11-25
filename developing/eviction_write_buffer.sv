module eviction_write_buffer
(
	input clk,
	
	/*Signals between L2 and eviction write buffer*/
	input [31:0] address,
	input read,
	input write,
	output logic [255:0] rdata,
	input [255:0] wdata,
	output logic resp,
	
	/*Signals between eviction write buffer and physical memory*/
	output logic [31:0] pmem_address,
	output logic pmem_read,
	output logic pmem_write,
	input [255:0] pmem_rdata,
	output logic [255:0] pmem_wdata,
	input logic pmem_resp
);

/*Internal signals and buffers*/
//logic occupied;
logic [31:0] address_evicted;
logic [255:0] data_evicted;

/*Initial clear*/
initial
begin
	//occupied = 1'b0;
	address_evicted = 32'b0;
	data_evicted = 256'b0;
end

/*Controls*/
enum int unsigned {
	/*list of states*/
	buffer_unoccupied,
	stall1,
	stall2,
	buffer_occupied
} state, nextstate;

always_ff @(posedge clk)
begin : state_actions

/*default actions*/
	rdata = pmem_rdata;
	resp = pmem_resp;
	pmem_address = address;
	pmem_read = read;
	pmem_write = 0;
	pmem_wdata = 0;
	
/*Actions per state*/

	case(state)
		default:;
		
		buffer_unoccupied:
		begin
			if (write)
			begin
				address_evicted = address;
				data_evicted = wdata;
				resp = 1'b1;
			end
		end
		
		stall1:
		begin
			if (read && (address[31:5] == address_evicted[31:5]))
			begin
				rdata = data_evicted;
				resp = 1'b1;
			end
		end
		
		stall2:
		begin
			if (read && (address[31:5] == address_evicted[31:5]))
			begin
				rdata = data_evicted;
				resp = 1'b1;
			end
		end
		
		
		buffer_occupied:
		begin
			if (read && (address[31:5] == address_evicted[31:5]))
			begin
				rdata = data_evicted;
				resp = 1'b1;
			end
			
			else if (!read)
			begin
				resp = 1'b0;
				pmem_write = 1'b1;
				pmem_address = address_evicted;
				pmem_wdata = data_evicted;
			end
		end
		
	endcase

end

always_comb
begin : next_state_logic
	nextstate = state;
	
	case(state)
		default: nextstate = buffer_unoccupied;
		
		buffer_unoccupied:
		begin
			if (write) nextstate = stall1;
			else nextstate = buffer_unoccupied;
		end
		
		stall1:
		begin
			nextstate = stall2;
		end
		
		stall2:
		begin
			nextstate = buffer_occupied;
		end
		
		buffer_occupied:
		begin
			if (!read && pmem_resp) nextstate = buffer_unoccupied;
			else nextstate = buffer_occupied;
		end
	endcase

end

always_ff @(posedge clk)
begin : next_state_assignment
	state <= nextstate;
end


endmodule :	eviction_write_buffer