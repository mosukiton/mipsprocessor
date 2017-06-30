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

    wire [31:0] notB, mux_outB, aANDmuxB, aORmuxB, sumResult, sltResult, andResult, OrResult;

    assign notB = -B; // 2s complement
    assign mux_outB = (control[2] == 1) ? B : notB; // control[2] = 1, then mux_outB = B, if control[2] = 0, then mux_outB = -B

    assign andResult = A & mux_outB;
    assign OrResult = A | mux_outB;

    assign sumResult = A + mux_outB; // 2s compliment

    assign sltResult = {{31{1'b0}}, {sumResult[31]}}; // zero extend the MSB

    always @ (control or ALUResult) begin
        case(control[1:0])
            2'b00: ALUResult <= andResult;
            2'b01: ALUResult <= OrResult;
            2'b10: ALUResult <= sumResult;
            2'b11: ALUResult <= sltResult;
        endcase

        if (ALUResult == 32'b0) begin
            Zero <= 1;
        end
    end

endmodule
