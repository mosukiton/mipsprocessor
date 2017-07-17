`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2017 17:24:09
// Design Name: 
// Module Name: instrmem
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
module instrmem(
    output  [31:0] RD,
    input   [31:0] A
    );

    reg [7:0] mem [0:127];

    initial begin
        $readmemh("testinstructions.dat", mem); // initialise ROM
    end

    //RD = a concantenation of 4 bytes in adjacent addresses
    assign RD = {mem[A], mem[A+1], mem[A+2], mem[A+3]};

endmodule
