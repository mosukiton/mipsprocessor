`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2017 23:51:28
// Design Name: 
// Module Name: t_id
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: The purpose of this test is to check if the decoding of
// the instruction works. I wrote 4 blocks to test R-Type, I-Type and J-type
// instructions. The order of these tests are not trivial, I first tested lw
// (I-type) to store 2 values into temporary registers in the register file and
// then I used an add instruction (R-type) and stored the result into a $t2. The
// simulation result of the register file showed $t0 and $t1 had the value 32'h1
// and $t2 had the value 32'h2.
// I then tested the 2 PC related instructions, BEQ (I) and J (J-Type) and made
// sure that the Immediate from the instruction was sign extended for both cases
// and that the immediate was word aligned for the Jump instruction.
// I didn't find it necessary to test the full range of the control unit or the
// register file as this was done previously. Those modules are unchanged and were
// instantaited into the ID module as is.
// 
//////////////////////////////////////////////////////////////////////////////////


module t_id;

    // Inputs
    reg [31:0] pcplus41, instruction, resultw;
    reg [4:0] writereg;
    reg regwritew, clk;

    // Outputs
    wire [31:0] read1, read2, immse, pcplus42;
    wire [27:0] wainstr;
    wire [4:0] rt, rd;
    wire [2:0] alucontrol;
    wire regwrited, memtoreg, memwrite, branch, alusrc, regdst, jump;

    instructiondecode uut(
        .clk( clk ),
        .read1( read1 ),
        .read2( read2 ),
        .immediateSE( immse ),
        .PCPlus4D2( pcplus42 ),
        .WAinstrD( wainstr ),
        .rt( rt ),
        .rd( rd ),
        .ALUControlD( alucontrol ),
        .RegWriteD( regwrited ),
        .MemToRegD( memtoreg ),
        .MemWriteD( memwrite ),
        .BranchD( branch ),
        .ALUSrcD( alusrc ),
        .RegDstD( regdst ),
        .JumpD( jump ),
        .PCPlus4D1( pcplus41),
        .instruction( instruction ),
        .ResultW( resultw ),
        .WriteRegW( writereg ),
        .RegWriteW( regwritew )
    );

    initial begin
        clk = 0;
        forever begin
            #10 clk = 1;
            #10 clk = 0;
        end
    end

    initial begin

        // Initialise the inputs
        pcplus41 = 0; instruction = 0; resultw = 0;
        writereg = 0; regwritew = 0;

        // Wait 100ns for global resets to finish
        #100;

        // Write some test machine code instructions to test an R-type, I-type and J-type instruction and see if the decode works as intended
        // I-Type test
        // lw rt, offset(rs)    -   op rs rt imm
        #10 instruction = 32'b10001100000010000000000000000001; // store (1+0) into register 8($t0)
        writereg = 5'h08; resultw = 32'h00000001; regwritew = 1; // generate my own aluresult, as if the module was connected to the whole circuit
        // expected outputs: read1 = 0; immse = 32'b1; rt = 8; rd = 0; regwrited = 1; memtoreg = 1; alusrc = 1; alucontrol = 010;
        // reset
        #20 instruction = 0;
        writereg = 5'h00; resultw = 32'h00000000; regwritew = 0;

        // lw rt, offset(rs)    -   op rs rt imm
        #20 instruction = 32'b10001100000010010000000000000001; // store (1+0) into register 9($t1)
        writereg = 5'h09; resultw = 32'h00000001; regwritew = 1; // generate my own aluresult, as if the module was connected to the whole circuit
        // expected outputs: read1 = 0; immse = 32'b1; rt = 8; rd = 0; regwrited = 1; memtoreg = 1; alusrc = 1; alucontrol = 010; all else 0 or don't care;
        // reset
        #20 instruction = 0;
        writereg = 5'b00; resultw = 32'h00000000; regwritew = 0;

        #100; // wait

        // R-Type test
        // and rd, rs, rt   -   op rs rt rd shamt funct
        instruction = 32'b00000001000010010101000000100000; // $t2 = $t0 + $t1
        writereg = 5'h0A; resultw = 32'h00000002; regwritew = 1; // generate my own aluresult, as if the module was connected to the whole circuit
        // expected outputs: read1 = 32'h1; read2 = 32'h1; rt = 01001; rd = 01010; regwrited = 1; memtoreg = 1; regdst = 1; alucontrol = 010;
        //reset
        #20 instruction = 0; // $t2 = $t0 and $t1
        writereg = 5'h0; resultw = 32'h00000000; regwritew = 0; // generate my own aluresult, as if the module was connected to the whole circuit

        #100; // wait

        // BEQ (branch) Test
        instruction = 32'b00010001001010000000000000000001; // if $t0 == $t1, nPC = immse + pc+4
        // expected outputs: read1 = 32'h1; read2 = 32'h1; immse = 32'b4; branch = 1; alucontrol = 110(sub);
        // reset
        #20 instruction = 0;

        #100; // wait

        // J-Type (jump) Test
        instruction = 32'b00001000000000000000000000000001; // Jump to instruction in address 32'h00000004;
        // expected outputs: WAInstr = 32'h00000004; jump = 1;
        #20 instruction = 0;

    end

endmodule
