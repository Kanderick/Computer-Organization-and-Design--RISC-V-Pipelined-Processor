import rv32i_types::*;
module control_memory
(
    input rv32i_word instr,
    output rv32i_control_word ctrl
);

assign ctrl.opcode = rv32i_opcode'(instr[6:0]);
assign ctrl.i_imm = {{21{instr[31]}}, instr[30:20]};
assign ctrl.s_imm = {{21{instr[31]}}, instr[30:25], instr[11:7]};
assign ctrl.b_imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
assign ctrl.u_imm = {instr[31:12], 12'h000};
assign ctrl.j_imm = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
assign ctrl.rs1 = instr[19:15];
assign ctrl.rs2 = instr[24:20];
assign ctrl.rd = instr[11:7];
assign ctrl.funct3 = instr[14:12];  

logic bit30;
assign bit30 = instr[30];

always_comb begin
    /* Default assignments */
    ctrl.load_regfile = 1'b0;
    ctrl.alumux1_sel = 1'b0;
    ctrl.alumux2_sel = 3'b00;
    ctrl.regfilemux_sel = 2'b00;
    ctrl.cmpmux_sel = 1'b0;
    ctrl.aluop = alu_ops'(ctrl.funct3);
    ctrl.cmpop = branch_funct3_t'(ctrl.funct3);
    ctrl.mem_read = 1'b0;
    ctrl.mem_write = 1'b0;
    ctrl.mem_byte_enable = 4'b1111;
    ctrl.jb_sel = 2'b11;
    /* Assign control signals based on opcode */
    case(ctrl.opcode)
        op_auipc: begin
            ctrl.load_regfile = 1;
            ctrl.alumux1_sel = 1;
            ctrl.alumux2_sel = 1;            
            ctrl.aluop = alu_add;
        end
        op_lui: begin
            ctrl.load_regfile = 1;
            ctrl.regfilemux_sel = 2;            
        end
        op_br   : begin
            ctrl.alumux1_sel = 1;
            ctrl.alumux2_sel = 2;
        end
        op_store: begin
            ctrl.aluop = alu_add;
            ctrl.alumux2_sel = 3'h3;
            ctrl.mem_write = 1;            
            case(ctrl.funct3)
               sb: ctrl.mem_byte_enable = 4'b0001;
               sh: ctrl.mem_byte_enable = 4'b0011;
               sw: ctrl.mem_byte_enable = 4'b1111;
               default: ctrl.mem_byte_enable = 4'b1111;
            endcase 
        end
        op_load: begin
            ctrl.aluop = alu_add;
            ctrl.mem_read = 1;
            ctrl.regfilemux_sel = 3;
            ctrl.load_regfile = 1;            
        end
        op_imm: begin
            ctrl.load_regfile = 1;
            case(ctrl.funct3)
                slt: begin
                    ctrl.cmpop = blt;
                    ctrl.regfilemux_sel = 1;
                    ctrl.cmpmux_sel = 1;
                end 
                sltu: begin
                    ctrl.cmpop = bltu;
                    ctrl.regfilemux_sel = 1;
                    ctrl.cmpmux_sel = 1; 
                end
                sr: begin
                    if (bit30 == 1)
                        ctrl.aluop = alu_sra;
                end
                default: ;
             endcase           
        end
        op_reg:  begin
            ctrl.load_regfile = 1;
            ctrl.alumux2_sel = 4;
            case(ctrl.funct3)
                slt: begin
                    ctrl.cmpop = blt;
                    ctrl.regfilemux_sel = 1;
                end 
                sltu: begin
                    ctrl.cmpop = bltu;
                    ctrl.regfilemux_sel = 1;
                end
                sr: begin
                    if (bit30 == 1)
                        ctrl.aluop = alu_sra;
                end
                add: begin
                    if (bit30 == 1)
                        ctrl.aluop = alu_sub;
                end
                default: ;
             endcase                
        end
        op_jal:  begin
            ctrl.load_regfile = 1;
            ctrl.regfilemux_sel = 4;// correspond to pc+4            
            ctrl.alumux1_sel = 1; //pc goes to alu
            ctrl.alumux2_sel = 5; //j-imm goes to alu
            ctrl.jb_sel = 2'b1;
        end
        op_jalr: begin
            ctrl.load_regfile = 1;
            ctrl.regfilemux_sel = 4;// correspond to pc+4  
            ctrl.jb_sel = 2'h2;
        end
        default: begin
            ctrl = 0;   /* Unknown opcode, set control word to zero */
        end
    endcase
end
endmodule

