library verilog;
use verilog.vl_types.all;
entity arbitor is
    generic(
        width           : integer := 32
    );
    port(
        clk             : in     vl_logic;
        icache_read     : in     vl_logic;
        icache_address  : in     vl_logic_vector(31 downto 0);
        icache_rdata    : out    vl_logic_vector;
        icache_resp     : out    vl_logic;
        dcache_read     : in     vl_logic;
        dcache_write    : in     vl_logic;
        dcache_address  : in     vl_logic_vector(31 downto 0);
        dcache_wdata    : in     vl_logic_vector;
        dcache_byte_enable: in     vl_logic_vector(3 downto 0);
        dcache_rdata    : out    vl_logic_vector;
        dcache_resp     : out    vl_logic;
        L2cache_read    : out    vl_logic;
        L2cache_write   : out    vl_logic;
        L2cache_address : out    vl_logic_vector(31 downto 0);
        L2cache_wdata   : out    vl_logic_vector;
        L2cache_byte_enable: out    vl_logic_vector(3 downto 0);
        L2cache_rdata   : in     vl_logic_vector;
        L2cache_resp    : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end arbitor;
