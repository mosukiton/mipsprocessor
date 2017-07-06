`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2017 01:34:06
// Design Name: 
// Module Name: t_alu
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


module t_alu;

    //Inputs
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] alu_sel;

    // Outputs
    wire [31:0] z;

    // Instantiate the Unit Under Test (UUT)
    alu uut (
        .control( alu_sel ),
        .ALUResult( z ),
        .A( a ),
        .B( b )
    );

    initial begin
        // Initialise Inputs
        alu_sel = 0;
        a = 0;
        b = 0;

        // Wait 100 ns for global resets to finish
        #100;

        // Stimulus here

        #100 a = 32'h0000FFFF; b = 32'h000000FF; alu_sel = 3'b000; // z = 0000FFFF AND 000000FF = 000000FF
        #100 a = 32'hFFFF0000; b = 32'h0000FFFF; alu_sel = 3'b001; // z = FFFF0000 OR 0000FFFF = FFFFFFFF
        #100 a = 32'h00000001; b = 32'h00000001; alu_sel = 3'b010; // z = 1 + 1 = 00000002

        #100 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; alu_sel = 3'b100; // z = FFFFFFFF AND 00000000 = 00000000
        #100 a = 32'h0000FFFF; b = 32'h0000FFFF; alu_sel = 3'b101; // z = 0000FFFF OR FFFF0000 = FFFFFFFF
        #100 a = 32'h7FFFFFFF; b = 32'h0000000F; alu_sel = 3'b110; // z = 7FFFFFFF - 0000000F = 7FFFFFF0
        #100 a = 32'h00000000; b = 32'h00000001; alu_sel = 3'b111; // SLT, z = 00000000
        #100 a = 32'h00000001; b = 32'h00000000; alu_sel = 3'b111; // SLT, z = 00000001
    end

endmodule
