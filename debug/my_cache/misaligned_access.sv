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

module misaligned_read_8
(
input [7:0] byte_0,
input [7:0] byte_1,
input [7:0] byte_2,
input [7:0] byte_3,
input [1:0] alignment,
output logic [31:0] word_out
);
assign word_out = {byte_3,byte_2,byte_1,byte_0} >> (alignment*8);
endmodule

module misaligned_write_8
(
input [7:0] byte_0,
input [7:0] byte_1,
input [7:0] byte_2,
input [7:0] byte_3,
input [31:0] write_word,
input [1:0] alignment,
input [3:0] mem_byte_enable,
output logic [7:0] modified_out0,
output logic [7:0] modified_out1,
output logic [7:0] modified_out2,
output logic [7:0] modified_out3

);
logic [7:0] original_word[4];
assign original_word[0] = byte_0;
assign original_word[1] = byte_1;
assign original_word[2] = byte_2;
assign original_word[3] = byte_3;

logic [7:0] modified_word[4];
assign modified_out0 = modified_word[0];
assign modified_out1 = modified_word[1];
assign modified_out2 = modified_word[2];
assign modified_out3 = modified_word[3];

int i;
logic [31:0] shifted_word;
logic [3:0] shifted_byte_enable;           
always_comb begin
    shifted_word = write_word << (alignment*8);
    shifted_byte_enable = mem_byte_enable << alignment;
    for (i = 0; i < 4; i++)
        if(shifted_byte_enable[i] == 0)
            modified_word[i] = original_word[i];
        else   
            modified_word[i] = shifted_word[i*8+:8];
end
endmodule
