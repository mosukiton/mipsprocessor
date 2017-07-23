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
        //#100;
        forever begin
            #10 clk = 1;
            #10 clk = 0;
        end
    end

    // Stimulus here
    initial begin
        $display(t_scp.uut.ID.jumpaddr);
        $display(t_scp.uut.ID.WAinstrD);
        $display(t_scp.uut.IF.WAinstrF);
        $display(t_scp.uut.IF.PCPrime);
        $display(t_scp.uut.IF.PC);
        $display(t_scp.uut.IF.PCJump);

        reset = 0;
        #30 reset = 1;
        #20 reset = 0;
        //#560 reset = 1;

    end

endmodule
