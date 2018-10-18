library verilog;
use verilog.vl_types.all;
entity pmem_addr_logic is
    port(
        mem_address     : in     vl_logic_vector(31 downto 0);
        LRU             : in     vl_logic;
        set             : in     vl_logic_vector(2 downto 0);
        tag_1           : in     vl_logic_vector(23 downto 0);
        tag_2           : in     vl_logic_vector(23 downto 0);
        pmem_addr_select: in     vl_logic;
        pmem_addr       : out    vl_logic_vector(31 downto 0)
    );
end pmem_addr_logic;
