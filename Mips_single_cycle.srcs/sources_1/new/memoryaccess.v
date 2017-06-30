`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2017 11:21:41
// Design Name: 
// Module Name: memoryaccess
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
//
// Instantialising ALUResultsIn with A and also using CA to link ALUResultsOut
// and ALUResultsIn might not. I will have to edit if the implementation doesn't 
// work and/or the simulation doesn't work.
//////////////////////////////////////////////////////////////////////////////////


module memoryaccess(
    output [31:0] ReadDataM, ALUResultOut, PCBrancM2,
    output [4:0] WriteRegM2, 
    output RegWriteM2, MemToRegM2, PCSrcM,
    input [31:0] WriteDataM, ALUResultIn, PCBranchM1,
    input [4:0] WriteRegM1,
    input BranchM, MemWriteM, MemToRegM1, RegWriteM1, ZeroM, clk
    );

    dmem dmem_mem(
        .ReadDataM( RD ),
        .ALUResultsIn( A ),
        .WriteDataM( WD ),
        .MemWriteM( WE ),
        .clk( clk )
    );

    assign PCSrcM = BranchM & ZeroM;

    //Send signals to next section
    assign ALUResultsOut = ALUResultsIn;
    assign WriteRegM2 = WriteRegM1;
    assign PCBranchM2 = PCBranchM1;
    assign MemToRegM2 = MemToRegM1;
    assign RegWriteM2 = RegWriteM1;

endmodule
