library verilog;
use verilog.vl_types.all;
entity WB_MEM_EX_forwarding is
    port(
        EX_rs1          : in     vl_logic_vector(4 downto 0);
        EX_rs2          : in     vl_logic_vector(4 downto 0);
        MEM_rd          : in     vl_logic_vector(4 downto 0);
        WB_rd           : in     vl_logic_vector(4 downto 0);
        MEM_regfilemux_sel: in     vl_logic_vector(2 downto 0);
        MEM_writeback   : in     vl_logic;
        WB_writeback    : in     vl_logic;
        forwarding_sel1 : out    vl_logic_vector(1 downto 0);
        forwarding_sel2 : out    vl_logic_vector(1 downto 0);
        MEM_EX_rdata_hazard: out    vl_logic
    );
end WB_MEM_EX_forwarding;
