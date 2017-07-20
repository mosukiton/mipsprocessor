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
    reg clk, reset, jump, pcSrc;

    // Outputs
    wire [31:0] pcPlus4, instruction;
    
    // Initialise the Unit Under Test (UUT)
    instructionfetch uut(
        .PCPlus4F( pcPlus4 ),
        .instruction( instruction ),
        .PCBranchF( pcBranch ),
        .WAinstrF( waInstruction ),
        .clk( clk ),
        .reset( reset ),
        .JumpF( jump ),
        .PCSrcF( pcSrc )
    );

    // Initialise the clock
    initial begin
        clk = 0;
        forever begin
            #20 clk = 1;
            #20 clk = 0;
        end
    end

    initial begin
        // Initialise Inputs
        pcBranch = 0;
        waInstruction = 0;
        jump = 0;
        pcSrc = 0;
        reset = 0;

        reset = 1; // Reset program counter
        #40 reset = 0; // continue normal operation

        #260 // Allow normal PC operation to occur for 100 ns

        // State 2: Jump Instruction
        jump = 1; pcSrc = 0; waInstruction = 27'h000000;
        #40 jump = 0; pcSrc = 0; waInstruction = 27'h000000;

        // State 1: Branch Instruction
        #40 jump = 0; pcSrc = 1; pcBranch = 32'h0000001C;
        #40 jump = 0; pcSrc = 0; pcBranch = 32'h00000000;

        #100; // Wait 100 until next state is tested


    end

endmodule
