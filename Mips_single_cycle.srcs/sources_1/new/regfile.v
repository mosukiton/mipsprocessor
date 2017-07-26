`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2017 17:24:09
// Design Name: 
// Module Name: regfile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: The only possible issue with this is that the write enable
// signal will not be alligned with a positive edge of the clock. So in the
// t_regfile module, I had to make the lifetime of the WE3 signal to be twice the
// clock to always avoid this error. In a single cycle processor, I might have to
// lower the clock rate or add " or negedge clk" to the always block sensitivity
// list. In a pipelined processor, this won't be a problem whatsover.
//
// One thing I'm not sure about, do I initialise all the registers at synthesis?
//
// $0 = $zero, Always 0 (non writable)
// $1 = $at, Reserved for Assembler
// $2, $3 = $v0, $v1, Return registers
// $4, ..., $7 = $a0, ..., $a3, 4 arguments to functions
// $8, ..., $15 = $t0, ..., $t7, Temporary registers
// $16, ..., $23 = $s0, ..., $s7, Saved Registers
// $24, $25 = $t8, $t9, Temporary Registers
// $26, $27 = $k0, $k1, Reserved for Kernel (OS)
// $28 = $gp, Global Pointer
// $29 = $sp, Stack Pointers
// $30 = $fp, Frame Pointer
// $31 = $ra, Return Address
//////////////////////////////////////////////////////////////////////////////////


module regfile(
    output [31:0] RD1, RD2,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    input WE3, clk
    );

    reg [31:0] rf [0:31];
    initial rf[0] = 32'h00000000;

    //always @ (posedge clk)                    // Uncomment for piplelined
    //if (WE3 & (A3 != 5'b00000)) begin
            //rf[A3] <= WD3;
        //end


    always @ *                                  // Uncomment for single-cycle
    if (WE3 & (A3 != 5'b00000)) begin
            rf[A3] <= WD3;
        end

    assign RD1 = (A1 != 0) ? rf[A1] : 0;
    assign RD2 = (A2 != 0) ? rf[A2] : 0;

endmodule
