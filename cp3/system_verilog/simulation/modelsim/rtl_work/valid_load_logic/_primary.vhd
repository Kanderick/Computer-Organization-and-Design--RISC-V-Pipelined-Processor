library verilog;
use verilog.vl_types.all;
entity valid_load_logic is
    port(
        load_valid      : in     vl_logic;
        lru             : in     vl_logic;
        valid_load_0    : out    vl_logic;
        valid_load_1    : out    vl_logic
    );
end valid_load_logic;
