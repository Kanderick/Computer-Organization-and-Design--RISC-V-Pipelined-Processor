library verilog;
use verilog.vl_types.all;
library work;
entity cpu_datapath is
    port(
        clk             : in     vl_logic;
        pcmux_sel       : in     vl_logic;
        marmux_sel      : in     vl_logic;
        alumux1_sel     : in     vl_logic;
        cmpmux_sel      : in     vl_logic;
        alumux2_sel     : in     vl_logic_vector(2 downto 0);
        regfilemux_sel  : in     vl_logic_vector(2 downto 0);
        load_pc         : in     vl_logic;
        load_ir         : in     vl_logic;
        load_MDR        : in     vl_logic;
        instr_data      : in     vl_logic;
        load_MAR        : in     vl_logic;
        load_regfile    : in     vl_logic;
        load_mem_data_out: in     vl_logic;
        aluop           : in     work.rv32i_types.alu_ops;
        cmpop           : in     work.rv32i_types.branch_funct3_t;
        mem_rdata       : in     vl_logic_vector(31 downto 0);
        funct3          : out    vl_logic_vector(2 downto 0);
        funct7          : out    vl_logic_vector(6 downto 0);
        opcode          : out    work.rv32i_types.rv32i_opcode;
        mem_address     : out    vl_logic_vector(31 downto 0);
        mem_wdata       : out    vl_logic_vector(31 downto 0);
        br_en           : out    vl_logic
    );
end cpu_datapath;
