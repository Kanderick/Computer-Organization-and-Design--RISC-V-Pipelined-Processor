library verilog;
use verilog.vl_types.all;
library work;
entity control_memory is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        ctrl            : out    work.rv32i_types.rv32i_control_word
    );
end control_memory;
