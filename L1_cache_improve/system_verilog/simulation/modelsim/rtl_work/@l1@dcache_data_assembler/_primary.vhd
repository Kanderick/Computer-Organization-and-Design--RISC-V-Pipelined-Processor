library verilog;
use verilog.vl_types.all;
entity L1Dcache_data_assembler is
    port(
        datain          : in     vl_logic;
        index           : in     vl_logic_vector(4 downto 0);
        dataout         : out    vl_logic_vector(31 downto 0)
    );
end L1Dcache_data_assembler;
