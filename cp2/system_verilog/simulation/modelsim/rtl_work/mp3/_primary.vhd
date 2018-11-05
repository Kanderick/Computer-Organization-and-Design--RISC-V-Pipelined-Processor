library verilog;
use verilog.vl_types.all;
entity mp3 is
    port(
        clk             : in     vl_logic;
        read            : out    vl_logic;
        write           : out    vl_logic;
        address         : out    vl_logic_vector(31 downto 0);
        wdata           : out    vl_logic_vector(255 downto 0);
        resp            : in     vl_logic;
        rdata           : in     vl_logic_vector(255 downto 0)
    );
end mp3;
