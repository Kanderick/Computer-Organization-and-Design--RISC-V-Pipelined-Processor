library verilog;
use verilog.vl_types.all;
entity L2cache is
    port(
        clk             : in     vl_logic;
        arbi_l2_address : in     vl_logic_vector(31 downto 0);
        arbi_l2_wdata   : in     vl_logic_vector(255 downto 0);
        arbi_l2_read    : in     vl_logic;
        arbi_l2_write   : in     vl_logic;
        l2_pmem_rdata   : in     vl_logic_vector(255 downto 0);
        l2_pmem_resp    : in     vl_logic;
        arbi_l2_rdata   : out    vl_logic_vector(255 downto 0);
        arbi_l2_resp    : out    vl_logic;
        l2_pmem_address : out    vl_logic_vector(31 downto 0);
        l2_pmem_wdata   : out    vl_logic_vector(255 downto 0);
        l2_pmem_read    : out    vl_logic;
        l2_pmem_write   : out    vl_logic
    );
end L2cache;
