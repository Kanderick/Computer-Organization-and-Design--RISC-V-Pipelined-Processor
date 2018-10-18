library verilog;
use verilog.vl_types.all;
entity mem_data_convertor is
    port(
        data_1          : in     vl_logic_vector(255 downto 0);
        data_2          : in     vl_logic_vector(255 downto 0);
        hit_way         : in     vl_logic;
        offset          : in     vl_logic_vector(2 downto 0);
        byte_offset     : in     vl_logic_vector(1 downto 0);
        mem_rdata       : out    vl_logic_vector(31 downto 0)
    );
end mem_data_convertor;
