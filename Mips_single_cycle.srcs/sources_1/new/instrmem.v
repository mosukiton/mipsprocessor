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

    reg [31:0] mem [0:127];

    initial begin
        $readmemh("memfile.dat", mem); // initialise ROM
    end

    assign RD = mem[A];

endmodule
