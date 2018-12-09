module cache_control

(
// cache read interface
    input clk,
    input logic mem_read,
    input logic mem_write,
    output logic mem_resp,
 // physical memory control
    output logic pmem_read,
    output logic pmem_write,
    input logic pmem_resp,
 // data path control
    output logic load_wdata_reg,
    output logic way_sel_method,
    output logic load_line_data,
    output logic load_valid,
    output logic load_dirty,
    output logic load_LRU,
    output logic line_datain_sel,
    output logic valid_in,
    output logic dirty_in,
    output logic address_sel,
    input dirty,
    input hit,
    input valid,
    
 // report cache miss
	 output logic if_miss
);

/*
enum int unsigned {
    idle,
    cmp_load,
    update,
    write_back,
    read_mem
} state, next_state;
*/
enum int unsigned {
    ready,
    write_back,
    read_mem
} state, next_state;


always_comb
begin : state_actions
    /* Default output assignments */
    /* Actions for each state */
    /* Default assignments */
    pmem_read = 0;
    pmem_write = 0;
    mem_resp = 0;
    //load_wdata_reg = 0;
    way_sel_method = 0; // set to 1 to select LRU line
    load_line_data = 0;
    load_valid = 0;
    load_dirty = 0;
    load_LRU = 0;
    line_datain_sel = 0;
    valid_in = 0;
    dirty_in = 0;
    address_sel = 0;
    load_wdata_reg = 0;
	 if_miss=0;
        /*
    case(state)
        idle: //do nothing
        cmp_load: begin
                load_wdata_reg = 1;
                end
        write_back: // to do
                begin
                end
        read_mem: begin
                    way_sel_method = 1; 
                    pmem_read = 1;                    
                    dirty_in = 0;
                    valid_in = 1;
                    if (pmem_resp) begin 
                        load_line_data = 1;
                        load_dirty = 1;
                        load_valid = 1;
                    end    
                end
        update: begin
                load_dirty = mem_write;
                load_line_data = mem_write;
                line_datain_sel = 1;
                dirty_in = 1;
                load_LRU = 1;
                mem_resp = 1;
                end
        default:; //nothing        
    endcase   
        */
     case(state)
        ready: begin
                mem_resp = hit && valid && (mem_read || mem_write);
                load_dirty = hit && valid && mem_write;
                load_line_data =  hit && valid && mem_write;
                line_datain_sel = 1;
                dirty_in = 1;
                load_LRU = hit && valid;
                load_wdata_reg = (mem_read || mem_write);
                end
        write_back: // to do
                begin
                    way_sel_method = 1; 
                    pmem_write = 1; 
                    address_sel = 1;
						  if_miss=1;
                end
        read_mem: begin
                    way_sel_method = 1; 
                    pmem_read = 1;                    
                    //dirty_in = 0;
                    valid_in = 1;
						  if_miss=1;
                    if (pmem_resp) begin 
                        load_line_data = 1;
                        load_dirty = 1;
                        load_valid = 1;
                    end    
                end
        default:; //nothing        
    endcase          
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
     next_state = state;
    case(state)
        ready: begin 
            if (mem_read || mem_write)
                if (hit && valid)
                    next_state = ready;
                else if (dirty)
                    next_state = write_back;
                else if (!dirty)
                    next_state = read_mem;
              end

        write_back: // to do 
                    begin
                     if (pmem_resp)
                        next_state = read_mem;                   
                    end
        read_mem: begin 
                    if (pmem_resp)
                        next_state = ready;
                  end      
        default:; //nothing        
    endcase        
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end

endmodule

 

























