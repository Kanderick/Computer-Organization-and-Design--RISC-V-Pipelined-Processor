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
    ctrl.aluop = alu_ops'(funct3);
    ctrl.cmpop = branch_funct3_t'(funct3);
    ctrl.mem_read = 1'b0;
    ctrl.mem_write = 1'b0;
    ctrl.mem_byte_enable = 4'b1111;
    ctrl.jb_sel = 2'b0;
    /* Assign control signals based on opcode */
    case(opcode)
        op_auipc: begin
            ctrl.load_regfile = 1;
            ctrl.alumux1_sel = 1;
            ctrl.alumux2_sel = 1;            
            ctrl.aluop = alu_add;
        end
        op_lui: begin
            ctrl.load_regfile = 1;
            ctrl.load_pc = 1;
            ctrl.regfilemux_sel = 2;            
        end
        op_br   : begin
            ctrl.load_pc = 1;
            ctrl.alumux1_sel = 1;
            ctrl.alumux2_sel = 2;
        end
        op_store: begin
            ctrl.aluop = alu_add;
            ctrl.alumux2_sel = 3'h3;
            mem_write = 1;            
            case(funct3)
               sb: mem_byte_enable = 4'b0001;
               sh: mem_byte_enable = 4'b0011;
               sw: mem_byte_enable = 4'b1111;
               default: mem_byte_enable = 4'b1111;
            endcase 
        end
        op_load: begin
            ctrl.aluop = alu_add;
            mem_read = 1;
            regfilemux_sel = 3;
            load_regfile = 1;            
        end
        op_imm: begin
            load_regfile = 1;
            case(funct3)
                slt: begin
                    cmpop = blt;
                    regfilemux_sel = 1;
                    cmpmux_sel = 1;
                end 
                sltu: begin
                    cmpop = bltu;
                    regfilemux_sel = 1;
                    cmpmux_sel = 1; 
                end
                sr: begin
                    if (bit30 == 1)
                        aluop = alu_sra;
                end
                default: ;
             endcase           
        end
        op_reg:  begin
            load_regfile = 1;
            alumux2_sel = 4;
            case(funct3)
                slt: begin
                    cmpop = blt;
                    regfilemux_sel = 1;
                end 
                sltu: begin
                    cmpop = bltu;
                    regfilemux_sel = 1;
                end
                sr: begin
                    if (bit30 == 1)
                        aluop = alu_sra;
                end
                add: begin
                    if (bit30 == 1)
                        aluop = alu_sub;
                end
                default: ;
             endcase                
        end
        op_jal:  begin
            load_regfile = 1;
            regfilemux_sel = 4;// correspond to pc+4            
            alumux1_sel = 1; //pc goes to alu
            alumux2_sel = 5; //j-imm goes to alu
            jb_sel = 2'b1;
        end
        op_jalr: begin
            load_regfile = 1;
            regfilemux_sel = 4;// correspond to pc+4  
            jb_sel = 2'h2;
        end
        default: begin
            ctrl = 0;   /* Unknown opcode, set control word to zero */
        end
    endcase
end
endmodule



    
endmodule