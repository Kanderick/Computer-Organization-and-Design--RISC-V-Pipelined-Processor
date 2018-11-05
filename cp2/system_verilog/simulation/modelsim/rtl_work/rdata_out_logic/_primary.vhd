library verilog;
use verilog.vl_types.all;
entity rdata_out_logic is
    port(
        funct3          : in     vl_logic_vector(2 downto 0);
        data_in         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end rdata_out_logic;
