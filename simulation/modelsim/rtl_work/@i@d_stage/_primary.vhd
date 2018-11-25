library verilog;
use verilog.vl_types.all;
library work;
entity ID_stage is
    port(
        clk             : in     vl_logic;
        ID_rs1          : in     vl_logic_vector(4 downto 0);
        ID_rs2          : in     vl_logic_vector(4 downto 0);
        WB_in           : in     vl_logic_vector(31 downto 0);
        ID_rd           : in     vl_logic_vector(4 downto 0);
        ID_load_regfile : in     vl_logic;
        ID_pc           : in     vl_logic_vector(31 downto 0);
        ID_b_imm        : in     vl_logic_vector(31 downto 0);
        ID_j_imm        : in     vl_logic_vector(31 downto 0);
        ID_i_imm        : in     vl_logic_vector(31 downto 0);
        jb_sel          : in     vl_logic_vector(1 downto 0);
        cmpop           : in     work.rv32i_types.branch_funct3_t;
        ID_pc_mux_sel   : out    vl_logic;
        flush           : out    vl_logic;
        ID_rs1_out      : out    vl_logic_vector(31 downto 0);
        ID_rs2_out      : out    vl_logic_vector(31 downto 0);
        ID_jmp_pc       : out    vl_logic_vector(31 downto 0)
    );
end ID_stage;
