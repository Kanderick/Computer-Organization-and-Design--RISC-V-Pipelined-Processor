library verilog;
use verilog.vl_types.all;
entity L2cache_control is
    port(
        clk             : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        pmem_resp       : in     vl_logic;
        hit             : in     vl_logic;
        dirty           : in     vl_logic;
        mem_resp        : out    vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic;
        pmem_addr_sel   : out    vl_logic;
        load_lru        : out    vl_logic;
        load_tag        : out    vl_logic;
        load_data       : out    vl_logic;
        load_valid      : out    vl_logic;
        data_in_sel     : out    vl_logic;
        set_dirty       : out    vl_logic;
        clr_dirty       : out    vl_logic
    );
end L2cache_control;
