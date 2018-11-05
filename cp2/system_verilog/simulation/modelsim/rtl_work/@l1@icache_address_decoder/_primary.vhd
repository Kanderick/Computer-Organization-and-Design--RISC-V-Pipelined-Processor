library verilog;
use verilog.vl_types.all;
entity L1Icache_address_decoder is
    port(
        cpu_l1i_address : in     vl_logic_vector(31 downto 0);
        index           : out    vl_logic_vector(4 downto 0);
        set             : out    vl_logic_vector(2 downto 0);
        tag             : out    vl_logic_vector(23 downto 0)
    );
end L1Icache_address_decoder;
