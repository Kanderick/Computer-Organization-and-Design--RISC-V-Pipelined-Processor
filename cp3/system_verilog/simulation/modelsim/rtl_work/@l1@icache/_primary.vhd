library verilog;
use verilog.vl_types.all;
entity L1Icache is
    port(
        clk             : in     vl_logic;
        cpu_l1i_address : in     vl_logic_vector(31 downto 0);
        cpu_l1i_rdata   : out    vl_logic_vector(31 downto 0);
        cpu_l1i_read    : in     vl_logic;
        cpu_l1i_resp    : out    vl_logic;
        l1i_arbi_address: out    vl_logic_vector(31 downto 0);
        l1i_arbi_rdata  : in     vl_logic_vector(255 downto 0);
        l1i_arbi_read   : out    vl_logic;
        l1i_arbi_resp   : in     vl_logic
    );
end L1Icache;
