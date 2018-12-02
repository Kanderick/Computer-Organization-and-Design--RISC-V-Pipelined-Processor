module cache_control
(
	/*datapath signals*/
	input hit,
	input dirty,
	output logic set_LRU,
	output logic load_tag,
	output logic [1:0] load_data_select,
	output logic set_valid,
	output logic set_dirty,
	output logic clr_dirty,
	output logic pmem_addr_select,
	output logic data_write_select,
	
	/*pmem signals*/
	input pmem_resp,
	output logic pmem_write,
	output logic pmem_read,
	
	/*cpu signals*/
	input mem_read,
	input mem_write,
	output logic mem_resp,
	
	/*other signals*/
	input clk,
	
	/*report miss*/
	output logic if_miss
);
enum {idle, write_to_pmem, read_from_pmem} state, next_state;
initial
begin
	state=idle;
end

always_comb
begin : state_implementation
	/*default value for the control signals*/
	mem_resp=0;
	set_LRU=0;
	load_tag=0;
	set_valid=0;
	set_dirty=0;
	clr_dirty=0;
	load_data_select=2'b0;
	data_write_select=0;
	pmem_addr_select=0;
	pmem_write=0;
	pmem_read=0;
	if_miss=0;
	/*state implementation*/
	case(state)
	idle:
	begin
		mem_resp=(mem_read|mem_write)&hit;
		set_LRU=(mem_read|mem_write)&hit;
		if(mem_write==1'b1 && hit==1'b1)
		begin
			load_data_select=2'b10;
			set_dirty=1'b1;
		end
	end
	write_to_pmem:
	begin
		pmem_addr_select=1'b1;
		clr_dirty=1'b1;
		pmem_write=1'b1;
		if_miss=1'b1;
	end
	read_from_pmem:
	begin
		load_data_select={{pmem_resp},1'b1};
		data_write_select=1'b1;
		pmem_read=1'b1;
		load_tag=pmem_resp;
		set_valid=1'b1;
		if_miss=1'b1;
	end
	default
	begin
	end
	endcase 
end

always_comb
begin : state_transition
	next_state=state;
	case(state)
	idle:
	begin
		if((mem_read|mem_write)==1'b1 && hit==1'b0 && dirty==1)
			next_state=write_to_pmem;
		else if((mem_read|mem_write)==1'b1 && hit==1'b0 && dirty==0)
			next_state=read_from_pmem;
	end
	read_from_pmem:
	begin
		if(pmem_resp)
			next_state=idle;
	end
	write_to_pmem:
	begin
		if(pmem_resp)
			next_state=read_from_pmem;
	end
	default
	begin
	end
	endcase 	
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : cache_control 