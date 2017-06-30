`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2017 23:41:20
// Design Name: 
// Module Name: t_regfile
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


module t_regfile;

    // Inputs
    reg clk, we;
    reg [4:0] a1;
    reg [4:0] a2;
    reg [4:0] a3;
    reg [31:0] wd3;

    // Outputs
    wire [31:0] rd1;
    wire [31:0] rd2;

    // Instantiate the Unit Under Test (UUT)
    regfile uut (
        .clk( clk ),
        .WE3( we ),
        .A1( a1 ),
        .A2( a2 ),
        .A3( a3 ),
        .WD3( wd3 ),
        .RD1( rd1 ),
        .RD2( rd2 )
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
        a1 = 0;
        a2 = 0;
        a3 = 0;
        wd3 = 0;

        // Wait 100ns for global resets to finish
        #100;

        // Stimulus here
        #10 wd3 = 32'h00000001; a3 = 5'b00001; we = 1;
        #10 we = 0;
        #40 a1 = 5'b00001; a2 = 5'b00001;

        #40 we = 1; a3 = 5'b00010; wd3 = 32'h00000002;
        #10 we = 0;
        #40 a1 = 5'b00001; a2 = 5'b00010;

        #40 we = 1; a3 = 5'b00011; wd3 = 32'h00000003;
        #10 we = 0;
        #40 a1 = 5'b00010; a2 = 5'b00011;
    end

endmodule
