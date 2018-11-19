library verilog;
use verilog.vl_types.all;
entity arbitor_controller is
    port(
        clk             : in     vl_logic;
        dcache_write    : in     vl_logic;
        icache_read     : in     vl_logic;
        dcache_read     : in     vl_logic;
        L2cache_resp    : in     vl_logic;
        cache_sel       : out    vl_logic
    );
end arbitor_controller;
