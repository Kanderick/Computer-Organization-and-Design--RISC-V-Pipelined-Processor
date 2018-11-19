library verilog;
use verilog.vl_types.all;
entity L2cache_address_decoder is
    port(
        mem_address     : in     vl_logic_vector(31 downto 0);
        index           : out    vl_logic_vector(4 downto 0);
        set             : out    vl_logic_vector(3 downto 0);
        tag             : out    vl_logic_vector(22 downto 0)
    );
end L2cache_address_decoder;
