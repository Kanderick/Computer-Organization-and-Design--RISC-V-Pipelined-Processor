library verilog;
use verilog.vl_types.all;
entity L2cache_valid_load_logic is
    port(
        load_valid      : in     vl_logic;
        lru             : in     vl_logic;
        valid_load_0    : out    vl_logic;
        valid_load_1    : out    vl_logic
    );
end L2cache_valid_load_logic;
