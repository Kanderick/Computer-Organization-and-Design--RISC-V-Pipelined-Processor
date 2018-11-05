library verilog;
use verilog.vl_types.all;
entity pipe_control is
    port(
        flush           : in     vl_logic;
        IF_ID_flush     : out    vl_logic;
        MEM_flush       : out    vl_logic;
        read_intr_stall : in     vl_logic;
        mem_access_stall: in     vl_logic;
        MEM_EX_rdata_hazard: in     vl_logic;
        pc_load         : out    vl_logic;
        ID_load         : out    vl_logic;
        EX_load         : out    vl_logic;
        MEM_load        : out    vl_logic;
        WB_load         : out    vl_logic;
        clk             : in     vl_logic
    );
end pipe_control;
