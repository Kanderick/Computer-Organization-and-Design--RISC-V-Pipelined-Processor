library verilog;
use verilog.vl_types.all;
entity L1Icache_control is
    port(
        clk             : in     vl_logic;
        cpu_l1i_read    : in     vl_logic;
        cpu_l1i_resp    : out    vl_logic;
        l1i_arbi_read   : out    vl_logic;
        l1i_arbi_resp   : in     vl_logic;
        hit             : in     vl_logic;
        ld_lru          : out    vl_logic;
        ld_tag          : out    vl_logic;
        ld_valid        : out    vl_logic;
        ld_data         : out    vl_logic
    );
end L1Icache_control;
