library verilog;
use verilog.vl_types.all;
entity L1Dcache is
    port(
        clk             : in     vl_logic;
        cpu_l1d_address : in     vl_logic_vector(31 downto 0);
        cpu_l1d_wdata   : in     vl_logic_vector(31 downto 0);
        cpu_l1d_read    : in     vl_logic;
        cpu_l1d_write   : in     vl_logic;
        cpu_l1d_byte_enable: in     vl_logic_vector(3 downto 0);
        l1d_arbi_rdata  : in     vl_logic_vector(255 downto 0);
        l1d_arbi_resp   : in     vl_logic;
        cpu_l1d_rdata   : out    vl_logic_vector(31 downto 0);
        cpu_l1d_resp    : out    vl_logic;
        l1d_arbi_address: out    vl_logic_vector(31 downto 0);
        l1d_arbi_wdata  : out    vl_logic_vector(255 downto 0);
        l1d_arbi_read   : out    vl_logic;
        l1d_arbi_write  : out    vl_logic
    );
end L1Dcache;
