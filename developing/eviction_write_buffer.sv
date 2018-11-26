module eviction_write_buffer #(parameter hold_time = 3)
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
logic [31:0] delay_time;

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
	buffer_occupied,
    writing
} state, nextstate;


//always_ff @(posedge clk)
always_comb
begin : state_actions

/*default actions*/
	rdata = pmem_rdata;
    resp = 1'b0;
	pmem_address = address;
    pmem_wdata = wdata;
    pmem_read = 1'b0;
	pmem_write = 1'b0;
	
/*Actions per state*/

	case(state)
		default:;
		
		buffer_unoccupied:
		begin
			if (write)
			begin
				//address_evicted = address;
				//data_evicted = wdata;
				resp = 1'b1;
			end
            else begin
                pmem_read = read;
            end 
		end
		
		buffer_occupied:
		begin
			if (read && (address[31:5] == address_evicted[31:5]))
			begin
				rdata = data_evicted;
				resp = 1'b1;
			end
			else if (read)
			begin
				resp = pmem_resp;
				pmem_read = read;
			end
		end
		
        writing:
        begin
            pmem_write = 1'b1;
            pmem_wdata = data_evicted;
            pmem_address = address_evicted;
            if (read && (address[31:5] == address_evicted[31:5]))
            begin
				rdata = data_evicted;
				resp = 1'b1;
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
			if (write) nextstate = buffer_occupied;
		end
		buffer_occupied:
		begin
			if (read && (address[31:5] == address_evicted[31:5])) 
                nextstate = buffer_unoccupied;
			else if (!read && (delay_time == hold_time)) nextstate = writing;
		end
        
        writing:
        begin
            if (pmem_resp) nextstate = buffer_unoccupied;
        end
	endcase

end

always_ff @(posedge clk)
begin : next_state_assignment
	state <= nextstate;
    if (state == buffer_unoccupied)begin
        address_evicted <= address;
        data_evicted <= wdata;
        delay_time <= 0;       
    end
    if (state == buffer_occupied) 
        delay_time <= delay_time + 1;
end


endmodule :	eviction_write_buffer