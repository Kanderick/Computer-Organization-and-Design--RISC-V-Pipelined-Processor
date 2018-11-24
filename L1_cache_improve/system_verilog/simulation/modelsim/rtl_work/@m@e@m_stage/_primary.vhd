library verilog;
use verilog.vl_types.all;
entity MEM_stage is
    port(
        MEM_rs2_out     : in     vl_logic_vector(31 downto 0);
        MEM_alu_out     : in     vl_logic_vector(31 downto 0);
        MEM_rs2         : in     vl_logic_vector(4 downto 0);
        WB_rd           : in     vl_logic_vector(4 downto 0);
        WB_in           : in     vl_logic_vector(31 downto 0);
        WB_writeback    : in     vl_logic;
        MEM_addr        : out    vl_logic_vector(31 downto 0);
        MEM_data        : out    vl_logic_vector(31 downto 0);
        MEM_cmp_out     : in     vl_logic;
        u_imm           : in     vl_logic_vector(31 downto 0);
        pc              : in     vl_logic_vector(31 downto 0);
        regfilemux_sel  : in     vl_logic_vector(2 downto 0);
        forwarding_out  : out    vl_logic_vector(31 downto 0)
    );
end MEM_stage;
