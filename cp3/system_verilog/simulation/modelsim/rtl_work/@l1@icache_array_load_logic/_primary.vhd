library verilog;
use verilog.vl_types.all;
entity L1Icache_array_load_logic is
    port(
        lru             : in     vl_logic;
        ld_tag          : in     vl_logic;
        ld_valid        : in     vl_logic;
        ld_data         : in     vl_logic;
        ld_tag0         : out    vl_logic;
        ld_tag1         : out    vl_logic;
        ld_valid0       : out    vl_logic;
        ld_valid1       : out    vl_logic;
        ld_data0        : out    vl_logic;
        ld_data1        : out    vl_logic
    );
end L1Icache_array_load_logic;
