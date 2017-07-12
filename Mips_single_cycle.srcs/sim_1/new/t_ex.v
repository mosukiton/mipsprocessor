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
// Additional Comments: Just like with t_id, full testing of alu.v is not needed
// as that was done in t_alu. This testbench tests the multiplexers in this block
// to make sure they work as intended, as well as the wires are connected
// correctly. The branch adder is also given a simple test too.
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
        .ZerowireE( zerowire ),
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
        pcplus4 = 0; srca = 0; regread2 = 0; signimm = 0;
        rt = 0; rd = 0;
        alucontrol = 0;
        alusrc = 0; regdst = 0; regwrite1 = 0; memtoreg1 = 0; memwrite1 = 0; branch1 = 0;

        // display test signals 
        $display(srca);
        $display(regread2);

        // Wait 100ns for global resets
        #100;

        // Test RegDst
        rt = 5'b01000; rd = 5'b01001; regdst = 1;
        #20 regdst = 0; // writereg should switch from 0x09 to 0x08
        #20 rt = 0; rd = 0; // reset

        #100;

        // Test ALUSrc with ALUControl (i.e. simulate a I-type and R-type instruction)
        #20 srca = 32'h00001111; regread2 = 32'hFFFF0000; signimm = 32'hFFFFFFFF; alusrc = 0; alucontrol = 3'b001; // r-type or instruction
        // expected output should be 00001111 OR FFFF0000 = FFFF1111;
        #20 alusrc = 1; // i-type or instruction,  expected output should be 00001111 OR FFFFFFFF = FFFFFFFF
        #20 srca = 0; regread2 = 0; signimm = 0; alusrc = 0; alucontrol = 3'b000; // reset

        #100;

        // Test Branch Circuit
        pcplus4 = 32'h00000004; signimm = 32'h00000001; // expected output: pcbranch =  4 + (1<<2) = 32'h00000008;
    end

endmodule
