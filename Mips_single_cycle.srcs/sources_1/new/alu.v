`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2017 17:24:09
// Design Name: 
// Module Name: alu
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


module alu(
    output reg [31:0] ALUResult,
    output reg Zero,
    input [31:0] A,
    input [31:0] B,
    input [2:0] control
);
    wire [31:0] notB, muxBout, S, andResult, orResult, SLT;

    // Addition overflow bit
    wire Cout;

    //1s compliment of B, we need to add 1 to make it 2s compliment.
    assign notB = ~B;

    // control[2] = 0, then muxBout = B, if control[2] = 1, then muxBout = notB
    assign muxBout = (control[2]) ? notB : B;

    assign {Cout, S} = muxBout + A + control[2]; // if control[2] = 1, then we need to add it to the sum to make sure we are adding 2s compliment numbers together

    assign andResult = A & muxBout;
    assign orResult = A | muxBout;
    assign SLT = {{31{1'b0}}, {S[31]}}; //If a > b, then z = 1. Else z = 0

    always @ (control[1:0] or andResult or orResult or S or SLT or ALUResult) begin
        case(control[1:0])
            2'b00: ALUResult = andResult;
            2'b01: ALUResult = orResult;
            2'b10: ALUResult = S;
            2'b11: ALUResult = SLT;
        endcase

        if (ALUResult == 32'h00000000) begin
            Zero <= 1;
        end else begin
            Zero <= 0;
        end
    end

endmodule
