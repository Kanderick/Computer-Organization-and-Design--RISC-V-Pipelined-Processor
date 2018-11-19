library verilog;
use verilog.vl_types.all;
entity L2cache_datapath is
    port(
        clk             : in     vl_logic;
        mem_address     : in     vl_logic_vector(31 downto 0);
        mem_wdata       : in     vl_logic_vector(255 downto 0);
        pmem_rdata      : in     vl_logic_vector(255 downto 0);
        pmem_addr_sel   : in     vl_logic;
        load_lru        : in     vl_logic;
        load_tag        : in     vl_logic;
        load_data       : in     vl_logic;
        load_valid      : in     vl_logic;
        data_in_sel     : in     vl_logic;
        set_dirty       : in     vl_logic;
        clr_dirty       : in     vl_logic;
        mem_rdata       : out    vl_logic_vector(255 downto 0);
        pmem_address    : out    vl_logic_vector(31 downto 0);
        pmem_wdata      : out    vl_logic_vector(255 downto 0);
        hit             : out    vl_logic;
        dirty           : out    vl_logic
    );
end L2cache_datapath;
