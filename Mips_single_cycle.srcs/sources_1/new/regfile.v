`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2017 17:24:09
// Design Name: 
// Module Name: regfile
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


module regfile(
    output [31:0] RD1, RD2,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    input WE3, clk
    );

    reg [31:0] rf [31:0];

    always @ (posedge clk)
        if (WE3)
            rf[A3] <= WD3;

    assign RD1 = (A1 != 0) ? rf[A1] : 0;
    assign RD2 = (A2 != 0) ? rf[A2] : 0;

endmodule
