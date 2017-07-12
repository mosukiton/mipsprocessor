`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2017 22:01:56
// Design Name: 
// Module Name: t_ex
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


module t_ex;

    // Inputs
    reg [31:0] pcplus4, srca, regread2, signimm;
    reg [4:0] rt, rd;
    reg [2:0] alucontrol;
    reg alusrc, regdst, regwrite1, memtoreg1, memwrite1, branch1;

    // Outputs
    wire [31:0] aluresult, pcbranch, writedata;
    wire [4:0] writereg;
    wire regwrite2, memtoreg2, memwrite2, branch2, zerowire;

    execute uut(
        .ALUResult( aluresult ),
        .PCBranchE( pcbranch ),
        .WriteDataE( writedata ),
        .WriteRegE( writereg ),
        .RegWriteE2( regwrite2 ),
        .MemToRegE2( memtoreg2 ),
        .MemWriteE2( memwrite2 ),
        .BranchE2( branch2 ),
        .ZeroE( zerowire ),
        .PCPlus4E( pcplus4 ),
        .srcA( srca ),
        .RegRead2( regread2 ),
        .SignImmE( signimm ),
        .rt( rt ),
        .rd( rd ),
        .ALUControlE( alucontrol ),
        .ALUSrcE( alusrc ),
        .RegDstE( regdst ),
        .RegWriteE1( regwrite1 ),
        .MemToRegE1( memtoreg1 ),
        .MemWriteE1( memwrite1 ),
        .BranchE1( branch1 )
    );

    initial begin

        // Initialise the inputs


        // Wait 100ns for global resets


        //Stimulus here

    end

endmodule
