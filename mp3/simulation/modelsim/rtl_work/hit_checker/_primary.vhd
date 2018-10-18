library verilog;
use verilog.vl_types.all;
entity hit_checker is
    port(
        tag_1_out       : in     vl_logic_vector(23 downto 0);
        tag_2_out       : in     vl_logic_vector(23 downto 0);
        valid_1_out     : in     vl_logic;
        valid_2_out     : in     vl_logic;
        mem_addr        : in     vl_logic_vector(31 downto 0);
        hit             : out    vl_logic;
        hit_way         : out    vl_logic
    );
end hit_checker;
