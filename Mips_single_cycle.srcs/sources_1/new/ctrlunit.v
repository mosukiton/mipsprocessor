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

    wire [1:0] ALUOp;
    //wire zerosignal;

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
    output  [1:0] aluop);

    reg [8:0] controls;

    assign {memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop} = controls;

    always @ (op) begin
        case(op)
            6'b000000:  controls <= 9'b000011011; //Rtype
            6'b100011:  controls <= 9'b100101000; //LW
            6'b101011:  controls <= 9'b010100000; //SW
            6'b000100:  controls <= 9'b001000001; //BEQ
            6'b001000:  controls <= 9'b000101000; //ADDI
            6'b000010:  controls <= 9'b000000100; //J
            default:    controls <= 9'bxxxxxxxxx; //???
        endcase
    end
endmodule

module aludecoder(
    output reg [2:0] alucontrol,
    input [5:0] funct,
    input [1:0] aluop
    );

    always @ (aluop or funct) begin
        case(aluop)
            2'b00:  alucontrol <= 3'b010; //addi
            2'b01:  alucontrol <= 3'b110; //sub, although not needed
            default:    case(funct)             // Rtype
                6'b100000:  alucontrol <= 3'b010; // ADD
                6'b100010:  alucontrol <= 3'b110; // SUB
                6'b100100:  alucontrol <= 3'b000; // AND
                6'b100101:  alucontrol <= 3'b001; // OR
                6'b101010:  alucontrol <= 3'b111; // SLT
                default:    alucontrol <= 3'bxxx; // unused
            endcase
        endcase
    end

endmodule
