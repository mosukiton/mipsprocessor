`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2017 17:24:09
// Design Name: 
// Module Name: dmem
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


module dmem(
    output  [31:0] RD,
    input   [31:0] A, WD,
    input   WE, clk
    );

    reg [31:0] RAM [255:0];

    assign RD = RAM[A];

    always @ (posedge clk)
        if (WE)
            RAM[A] <= WD;
            // when a 32 bit number is sent to the address field, this is the calculated
            // address from the ALU. Meaning that the instruction is for "lw" or "sw".
            // Another indicator for this is when the signal "MemWrite" is 1.
            // All other times, "MemWrite" is 0, and the ALUResult that is sent to A
            // is ignored.

endmodule
