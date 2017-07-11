`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2017 23:51:28
// Design Name: 
// Module Name: t_id
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


module t_id;

    // Inputs
    reg [31:0] pcplus41, instruction, resultw;
    reg [4:0] writereg;
    reg regwritew, clk;

    // Outputs
    wire [31:0] read1, read2, immse, pcplus42;
    wire [27:0] wainstr;
    wire [4:0] rt, rd;
    wire [2:0] alucontrol;
    wire regwrited, memtoreg, memwrite, branch, alusrc, regdst, jump;

    instructiondecode uut(
        .clk( clk ),
        .read1( read1 ),
        .read2( read2 ),
        .immediateSE( immse ),
        .PCPlus4D2( pcplus42 ),
        .WAinstrD( wainstr ),
        .rt( rt ),
        .rd( rd ),
        .ALUControlD( alucontrol ),
        .RegWriteD( regwrited ),
        .MemToRegD( memtoreg ),
        .MemWriteD( memwrite ),
        .BranchD( branch ),
        .ALUSrcD( alusrc ),
        .RegDstD( regdst ),
        .JumpD( jump ),
        .PCPlus4D1( pcplus41),
        .instruction( instruction ),
        .ResultW( resultw ),
        .WriteRegW( writereg ),
        .RegWriteW( regwritew )
    );

    initial begin
        clk = 0;
        forever begin
            #10 clk = 1;
            #10 clk = 0;
        end
    end

    // Write some test machine code instructions to test an R-type, I-type and J-type instruction and see if the decode works as intended



endmodule
