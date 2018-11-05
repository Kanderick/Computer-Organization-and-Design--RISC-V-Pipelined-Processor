import rv32i_types::*; /* Import types defined in rv32i_types.sv */
module MDR 
(
		input clk,
		input load,
		input instr_data,
		input [2:0] funct3,
		input [31:0] in,
		output logic [31:0] out
);

logic [31:0] data;
load_funct3_t load_op;
assign load_op = load_funct3_t'(funct3);
/* Altera device registers are 0 at power on. Specify this
 * so that Modelsim works as expected.
 */
initial
begin
    data = 1'b0;
end

always_ff @(posedge clk)
begin
    if (load && instr_data==1'b1)
    begin
		case(load_op)
			lb:
			begin	
				data = {{25{in[7]}},in[6:0]};
			end
			lh:
			begin
				data = {{17{in[15]}}, in[14:0]};
			end
			lw:
			begin
				data = in;
			end
			lbu:
			begin
				data = {24'b0,in[7:0]};
			end
			lhu:
			begin
				data = {16'b0, in[15:0]};
			end
			default:
			begin
				data = in;
			end
		endcase
    end
	 if (load && instr_data == 1'b0)
	 begin
		data = in;
	 end
end

always_comb
begin
    out = data;
end
endmodule : MDR 
