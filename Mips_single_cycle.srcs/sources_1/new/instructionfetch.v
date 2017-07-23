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
            PCPrime <= 0;
        end else begin
            case (controlSignals)
                2'b00: PCPrime <= PCPlus4F;
                2'b01: PCPrime <= PCBranchF;
                2'b10: PCPrime <= PCJump;
                default: PCPrime <= 0;
            endcase
        end
    end

    always @ (posedge clk or posedge reset) begin   // I have no idea why, but PC required it's own always block, separate to PCPrime. The problem was that the Jump instruction address
        if(reset) begin                             // was skipping PCPrime and being saved straight to PC. When I separated the 2 always blocks, 1 for each register, it appeared to fix
            PC <= 0;                                // the problem. Using 'or' or ',' in the sensitivity list made no difference, perhaps the conflict was the level sensitivity of
        end else begin                              // controlSignals that was causing the signal to go from PCJump -> PCPrime -> PC in 1 clock cycle. In the simulation, the PC register
            PC <= PCPrime;                          // was going from 0 -> 4 -> 0, and skipping the 3rd instruction (in the testjump.dat file) which was the jump file. But it was still
        end                                         // functionally jumping, just a clock cycle too early, and the jump instruction appeared to have never been sent. Perhaps, if I lower
    end                                             // the clock period, I will be able to see that the jump instruction does get sent and does not get overwritten by the instruction
                                                    // that it is jumping to. Although, I am confused because this means that there is something that I don't understand about 
                                                    // sensitivity lists and non-blocking assignments. I will be more careful in the future.

    assign PCJump = {PCPlus4F[31:28], WAinstrF};
    assign PCPlus4F = PCPrime + 32'h4;

    initial begin
        PC = 32'h00000000;
        PCPrime = 32'h00000000;
        $display(PC);
        $display(PCPrime);
    end

endmodule
