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
        .ALUSrc( ALUSrc ),
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
        #10 opcode = 6'b000000; funct = 6'b100000; // rtype ADD
        #40;

        #10 opcode = 6'b000000; funct = 6'b100010; // rtype SUB
        #40;

        #10 opcode = 6'b000000; funct = 6'b100100; // rtype AND
        #40;

        #10 opcode = 6'b000000; funct = 6'b100101; // rtype OR
        #40;
        
        #10 opcode = 6'b000000; funct = 6'b101010; // rtype SLT
        #40;

        #10 opcode = 6'b100011; // LW
        #40;

        #10 opcode = 6'b101011; // SW
        #40;

        #10 opcode = 6'b000100; // BEQ
        #40;

        #10 opcode = 6'b001000; // ADDI
        #40;

        #10 opcode = 6'b000010; // J
        #40;
    end

endmodule
