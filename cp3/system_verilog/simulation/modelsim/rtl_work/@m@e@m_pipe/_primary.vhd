library verilog;
use verilog.vl_types.all;
entity MEM_pipe is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load            : in     vl_logic;
        EX_pc           : in     vl_logic_vector(31 downto 0);
        EX_alu_out      : in     vl_logic_vector(31 downto 0);
        EX_rs2_out      : in     vl_logic_vector(31 downto 0);
        EX_cmp_out      : in     vl_logic;
        MEM_pc          : out    vl_logic_vector(31 downto 0);
        MEM_alu_out     : out    vl_logic_vector(31 downto 0);
        MEM_rs2_out     : out    vl_logic_vector(31 downto 0);
        MEM_cmp_out     : out    vl_logic;
        EX_jmp_pc       : in     vl_logic_vector(31 downto 0);
        EX_pc_mux_sel   : in     vl_logic;
        EX_flush        : in     vl_logic;
        MEM_jmp_pc      : out    vl_logic_vector(31 downto 0);
        MEM_pc_mux_sel  : out    vl_logic;
        flush           : out    vl_logic
    );
end MEM_pipe;
