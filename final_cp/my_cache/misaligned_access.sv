module misaligned_read
(
input [31:0] word_32,
input [1:0] alignment,
output logic [31:0] word_out
);
assign word_out = word_32 >> (alignment*8);
endmodule

module misaligned_write
(
input [31:0] original_word_32,
input [31:0] write_word,
input [1:0] alignment,
input [3:0] mem_byte_enable,
output logic [31:0] word_out
);

int i;
logic [31:0] shifted_word;
logic [3:0] shifted_byte_enable;           
always_comb begin
    shifted_word = write_word << (alignment*8);
    shifted_byte_enable = mem_byte_enable << alignment;
    for (i = 0; i < 4; i++)
        if(shifted_byte_enable[i] == 0)
            word_out[i*8+:8] = original_word_32[i*8+:8];
        else   
            word_out[i*8+:8] = shifted_word[i*8+:8];
end
endmodule