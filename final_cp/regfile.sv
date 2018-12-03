
module regfile
(
    input clk,
    input load,
    input [31:0] in,
    input [4:0] src_a, src_b, dest,
    output logic [31:0] reg_a, reg_b
);

logic [31:0] data [32] /* synthesis ramstyle = "logic" */;

/* Altera device registers are 0 at power on. Specify this
 * so that Modelsim works as expected.
 */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 32'b0;
    end
end

always_ff @(posedge clk)
begin
    if (load && dest)
    begin
        data[dest] = in;
    end
end

always_comb
begin
	 if(src_a==0)
	 begin
		reg_a=0;
	 end
	 else if(src_a==dest && load)
	 begin
		reg_a=in;
	 end
	 else
	 begin
		reg_a=data[src_a];
	 end
	 
	 if(src_b==0)
	 begin
		reg_b=0;
	 end
	 else if(src_b==dest && load)
	 begin
		reg_b=in;
	 end
	 else
	 begin
		reg_b=data[src_b];
	 end
end

endmodule : regfile
