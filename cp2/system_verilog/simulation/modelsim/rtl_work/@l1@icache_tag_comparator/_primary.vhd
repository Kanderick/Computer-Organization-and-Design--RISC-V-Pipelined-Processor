library verilog;
use verilog.vl_types.all;
entity L1Icache_tag_comparator is
    port(
        tag             : in     vl_logic_vector(23 downto 0);
        tag0            : in     vl_logic_vector(23 downto 0);
        tag1            : in     vl_logic_vector(23 downto 0);
        valid0          : in     vl_logic;
        valid1          : in     vl_logic;
        hit             : out    vl_logic;
        cmp_rst         : out    vl_logic
    );
end L1Icache_tag_comparator;
