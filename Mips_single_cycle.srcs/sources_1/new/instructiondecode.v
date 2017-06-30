`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2017 01:25:16
// Design Name: 
// Module Name: instructiondecode
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


module instructiondecode(
    output [31:0] read1, read2, immediateSE, PCPlus4D2,
    output [27:0] WAinstrD,
    output [4:0] rt, rd,
    output [2:0] ALUControlD,
    output RegWriteD, MemToRegD, MemWriteD, BranchD, ALUSrcD, RegDstD, JumpD,
    input [31:0] PCPlus4D1, instruction, ResultW,
    input [4:0] WriteRegW,
    input RegWriteW, clk
    );

    wire [25:0] jumpaddr;
    wire [15:0] imm;
    wire [5:0] opcode, funct;
    wire [4:0] rs;

    // Instruction deconstruction
    assign opcode = instruction[31:26];
    assign rs = instruction[25:21];
    assign jumpaddr = instruction[25:0];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign imm = instruction[15:0];
    assign funct = instruction[5:0];

    ctrlunit ctrlunit_id(
        .opcode( OPCode ),
        .funct( Funct ),
        .MemToRegD( MemToReg ),
        .MemWriteD( MemWrite ),
        .BranchD( Branch ),
        .ALUSrcD( ALUSrc ),
        .RegDstD( RegDst ),
        .RegWriteD( RegWrite ),
        .JumpD( Jump ),
        .ALUControlD( ALUControl )
    );
    regfile regfile_id(
        .read1( RD1 ),
        .read2( RD2 ),
        .rs( A1 ),
        .rt( A2 ),
        .WriteRegW( A3 ),
        .ResultW( WD3 ),
        .RegWriteW( WE3 ),
        .clk( clk )
    );

    // word align the jump instruction
    assign WAinstrD = jumpaddr << 2;

    // Send PCPlus4 to the next section by not interacting with it here. It will be pipelined in the pipeline processor.
    assign PCPlus4D2 = PCPlus4D1;

    // Sign-extend the immediate
    assign immediateSE = {{16{imm[15]}}, {imm[15:0]}};

endmodule
