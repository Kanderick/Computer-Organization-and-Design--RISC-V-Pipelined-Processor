library verilog;
use verilog.vl_types.all;
entity L2cache_tag_comparator is
    port(
        tag             : in     vl_logic_vector(22 downto 0);
        tag_0           : in     vl_logic_vector(22 downto 0);
        tag_1           : in     vl_logic_vector(22 downto 0);
        valid_0         : in     vl_logic;
        valid_1         : in     vl_logic;
        hit             : out    vl_logic;
        cmp_rst         : out    vl_logic
    );
end L2cache_tag_comparator;
