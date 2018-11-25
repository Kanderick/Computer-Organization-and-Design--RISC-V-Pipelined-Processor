library verilog;
use verilog.vl_types.all;
entity WB_pipe is
    port(
        MEM_cmp_out     : in     vl_logic;
        MEM_alu_out     : in     vl_logic_vector(31 downto 0);
        MEM_rdata       : in     vl_logic_vector(31 downto 0);
        MEM_pc          : in     vl_logic_vector(31 downto 0);
        WB_cmp_out      : out    vl_logic;
        WB_alu_out      : out    vl_logic_vector(31 downto 0);
        WB_rdata        : out    vl_logic_vector(31 downto 0);
        WB_pc           : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        load            : in     vl_logic;
        reset           : in     vl_logic
    );
end WB_pipe;
