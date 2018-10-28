library verilog;
use verilog.vl_types.all;
entity MEM_stage is
    port(
        MEM_rs2_out     : in     vl_logic_vector(31 downto 0);
        MEM_alu_out     : in     vl_logic_vector(31 downto 0);
        MEM_addr        : out    vl_logic_vector(31 downto 0);
        MEM_data        : out    vl_logic_vector(31 downto 0)
    );
end MEM_stage;
