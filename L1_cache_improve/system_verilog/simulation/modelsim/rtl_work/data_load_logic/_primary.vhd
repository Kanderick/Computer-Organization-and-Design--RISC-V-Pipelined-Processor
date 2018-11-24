library verilog;
use verilog.vl_types.all;
entity data_load_logic is
    port(
        load_data       : in     vl_logic;
        data_sel        : in     vl_logic;
        data_load_0     : out    vl_logic;
        data_load_1     : out    vl_logic
    );
end data_load_logic;
