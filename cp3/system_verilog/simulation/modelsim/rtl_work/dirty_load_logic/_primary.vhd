library verilog;
use verilog.vl_types.all;
entity dirty_load_logic is
    port(
        lru             : in     vl_logic;
        cmp_rst         : in     vl_logic;
        set_dirty       : in     vl_logic;
        clr_dirty       : in     vl_logic;
        dirty_load_0    : out    vl_logic;
        dirty_load_1    : out    vl_logic;
        dirty_data      : out    vl_logic
    );
end dirty_load_logic;
