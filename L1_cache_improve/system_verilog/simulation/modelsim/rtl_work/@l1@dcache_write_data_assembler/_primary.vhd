library verilog;
use verilog.vl_types.all;
entity L1Dcache_write_data_assembler is
    port(
        index           : in     vl_logic_vector(4 downto 0);
        mem_byte_enable : in     vl_logic_vector(3 downto 0);
        mem_wdata       : in     vl_logic_vector(31 downto 0);
        data0           : in     vl_logic;
        data1           : in     vl_logic;
        data_in0        : out    vl_logic;
        data_in1        : out    vl_logic
    );
end L1Dcache_write_data_assembler;
