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

        //Wait 100 ns for global resets to finish
        //#100;

        // Stimulus here
        #100 a = 32'h00000000;
        #100 a = 32'h00000001;
        #100 a = 32'h00000002;
        #100 a = 32'h00000003;
        #100 a = 32'h00000004;
        #100 a = 32'h00000005;
        #100 a = 32'h00000006;
        #100 a = 32'h00000007;
        #100 a = 32'h0000000A;

    end

endmodule
