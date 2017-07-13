`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2017 01:34:06
// Design Name: 
// Module Name: t_dmem
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


module t_dmem;

    // Inputs
    reg [31:0] a, wd;
    reg we, clk;

    // Outputs
    wire [31:0] rd;

    // Instantiate the Unit Under Test
    dmem uut (
        .RD( rd ),
        .A( a ),
        .WD( wd ),
        .WE( we ),
        .clk( clk )
    );

    // Initialise the clock
    initial begin
        clk = 0;
        forever begin
            #10 clk = 1;
            #10 clk = 0;
        end
    end

    initial begin
        // Initialise Inputs
        we = 0;
        a = 0;
        wd = 0;

        // Wait 100 ns for global resets to finish
        #100;

        // Stimulus here
        #10 we = 1; wd = 32'hFFFFFFFF; a = 8'h00;
        #40 we = 0;

        #20 we = 1; wd = 32'hFFFFFFFF; a = 8'h01;
        #40 we = 0;

        #20 we = 1; wd = 32'hFFFFFFFF; a = 8'h02;
        #40 we = 0;

        #20 we = 1; wd = 32'hFFFFFFFF; a = 8'h03;
        #40 we = 0;

        // Test 32bit wide address input
        #20 we = 1; wd = 32'hFFFFFFFF; a = 32'h00000004;
        #40 we = 0;

    end

endmodule
