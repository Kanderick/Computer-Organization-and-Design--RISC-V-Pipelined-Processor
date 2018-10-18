library verilog;
use verilog.vl_types.all;
entity cache_control is
    port(
        hit             : in     vl_logic;
        dirty           : in     vl_logic;
        set_LRU         : out    vl_logic;
        load_tag        : out    vl_logic;
        load_data_select: out    vl_logic_vector(1 downto 0);
        set_valid       : out    vl_logic;
        set_dirty       : out    vl_logic;
        clr_dirty       : out    vl_logic;
        pmem_addr_select: out    vl_logic;
        data_write_select: out    vl_logic;
        pmem_resp       : in     vl_logic;
        pmem_write      : out    vl_logic;
        pmem_read       : out    vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        mem_resp        : out    vl_logic;
        clk             : in     vl_logic
    );
end cache_control;
