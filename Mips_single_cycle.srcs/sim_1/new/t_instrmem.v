`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2017 01:34:06
// Design Name: 
// Module Name: t_instrmem
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


module t_instrmem;

    // Inputs
    reg [31:0] a;
    
    // Outputs
    wire [31:0] rd;

    // Initialise the Unit Under Test
    instrmem uut (
        .A( a ),
        .RD( rd )
    );

    initial begin 
        // Initialse Inputs
        a = 0;

        // Wait 100 ns for global resets to finish
        #100;

        // Stimulus here
        #10 a = 32'h00000000;
        #10 a = 32'h00000004;
        #10 a = 32'h00000008;
        #10 a = 32'h0000000C;
        #10 a = 32'h00000010;
        #10 a = 32'h00000014;
        #10 a = 32'h00000018;
        #10 a = 32'h0000001C;

    end

endmodule
