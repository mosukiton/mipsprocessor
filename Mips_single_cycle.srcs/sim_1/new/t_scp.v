`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2017 21:09:25
// Design Name: 
// Module Name: t_scp
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


module t_scp;

    // Inputs
    reg clk, reset;

    // Initialise the Unit Under Test
    singlecycleprocessor uut (
        .clk( clk ),
        .reset( reset)
    );

    // Initialise the clock
    initial begin
        clk = 0;
        #100;
        forever begin
            #20 clk = 1;
            #20 clk = 0;
        end
    end

    // Stimulus here
    initial begin

        reset = 1;
        #40 reset = 1;
        #40 reset = 0;

    end

endmodule
