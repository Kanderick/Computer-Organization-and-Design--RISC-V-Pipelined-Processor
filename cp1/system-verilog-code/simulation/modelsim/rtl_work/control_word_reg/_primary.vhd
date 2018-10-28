library verilog;
use verilog.vl_types.all;
library work;
entity control_word_reg is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        control_signal_in: in     work.rv32i_types.rv32i_control_word;
        control_signal_out: out    work.rv32i_types.rv32i_control_word;
        load_control_word: in     vl_logic
    );
end control_word_reg;
