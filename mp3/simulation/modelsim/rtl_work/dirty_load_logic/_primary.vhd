library verilog;
use verilog.vl_types.all;
entity dirty_load_logic is
    port(
        LRU             : in     vl_logic;
        clr_dirty       : in     vl_logic;
        hitway          : in     vl_logic;
        set_dirty       : in     vl_logic;
        in_1            : out    vl_logic;
        in_2            : out    vl_logic;
        load_1          : out    vl_logic;
        load_2          : out    vl_logic
    );
end dirty_load_logic;
