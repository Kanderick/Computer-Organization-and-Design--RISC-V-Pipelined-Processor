module victim_cache_rdata_logic
(
	input [3:0] hit_way,
	input [255:0] data0,
	input [255:0] data1,
	input [255:0] data2,
	input [255:0] data3,
	input [255:0] vc_pmem_rdata,
	input rdata_sel,
	output logic [255:0] l2_vc_rdata
);

	logic [255:0] out_data;
	
always_comb
begin
	case (hit_way)
		4'b1000: out_data = data3;
		4'b0100: out_data = data2;
		4'b0010: out_data = data1;
		default: out_data = data0;
	endcase
	
	if (rdata_sel == 0) l2_vc_rdata = out_data;
	else l2_vc_rdata = vc_pmem_rdata;
end

endmodule	: victim_cache_rdata_logic