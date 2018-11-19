library verilog;
use verilog.vl_types.all;
library work;
entity EX_stage is
    port(
        clk             : in     vl_logic;
        EX_alumux1_sel  : in     vl_logic;
        EX_alumux2_sel  : in     vl_logic_vector(2 downto 0);
        EX_cmpmux_sel   : in     vl_logic;
        EX_aluop        : in     work.rv32i_types.alu_ops;
        EX_cmpop        : in     work.rv32i_types.branch_funct3_t;
        EX_pc           : in     vl_logic_vector(31 downto 0);
        EX_rs1_out      : in     vl_logic_vector(31 downto 0);
        EX_rs2_out      : in     vl_logic_vector(31 downto 0);
        EX_i_imm        : in     vl_logic_vector(31 downto 0);
        EX_u_imm        : in     vl_logic_vector(31 downto 0);
        EX_b_imm        : in     vl_logic_vector(31 downto 0);
        EX_s_imm        : in     vl_logic_vector(31 downto 0);
        EX_j_imm        : in     vl_logic_vector(31 downto 0);
        EX_rs1_forwarded_WB: in     vl_logic_vector(31 downto 0);
        EX_rs2_forwarded_WB: in     vl_logic_vector(31 downto 0);
        EX_rs1_forwarded_MEM: in     vl_logic_vector(31 downto 0);
        EX_rs2_forwarded_MEM: in     vl_logic_vector(31 downto 0);
        EX_alu_out      : out    vl_logic_vector(31 downto 0);
        EX_cmp_out      : out    vl_logic;
        fowarding_mux2_out: out    vl_logic_vector(31 downto 0);
        jb_sel          : in     vl_logic_vector(1 downto 0);
        ID_b_imm        : in     vl_logic_vector(31 downto 0);
        ID_j_imm        : in     vl_logic_vector(31 downto 0);
        ID_i_imm        : in     vl_logic_vector(31 downto 0);
        EX_jmp_pc       : out    vl_logic_vector(31 downto 0);
        EX_pc_mux_sel   : out    vl_logic;
        flush           : out    vl_logic;
        EX_forwarding_sel1: in     vl_logic_vector(1 downto 0);
        EX_forwarding_sel2: in     vl_logic_vector(1 downto 0)
    );
end EX_stage;
