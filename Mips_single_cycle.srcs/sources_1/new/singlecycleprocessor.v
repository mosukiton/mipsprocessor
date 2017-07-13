`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2017 12:49:49
// Design Name: 
// Module Name: singlecycleprocessor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module singlecycleprocessor(
    input clk, reset
);

    // Control Signals
    wire [2:0] ALUControl;
    wire MemToReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump;
    wire Zerowire, PCSrc;

    // Instruction bus
    wire [31:0] instruction;

    wire [31:0] PCPlus4, RegRead1, RegRead2, Result, SignImm, ALUResult;
    wire [31:0] PCBranch, WriteData, ReadData;
    wire [27:0] WAJumpInstruction;
    wire [4:0] WriteReg, rt, rd;

    instructionfetch IF(
        .PCPlus4F( PCPlus4 ),
        .instruction( instruction ),
        .PCBranchF( PCBranch ),
        .WAinstrF( WAJumpInstruction ),
        .clk( clk ),
        .reset( reset ),
        .JumpF( Jump ),
        .PCSrcF( PCSrc )
    );

    instructiondecode ID(
        .read1( RegRead1 ),
        .read2( RegRead2 ),
        .immediateSE( SignImm ),
        .PCPlus4D2( PCPlus4 ),
        .WAinstrD( WAJumpInstruction ),
        .rt( rt ),
        .rd( rd ),
        .ALUControlD( ALUControl ),
        .RegWriteD( RegWrite ),
        .MemToRegD( MemToReg ),
        .MemWriteD( MemWrite ),
        .BranchD( Branch ),
        .ALUSrcD( ALUSrc ),
        .RegDstD( RegDst ),
        .JumpD( Jump ),
        .PCPlus4D1( PCPlus4 ),
        .instruction( instruction ),
        .ResultW( Result ),
        .WriteRegW( WriteReg ),
        .RegWriteW( RegWrite ),
        .clk( clk )
    );

    execute EX(
        .ALUResult( ALUResult ),
        .PCBranchE( PCBranch ),
        .WriteDataE( WriteData ),
        .WriteRegE( WriteReg ),
        .RegWriteE2( RegWrite ),
        .MemToRegE2( MemToReg ),
        .BranchE2( Branch ),
        .ZerowireE( Zerowire ),
        .PCPlus4E( PCPlus4 ),
        .srcA( RegRead1 ),
        .RegRead2( RegRead2 ),
        .SignImmE( SignImm ),
        .rt( rt ),
        .rd( rd ),
        .ALUControlE( ALUControl ),
        .ALUSrcE( ALUSrc ),
        .RegDstE( RegDst ),
        .RegWriteE1( RegWrite ),
        .MemToRegE1( MemToReg ),
        .MemWriteE1( MemWrite ),
        .BranchE1( Branch )
    );

    memoryaccess MEM(
        .ReadDataM( ReadData ),
        .ALUResultOut( ALUResult ),
        .PCBranchM2( PCBranch ),
        .WriteRegM2( WriteReg ),
        .RegWriteM2( RegWrite ),
        .MemToRegM2( MemToReg ),
        .PCSrcM( PCSrc ),
        .WriteDataM( WriteData ),
        .ALUResultIn( ALUResult ),
        .PCBranchM1( PCBranch ),
        .WriteRegM1( WriteReg ),
        .BranchM( Branch ),
        .MemWriteM( MemWrite ),
        .MemToRegM1( MemToReg ),
        .RegWriteM1( RegWrite ),
        .ZerowireM( Zerowire ),
        .clk( clk )
    );

    writeback WB(
        .ResultW( Result ),
        .WriteRegW2( WriteReg ),
        .RegWriteW2( RegWrite ),
        .ReadDataW( ReadData ),
        .ALUResultW( ALUResult ),
        .WriteRegW1( WriteReg ),
        .MemToRegW( MemToReg ),
        .RegWriteW1( RegWrite )
    );

    assign PCSrc = Branch & Zerowire;

    initial begin
        IF.PC = 0;
        $display(IF.PC);
    end

    //initial begin
        //IF.PCPrimeReg = 0;
        //$display(IF.PCPrimeReg);
    //end

endmodule
