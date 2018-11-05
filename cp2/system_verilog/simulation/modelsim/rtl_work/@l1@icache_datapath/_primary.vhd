library verilog;
use verilog.vl_types.all;
entity L1Icache_datapath is
    port(
        clk             : in     vl_logic;
        cpu_l1i_address : in     vl_logic_vector(31 downto 0);
        cpu_l1i_rdata   : out    vl_logic_vector(31 downto 0);
        l1i_arbi_address: out    vl_logic_vector(31 downto 0);
        l1i_arbi_rdata  : in     vl_logic_vector(255 downto 0);
        ld_tag          : in     vl_logic;
        ld_lru          : in     vl_logic;
        ld_valid        : in     vl_logic;
        ld_data         : in     vl_logic;
        hit             : out    vl_logic
    );
end L1Icache_datapath;
