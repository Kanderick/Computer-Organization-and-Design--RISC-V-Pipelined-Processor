library verilog;
use verilog.vl_types.all;
entity WB_stage is
    port(
        WB_pc           : in     vl_logic_vector(31 downto 0);
        WB_funct3       : in     vl_logic_vector(2 downto 0);
        WB_rdata        : in     vl_logic_vector(31 downto 0);
        WB_cmp_out      : in     vl_logic;
        WB_alu_out      : in     vl_logic_vector(31 downto 0);
        WB_u_imm        : in     vl_logic_vector(31 downto 0);
        WB_regfilemux_sel: in     vl_logic_vector(2 downto 0);
        WB_in           : out    vl_logic_vector(31 downto 0)
    );
end WB_stage;
