library verilog;
use verilog.vl_types.all;
library work;
entity JB_hazard_detection_unit is
    port(
        jb_sel          : in     vl_logic_vector(1 downto 0);
        cmpop           : in     work.rv32i_types.branch_funct3_t;
        ID_rs1_out      : in     vl_logic_vector(31 downto 0);
        ID_rs2_out      : in     vl_logic_vector(31 downto 0);
        pcmux_sel       : out    vl_logic;
        flush           : out    vl_logic
    );
end JB_hazard_detection_unit;
