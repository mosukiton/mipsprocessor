`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2017 13:29:14
// Design Name: 
// Module Name: t_mem
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


module t_mem;

    // Inputs
    reg [31:0] writedata, aluresultin, pcbranch1;
    reg [4:0] writereg1;
    reg branch, memwrite, memtoreg1, regwrite1, zerowire, clk;

    // Outputs
    wire [31:0] readdata, aluresultout, pcbranch2;
    wire [4:0] writereg2;
    wire regwrite2, memtoreg2, pcsrc;

    // Instantiate the Unit Under Test
    memoryaccess uut (
        .ReadDataM( readdata ), .ALUResultOut( aluresultout ), .PCBranchM2( pcbranch2 ),
        .WriteRegM2( writereg2 ), 
        .RegWriteM2( regwrite2 ), .MemToRegM2( memtoreg2 ), .PCSrcM( pcsrc ),
        .WriteDataM( writedata ), .ALUResultIn( aluresultin ), .PCBranchM1( pcbranch1 ),
        .WriteRegM1( writereg1 ),
        .BranchM( branch ), .MemWriteM( memwrite ), .MemToRegM1( memtoreg1 ),
        .RegWriteM1( regwrite1 ),
        .ZerowireM( zerowire ), .clk( clk )
    );

    initial begin
        
        // Initialise inputs
        writedata = 0; aluresultin = 0; pcbranch1 = 0;
        writereg1 = 0;
        branch = 0; memwrite = 0; memtoreg1 = 0; regwrite1 = 0; zerowire = 0; clk = 0;

    end

endmodule
