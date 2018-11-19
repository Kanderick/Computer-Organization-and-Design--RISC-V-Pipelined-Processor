library verilog;
use verilog.vl_types.all;
entity ID_stage is
    port(
        clk             : in     vl_logic;
        ID_rs1          : in     vl_logic_vector(4 downto 0);
        ID_rs2          : in     vl_logic_vector(4 downto 0);
        WB_in           : in     vl_logic_vector(31 downto 0);
        WB_rd           : in     vl_logic_vector(4 downto 0);
        WB_load_regfile : in     vl_logic;
        ID_rs1_out      : out    vl_logic_vector(31 downto 0);
        ID_rs2_out      : out    vl_logic_vector(31 downto 0)
    );
end ID_stage;
