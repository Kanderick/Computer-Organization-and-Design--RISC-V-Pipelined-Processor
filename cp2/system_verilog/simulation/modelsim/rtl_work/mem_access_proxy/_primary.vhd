library verilog;
use verilog.vl_types.all;
entity mem_access_proxy is
    port(
        clk             : in     vl_logic;
        stage_read      : in     vl_logic;
        stage_write     : in     vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_resp        : in     vl_logic;
        mem_rdata       : in     vl_logic_vector(31 downto 0);
        pipe_load       : in     vl_logic;
        stage_rdata     : out    vl_logic_vector(31 downto 0);
        stage_resp      : out    vl_logic
    );
end mem_access_proxy;
