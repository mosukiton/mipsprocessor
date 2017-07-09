`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2017 01:34:06
// Design Name: 
// Module Name: t_ctrlunit
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


module t_ctrlunit;

    // Inputs
    reg [5:0] opcode, funct;

    // Outputs
    wire memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump;
    wire [2:0] alucontrol;

    // Initialise the Unit Under Test
    ctrlunit uut(
        .OPCode( opcode ),
        .Funct( funct ),
        .MemToReg( memtoreg ),
        .MemWrite( memwrite ),
        .Branch( branch ),
        .ALUSrc( alusrc ),
        .RegDst( regdst ),
        .RegWrite( regwrite ),
        .Jump( jump ),
        .ALUControl( alucontrol )
    );

    initial begin
        // Initialise Inputs
        opcode = 0;
        funct = 0;

        // Wait 100 ns for global resets to finish
        #100;

        // Stimulus here
        #10 opcode = 6'h00; funct = 6'h20; // rtype ADD, regdst, regwrite, aluop=11, alucontrol=2(add)
        #40;

        #10 opcode = 6'h00; funct = 6'h22; // rtype SUB, regdst, regwrite, aluop=11, alucontrol=6(sub)
        #40;

        #10 opcode = 6'h00; funct = 6'h24; // rtype AND, regdst, regwrite, aluop=11, alucontrol=0(and)
        #40;

        #10 opcode = 6'h00; funct = 6'h25; // rtype OR, regdst, regwrite, aluop=11, alucontrol=1(or)
        #40;
        
        #10 opcode = 6'h00; funct = 6'h2A; // rtype SLT, regdst, regwrite, aluop=11, alucontrol=7(slt)
        #40;

        #10 opcode = 6'h23; // LW, memtoreg, alusrc, regwrite, aluop=00, alucontrol=2(add)
        #40;

        #10 opcode = 6'h2B; // SW, memwrite, alusrc, aluop=00, alucontrol=2(add)
        #40;

        #10 opcode = 6'h04; // BEQ, branch, aluop=01, alucontrol=6(sub)
        #40;

        #10 opcode = 6'h08; // ADDI, alusrc, regwrite, aluop=00, alucontrol=2(add)
        #40;

        #10 opcode = 6'h02; // J, jump, aluop=00, alucontrol=2(add)
        #40;
    end

endmodule
