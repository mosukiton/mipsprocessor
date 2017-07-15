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
// Additional Comments: Initially, the Jump/Branch/+4 decision was done by cascaded
// 2:1 muxs. This was causing a problem as the Jump address was arriving to PCPrime
// (wire) at the same posedge clk cycle that created it. Thus the jump occured in
// the current clock cycle and not in the next clock cycle. The Branch address was
// working as intended as the branch occured in the next cycle. The reason for this
// was that the Branch address had to go through 2 2:1 muxs, and the added
// propagation delay was enough to prevent the signal from reaching PCPrime at the
// same time as the current rising clk signal. PCJump only had to go through 1 mux
// and therefore the propagation delay wasn't enough.
//
// To fix this, I combined both control signals and created a 3:1 mux, (so all 3
// signals shared the same propagation delay) and stored the result into a new
// register (PCPrimeReg). This was to ensure that the next PC address and the
// current PC address remain separated.
//
// Added signals for the registers so I could monitor them on the simulation.
//
// Added reset switch to PC and PCPrimeReg register in order to initialise a 0
// value in them during normal operation.
//////////////////////////////////////////////////////////////////////////////////


module instructionfetch(
    output [31:0] PCPlus4F,
    output [31:0] instruction,
    input [31:0] PCBranchF,
    input [27:0] WAinstrF,
    input clk, reset, JumpF, PCSrcF
    );

    wire [31:0] PCJump;
    wire [1:0] controlSignals;
    reg [31:0] PC, PCPrime;

    instrmem instrmem_if(
        .A( PC ),
        .RD( instruction )
    );

    assign controlSignals = {JumpF, PCSrcF};

    always @ (controlSignals or posedge reset or posedge clk) begin
        if(reset) begin
            PC <= 0;
            PCPrime <= 0;
        end else begin
            case (controlSignals)
                2'b00: PCPrime <= PCPlus4F;
                2'b01: PCPrime <= PCBranchF;
                2'b10: PCPrime <= PCJump;
                default: PCPrime <= 0;
            endcase
            PC <= PCPrime;
        end
    end

    assign PCJump = {PCPlus4F[31:28], WAinstrF};

    assign PCPlus4F = PCPrime + 32'h4;

    //always @ (posedge clk or posedge reset) begin
        //if(reset) begin
            //PC <= 0;
        //end else begin
            //PC <= PCPrime;
        //end
    //end

    initial begin
        PC = 32'h00000000;
        PCPrime = 32'h00000000;
        $display(PC);
        $display(PCPrime);
    end

endmodule
