library verilog;
use verilog.vl_types.all;
entity MDR is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        instr_data      : in     vl_logic;
        funct3          : in     vl_logic_vector(2 downto 0);
        \in\            : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end MDR;
