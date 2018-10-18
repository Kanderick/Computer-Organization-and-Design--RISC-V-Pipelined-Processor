library verilog;
use verilog.vl_types.all;
entity data_load_logic is
    port(
        LRU             : in     vl_logic;
        hitway          : in     vl_logic;
        load_data_select: in     vl_logic_vector(1 downto 0);
        load_1          : out    vl_logic;
        load_2          : out    vl_logic
    );
end data_load_logic;
