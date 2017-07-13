`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2017 13:29:14
// Design Name: 
// Module Name: t_mem
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


module t_mem;

    // Inputs
    reg [31:0] writedata, aluresultin, pcbranch1;
    reg [4:0] writereg1;
    reg branch, memwrite, memtoreg1, regwrite1, zerowire, clk;

    // Outputs
    wire [31:0] readdata, aluresultout, pcbranch2;
    wire [4:0] writereg2;
    wire regwrite2, memtoreg2, pcsrc;

    // Instantiate the Unit Under Test
    memoryaccess uut (
        .ReadDataM( readdata ), .ALUResultOut( aluresultout ), .PCBranchM2( pcbranch2 ),
        .WriteRegM2( writereg2 ), 
        .RegWriteM2( regwrite2 ), .MemToRegM2( memtoreg2 ), .PCSrcM( pcsrc ),
        .WriteDataM( writedata ), .ALUResultIn( aluresultin ), .PCBranchM1( pcbranch1 ),
        .WriteRegM1( writereg1 ),
        .BranchM( branch ), .MemWriteM( memwrite ), .MemToRegM1( memtoreg1 ),
        .RegWriteM1( regwrite1 ),
        .ZerowireM( zerowire ), .clk( clk )
    );

    // Intialise the clock
    initial begin
        clk = 0;
        forever begin
            #10 clk = 1;
            #10 clk = 0;
        end
    end

    initial begin
        
        // Initialise inputs
        writedata = 0; aluresultin = 0; pcbranch1 = 0;
        writereg1 = 0;
        branch = 0; memwrite = 0; memtoreg1 = 0; regwrite1 = 0; zerowire = 0; clk = 0;

        // Wait 100 ns for global resets
        #100;

        // Test zerowire + branch and PCBranch
        #10 zerowire = 0; branch = 0; pcbranch1 = 32'h00000008; //expected output pcsrc = 0; pcbranch2 = 32'h00000008;
        #20 zerowire = 0; branch = 1; pcbranch1 = 32'h00000008; //expected output pcsrc = 0; pcbranch2 = 32'h00000008;
        #20 zerowire = 1; branch = 0; pcbranch1 = 32'h00000008; //expected output pcsrc = 0; pcbranch2 = 32'h00000008;
        #20 zerowire = 1; branch = 1; pcbranch1 = 32'h00000008; //expected output pcsrc = 1; pcbranch2 = 32'h00000008;

        // Test ALUResultIn for when MemWrite = 0 and MemWrite = 1;
        #20 aluresultin = 32'h00000001; memwrite = 1; writedata = 32'hFFFFFFFF;
        // expected output aluresultout = 32'h00000001; dmem stores value FFFFFFFF into address 32'h00000001
        #20 aluresultin = 32'h00000001; memwrite = 0; writedata = 32'hAAAAAAAA; // expected output aluresultout = 32'h00000001; readdata = 32'hFFFFFFFF;

        // Test read function of dmem

        // Test follow-through signals
        #20 writereg1 = 5'b01000; memtoreg1 = 1; regwrite1 = 1; // expected output writereg2 = 5'b01000; memtoreg2 = 1; regwrite2 = 1;
        #20 writereg1 = 5'b01001; memtoreg1 = 0; regwrite1 = 0; // expected output writereg2 = 5'b01001; memtoreg2 = 0; regwrite2 = 0;

    end

endmodule
