library verilog;
use verilog.vl_types.all;
entity tag_comparator is
    port(
        tag             : in     vl_logic_vector(23 downto 0);
        tag_0           : in     vl_logic_vector(23 downto 0);
        tag_1           : in     vl_logic_vector(23 downto 0);
        valid_0         : in     vl_logic;
        valid_1         : in     vl_logic;
        hit             : out    vl_logic;
        cmp_rst         : out    vl_logic
    );
end tag_comparator;
