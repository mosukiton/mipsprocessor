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

    wire [31:0] PCPlus4F2D, PCPlus4D2E;
    wire [31:0] PCBranchM2F, PCBranchE2M;
    wire [31:0] instruction;

    wire [31:0] RFRead1D2E, RFRead2D2E;
    wire [31:0] ImmSeD2E;
    wire [31:0] ResultW2D;
    wire [27:0] WAInstrD2F;
    wire [4:0] rtD2E, rdD2E, WriteRegW2D;

    wire [2:0] ALUControlD2E;
    wire PCSrcM2F, JumpD2F, RegWriteD2E, MemToRegD2E, MemWriteD2E, BranchD2E, ALUSrcD2E, RegDstD2E;
    wire RegWriteW2D;

    wire [31:0] ReadDataM2W, ALUResultOutM2W;
    wire [4:0] WriteRegM2W;
    wire RegWriteM2W, MemToRegM2W;

    wire [31:0] ALUResultE2M, WriteDataE2M;
    wire [4:0] WriteRegE2M;
    wire RegWriteE2M, MemToRegE2M, BranchE2M, ZerowireE2M, MemWriteE2M;

    instructionfetch IF(
        .instruction( instruction ),
        .PCBranchF( PCBranchM2F ), .WAinstrF( WAInstrD2F ), .PCPlus4F( PCPlus4F2D ),
        .clk( clk ), .reset( reset ),
        .JumpF( JumpD2F ), .PCSrcF( PCSrcM2F )
    );


    instructiondecode ID(
        .read1( RFRead1D2E ), .read2( RFRead2D2E ),
        .immediateSE( ImmSeD2E ),
        .PCPlus4D2( PCPlus4D2E ),
        .WAinstrD( WAInstrD2F ),
        .rt( rtD2E ), .rd( rdD2E ),
        .ALUControlD( ALUControlD2E ),
        .RegWriteD( RegWriteD2E ), .MemToRegD( MemToRegD2E ), .MemWriteD( MemWriteD2E ), .BranchD( BranchD2E ), .ALUSrcD( ALUSrcD2E ), .RegDstD( RegDstD2E ), .JumpD( JumpD2F ),
        .PCPlus4D1( PCPlus4F2D ),
        .instruction( instruction ),
        .ResultW( ResultW2D ), .WriteRegW( WriteRegW2D ), .RegWriteW( RegWriteW2D ),
        .clk( clk )
    );

    execute EX(
        .ALUResult( ALUResultE2M ),
        .PCBranchE( PCBranchE2M ),
        .WriteDataE( WriteDataE2M ),
        .WriteRegE( WriteRegE2M ),
        .RegWriteE2( RegWriteE2M ), .MemToRegE2( MemToRegE2M ), .MemWriteE2( MemWriteE2M ), .BranchE2( BranchE2M ),
        .ZerowireE( ZerowireE2M ),
        .PCPlus4E( PCPlus4D2E ),
        .srcA( RFRead1D2E ), .RegRead2( RFRead2D2E ), .SignImmE( ImmSeD2E ),
        .rt( rtD2E ), .rd( rdD2E ),
        .ALUControlE( ALUControlD2E ),
        .ALUSrcE( ALUSrcD2E ), .RegDstE( RegDstD2E ),
        .RegWriteE1( RegWriteD2E ), .MemToRegE1( MemToRegD2E ), .MemWriteE1( MemWriteD2E ), .BranchE1( BranchD2E )
    );

    memoryaccess MEM(
        .ReadDataM( ReadDataM2W ),
        .ALUResultOut( ALUResultOutM2W ),
        .PCBranchM2( PCBranchM2F ),
        .WriteRegM2( WriteRegM2W ),
        .RegWriteM2( RegWriteM2W ),
        .MemToRegM2( MemToRegM2W ),
        .PCSrcM( PCSrcM2F ),
        .WriteDataM( WriteDataE2M ),
        .ALUResultIn( ALUResultE2M ),
        .PCBranchM1( PCBranchE2M ),
        .WriteRegM1( WriteRegE2M ),
        .BranchM( BranchE2M ),
        .MemWriteM( MemWriteE2M ),
        .MemToRegM1( MemToRegE2M ),
        .RegWriteM1( RegWriteE2M ),
        .ZerowireM( ZerowireE2M ),
        .clk( clk )
    );

    writeback WB(
        .ResultW( ResultW2D ),
        .WriteRegW2( WriteRegW2D ),
        .RegWriteW2( RegWriteW2D ),
        .ReadDataW( ReadDataM2W ),
        .ALUResultW( ALUResultOutM2W ),
        .WriteRegW1( WriteRegM2W ),
        .MemToRegW( MemToRegM2W ),
        .RegWriteW1( RegWriteM2W )
    );

    assign PCSrcM2F = BranchE2M & ZerowireE2M;

    initial begin
        $display(singlecycleprocessor.IF.PC);
    end

endmodule
