library verilog;
use verilog.vl_types.all;
entity mp2 is
    port(
        pmem_resp       : in     vl_logic;
        pmem_rdata      : in     vl_logic_vector(255 downto 0);
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic;
        pmem_address    : out    vl_logic_vector(31 downto 0);
        pmem_wdata      : out    vl_logic_vector(255 downto 0);
        clk             : in     vl_logic
    );
end mp2;
