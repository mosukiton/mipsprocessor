`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2017 10:30:18
// Design Name: 
// Module Name: execute
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: I'll design this hardware while imagining that it is for 
// a pipelined processor. To make it single-cycle, I'll just instantiate each
// module without a register and use continuous assignment to connect the inputs
// with the outputs of the previous segment. This will make it easier to adapt
// code.
//////////////////////////////////////////////////////////////////////////////////


module execute(
    output [31:0] ALUResult, PCBranchE, WriteDataE,
    output [4:0] WriteRegE,
    output RegWriteE2, MemToRegE2, MemWriteE2, BranchE2, ZeroE,
    input [31:0] PCPlus4E, srcA, RegRead2, SignImmE,
    input [4:0] rt, rd,
    input [2:0] ALUControlE,
    input ALUSrcE, RegDstE, RegWriteE1, MemToRegE1, MemWriteE1, BranchE1
    );

    wire [31:0] srcB, WASignImmE, PCBranchE;
    
    alu alu_ex(
        .ALUResult( ALUResult ),
        .ZeroE( Zero ),
        .srcA( A ),
        .srcB( B ),
        .ALUControlE( control )
    );

    // RegDst mux and ALUSrc mux
    assign WriteRegE = RegDstE ? rd: rt;
    assign srcB = ALUSrcE ? SignImmE : RegRead2;

    // PCBranch adder
    assign WASignImmE = SignImmE << 2;
    assign PCBranchE = PCPlus4E + WASignImmE;

    assign WriteDataE = RegRead2;

    // Send signals to the next block
    assign RegWriteE2 = RegWriteE1;
    assign MemToRegE2 = MemToRegE1;
    assign MemWriteE2 = MemWriteE1;
    assign BranchE2 = BranchE1;

endmodule
