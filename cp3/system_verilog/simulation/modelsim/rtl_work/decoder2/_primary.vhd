library verilog;
use verilog.vl_types.all;
entity decoder2 is
    port(
        i0              : in     vl_logic;
        en              : in     vl_logic;
        o0              : out    vl_logic;
        o1              : out    vl_logic
    );
end decoder2;
