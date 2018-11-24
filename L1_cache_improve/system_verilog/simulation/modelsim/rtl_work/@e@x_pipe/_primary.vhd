library verilog;
use verilog.vl_types.all;
entity EX_pipe is
    port(
        ID_pc           : in     vl_logic_vector(31 downto 0);
        ID_rs1_out      : in     vl_logic_vector(31 downto 0);
        ID_rs2_out      : in     vl_logic_vector(31 downto 0);
        ID_jmp_pc       : in     vl_logic_vector(31 downto 0);
        ID_pc_mux_sel   : in     vl_logic;
        ID_flush        : in     vl_logic;
        EX_pc           : out    vl_logic_vector(31 downto 0);
        EX_rs1_out      : out    vl_logic_vector(31 downto 0);
        EX_rs2_out      : out    vl_logic_vector(31 downto 0);
        EX_jmp_pc       : out    vl_logic_vector(31 downto 0);
        EX_pc_mux_sel   : out    vl_logic;
        flush           : out    vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load            : in     vl_logic
    );
end EX_pipe;
