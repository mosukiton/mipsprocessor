`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2017 17:44:01
// Design Name: 
// Module Name: t_WB
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


module t_WB;

    // Inputs
    reg [31:0] readdata, aluresult;
    reg [4:0] writereg1;
    reg memtoreg, regwrite1;

    // Outputs
    wire [31:0] result;
    wire [4:0] writereg2;
    wire regwrite2;

    // Intantiate the Unit Under Test
    writeback uut(
        .ResultW( result ),
        .WriteRegW2( writereg2 ),
        .RegWriteW2( regwrite2 ),
        .ReadDataW( readdata ),
        .ALUResultW( aluresult ),
        .WriteRegW1( writereg1 ),
        .MemToRegW( memtoreg ),
        .RegWriteW1( regwrite1 )
    );

    initial begin

        // Initialse inputs
        readdata = 0; aluresult = 0; writereg1 = 0; memtoreg = 0; regwrite1 = 0;

        #100; // Wait 100ns for global resets

        // Test MemToReg
        aluresult = 32'hAAAAAAAA; readdata = 32'hFFFFFFFF; writereg1 = 5'b01000; memtoreg = 0; // expected output: result = 32'hAAAAAAAA;
        #20 writereg1 = 5'b01001; memtoreg = 1; // expected output: result = 32'hFFFFFFFF;
        #20 aluresult = 32'h00000000; readdata = 32'h00000000; writereg1 = 5'b00000; memtoreg = 0; // reset

        // Test follow-through signals
        #20 regwrite1 = 1;
        #20 regwrite1 = 0; // reset

    end
endmodule
