`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2017 17:24:09
// Design Name: 
// Module Name: ctrlunit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Based off the code provided by the professor for the assignment
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ctrlunit(
    input [5:0] OPCode, Funct,
    output MemToReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump,
    output [2:0] ALUControl
    );

    wire [1:0] aluop;
    wire zerosignal;

    maindecoder md_inst(
        .op( OPCode ),
        .memtoreg( MemToReg ),
        .memwrite( MemWrite ),
        .branch( Branch ),
        .alusrc( ALUSrc ),
        .regdst( RegDst ),
        .regwrite( RegWrite ),
        .jump( Jump ),
        .aluop( ALUOp )
    );

    aludecoder  ad_inst(
        .funct( Funct ),
        .aluop( ALUOp ),
        .alucontrol( ALUControl )
    );

    //PCSrc will be created at combining all the sections of the processor.
    //assign PCSrc = Branch & zerosignal;

endmodule

module maindecoder(
    input   [5:0] op,
    output  memtoreg, memwrite,
    output  branch, alusrc,
    output  regdst, regwrite,
    output  jump,
    output  [1:0] ALUOp);

    wire [8:0] controls;

    assign {memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop} = controls;

    case(op)
        6'b000000:  assign controls = 9'b000011011; //Rtype
        6'b100011:  assign controls = 9'b100101000; //LW
        6'b101011:  assign controls = 9'b010100000; //SW
        6'b000100:  assign controls = 9'b001000001; //BEQ
        6'b001000:  assign controls = 9'b000101000; //ADDI
        6'b000010:  assign controls = 9'b000000100; //J
        default:    assign controls = 9'bxxxxxxxxx; //???
    endcase
endmodule

module aludecoder(
    output [2:0] alucontrol,
    input [5:0] funct,
    input [1:0] aluop
    );

    case(aluop)
        2'b00:  assign alucontrol = 3'b010; //addi
        2'b01:  assign alucontrol = 3'b110; //sub, although not needed
        default:    case(funct)             // Rtype
            6'b100000:  assign alucontrol = 3'b010; // ADD
            6'b100010:  assign alucontrol = 3'b110; // SUB
            6'b100100:  assign alucontrol = 3'b000; // AND
            6'b100101:  assign alucontrol = 3'b001; // OR
            6'b101010:  assign alucontrol = 3'b111; // SLT
            default:    assign alucontrol = 3'bxxx; // unused
        endcase
    endcase

endmodule

