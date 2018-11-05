library verilog;
use verilog.vl_types.all;
entity IF_stage is
    port(
        clk             : in     vl_logic;
        EX_jmp_pc       : in     vl_logic_vector(31 downto 0);
        pcmux_sel       : in     vl_logic;
        pc_load         : in     vl_logic;
        IF_addr         : out    vl_logic_vector(31 downto 0)
    );
end IF_stage;
