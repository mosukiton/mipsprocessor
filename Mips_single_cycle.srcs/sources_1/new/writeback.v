`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2017 11:38:04
// Design Name: 
// Module Name: writeback
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


module writeback(
    output [31:0] ResultW,
    output [4:0] WriteRegW2,
    output RegWriteW2,
    input [31:0] ReadDataW, ALUResultW,
    input [4:0] WriteRegW1,
    input MemToRegW, RegWriteW1
    );

    assign ResultW = MemToRegW ? ReadDataW : ALUResultW;

    // Send signals to other block
    assign WriteRegW2 = WriteRegW1;
    assign RegWriteW2 = RegWriteW1;

endmodule
