# mipsprocessor
Mips 32bit Processor, similar to MIPS I architecture, in single cycle and pipelined

Current progress:
All base modules are written, tested and verified:
    *   ALU
    *   Control Unit
    *   Register File
    *   Instruction Memory
    *   Data Memory

To Do List:
    *   Test IF, ID, EX, MEM, WB modules
    *   Test Single Cycle Processor
    *   Write Radix-4 Booth Encoded Multiplication Module
            -  Create HI/LO registers in RF
    *   Write L/R Arithmetic/Logical shift function and module
    *   Create new Control Signals where necessary and adjust control unit code
    *   Test New modules:
            -   Individually
            -   As part of their greater modules (ID, EX and WB)
            -   As part of the Single Cycle Processory
    *   Pipeline the IF, ID, EX, MEM and WB modules
    *   Test the pipelined modules as a complete Pipelined Processor
