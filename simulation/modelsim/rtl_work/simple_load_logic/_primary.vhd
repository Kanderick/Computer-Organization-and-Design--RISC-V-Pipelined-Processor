library verilog;
use verilog.vl_types.all;
entity simple_load_logic is
    port(
        LRU             : in     vl_logic;
        load            : in     vl_logic;
        load_1          : out    vl_logic;
        load_2          : out    vl_logic
    );
end simple_load_logic;
