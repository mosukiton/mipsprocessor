# mipsprocessor
Mips 32bit Processor, similar to MIPS I architecture, in single cycle and pipelined

Current progress:
All base modules are written, tested and verified:
ALU,
Control Unit,
Register File,
Instruction Memory,
Data Memory,

To Do List:
<ol>
<li>Test IF, ID, EX, MEM, WB modules</li>
<li>Test Single Cycle Processor</li>
<li>Write Radix-4 Booth Encoded Multiplication Module</li>
    -  Create HI/LO registers in RF

<li>Write L/R Arithmetic/Logical shift function and module</li>

<li>Create new Control Signals where necessary and adjust control unit code</li>

<li>Test New modules:</li>
    -   Individually</li>
    -   As part of their greater modules (ID, EX and WB)</li>
    -   As part of the Single Cycle Processory</li>

<li>Pipeline the IF, ID, EX, MEM and WB modules</li>


<li>Test the pipelined modules as a complete Pipelined Processor</li>
</ol>
