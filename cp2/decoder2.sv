module decoder2
(
input i0,
input en,
output logic o0,
output logic o1
);

always_comb begin
    o0 = 0;
    o1 = 0;
    case(i0)
    0: o0 = en;
    1: o1 = en;
    endcase
end

endmodule