library verilog;
use verilog.vl_types.all;
entity tag_load_logic is
    port(
        load_tag        : in     vl_logic;
        lru             : in     vl_logic;
        tag_load_0      : out    vl_logic;
        tag_load_1      : out    vl_logic
    );
end tag_load_logic;
