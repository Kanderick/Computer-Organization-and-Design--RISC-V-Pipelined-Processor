library verilog;
use verilog.vl_types.all;
entity ID_pipe is
    port(
        IF_pc           : in     vl_logic_vector(31 downto 0);
        ID_pc           : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load            : in     vl_logic
    );
end ID_pipe;
