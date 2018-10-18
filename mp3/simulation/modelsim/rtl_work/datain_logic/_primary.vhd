library verilog;
use verilog.vl_types.all;
entity datain_logic is
    port(
        hit_way         : in     vl_logic;
        mem_wdata       : in     vl_logic_vector(31 downto 0);
        mem_byte_enable : in     vl_logic_vector(3 downto 0);
        offset          : in     vl_logic_vector(2 downto 0);
        byte_offset     : in     vl_logic_vector(1 downto 0);
        data_1          : in     vl_logic_vector(255 downto 0);
        data_2          : in     vl_logic_vector(255 downto 0);
        mem_wdata_out   : out    vl_logic_vector(255 downto 0)
    );
end datain_logic;
