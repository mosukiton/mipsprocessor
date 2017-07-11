`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2017 15:34:25
// Design Name: 
// Module Name: t_if
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


module t_if;

    // Inputs
    reg [31:0] pcBranch;
    reg [27:0] waInstruction;
    reg clk, jump, pcSrc;

    // Outputs
    wire [31:0] pcPlus4, instruction;
    
    // Initialise the Unit Under Test (UUT)
    instructionfetch uut(
        .PCPlus4F( pcPlus4 ),
        .instruction( instruction ),
        .PCBranchF( pcBranch ),
        .WAinstrF( waInstruction ),
        .clk( clk ),
        .JumpF( jump ),
        .PCSrcF( pcSrc )
    );

    // Initialise the clock
    initial begin
        clk = 0;
        #20;
        forever begin
            #10 clk = 1;
            #10 clk = 0;
        end
    end

    initial begin
        // Initialise Inputs
        pcBranch = 0;
        waInstruction = 0;
        jump = 0;
        pcSrc = 0;

        #100; // Allow normal PC implementation to occur

        // State 1: Branch Instruction
        #10 jump = 0; pcSrc = 1; pcBranch = 32'h00000004;
        #20 jump = 0; pcSrc = 0; pcBranch = 32'h00000000;

        #100; // Wait 100 until next state is tested

        // State 2: Jump Instruction
        #20 jump = 1; pcSrc = 0; waInstruction = 27'h00002c;
        #20 jump = 0; pcSrc = 0; waInstruction = 27'h000000;

    end

endmodule
