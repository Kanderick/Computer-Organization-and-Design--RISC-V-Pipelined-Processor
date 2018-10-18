library verilog;
use verilog.vl_types.all;
library work;
entity cpu_control is
    port(
        clk             : in     vl_logic;
        opcode          : in     work.rv32i_types.rv32i_opcode;
        funct3          : in     vl_logic_vector(2 downto 0);
        funct7          : in     vl_logic_vector(6 downto 0);
        br_en           : in     vl_logic;
        load_pc         : out    vl_logic;
        load_ir         : out    vl_logic;
        load_regfile    : out    vl_logic;
        load_MAR        : out    vl_logic;
        load_MDR        : out    vl_logic;
        instr_data      : out    vl_logic;
        load_mem_data_out: out    vl_logic;
        pcmux_sel       : out    vl_logic;
        marmux_sel      : out    vl_logic;
        alumux1_sel     : out    vl_logic;
        cmpmux_sel      : out    vl_logic;
        alumux2_sel     : out    vl_logic_vector(2 downto 0);
        regfilemux_sel  : out    vl_logic_vector(2 downto 0);
        aluop           : out    work.rv32i_types.alu_ops;
        cmpop           : out    work.rv32i_types.branch_funct3_t;
        mem_resp        : in     vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_byte_enable : out    vl_logic_vector(3 downto 0)
    );
end cpu_control;
