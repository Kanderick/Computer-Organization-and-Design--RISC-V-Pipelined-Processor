library verilog;
use verilog.vl_types.all;
entity pipe_control is
    port(
        flush           : in     vl_logic;
        IF_ID_flush     : out    vl_logic;
        read_intr_stall : in     vl_logic;
        mem_access_stall: in     vl_logic;
        load            : out    vl_logic;
        clk             : in     vl_logic
    );
end pipe_control;
