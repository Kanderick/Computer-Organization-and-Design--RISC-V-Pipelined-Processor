library verilog;
use verilog.vl_types.all;
entity cache_datapath is
    port(
        load_tag        : in     vl_logic;
        load_data_select: in     vl_logic_vector(1 downto 0);
        pmem_addr_select: in     vl_logic;
        set_LRU         : in     vl_logic;
        clr_dirty       : in     vl_logic;
        set_dirty       : in     vl_logic;
        set_valid       : in     vl_logic;
        data_write_select: in     vl_logic;
        hit             : out    vl_logic;
        dirty           : out    vl_logic;
        mem_address     : in     vl_logic_vector(31 downto 0);
        mem_wdata       : in     vl_logic_vector(31 downto 0);
        mem_byte_enable : in     vl_logic_vector(3 downto 0);
        mem_rdata       : out    vl_logic_vector(31 downto 0);
        pmem_rdata      : in     vl_logic_vector(255 downto 0);
        pmem_wdata      : out    vl_logic_vector(255 downto 0);
        pmem_addr       : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic
    );
end cache_datapath;
