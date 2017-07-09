`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2017 23:55:46
// Design Name: 
// Module Name: instructionfetch
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


module instructionfetch(
    output [31:0] PCPlus4F, instruction,
    input [31:0] PCBranchF,
    input [27:0] WAinstrF,
    input clk, JumpF, PCSrcF
    );

    wire [31:0] JumpMux, PCPrime, PCJump, address;
    reg [31:0] PC;

    instrmem instrmem_if(
        .A( address ),
        .RD( instruction )
    );

    // y = enable ? enable=1 : enable=0
    assign JumpMux = PCSrcF ? PCBranchF : PCPlus4F;
    assign PCPrime = JumpF ? PCJump : JumpMux;

    assign PCJump = {{PCPlus4F[31:28]}, {WAinstrF}};

    assign PCPlus4F = PC + 32'h4;

    always @ (posedge clk) begin
        PC <= PCPrime;
    end

    

endmodule
