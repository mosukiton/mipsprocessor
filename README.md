# mipsprocessor
Mips 32bit Processor, similar to MIPS I architecture, in single cycle and pipelined

Current progress:
<ul>
    <li>All base modules are written and tested:
        <ul>
            <li>ALU</li>
            <li>Control Unit</li>
            <li>Register File</li>
            <li>Instruction Memory</li>
            <li>Data Memory</li>
        </ul>
   </li>
   <li>IF, ID, EX, MEM, WB are written</li>
   <li>Single Cyle Processor Module is written</li>
</ul>

To Do List:
<ol>
<li>Test IF, ID, EX, MEM, WB modules</li>
<li>Test Single Cycle Processor</li>
<li>Write Radix-4 Booth Encoded Multiplication Module<ol>
    <li>Create HI/LO registers in RF</li></ol></li>
<li>Write L/R Arithmetic/Logical shift function and module</li>
<li>Research and write a module for division</li>
<li>Create new Control Signals where necessary and adjust control unit code</li>
<li>Test New modules:<ol>
    <li>Individually</li>
    <li>As part of their greater modules (ID, EX and WB)</li>
    <li>As part of the Single Cycle Processor</li></ol></li>
<li>Pipeline the IF, ID, EX, MEM and WB modules</li>
<li>Test the pipelined modules as a complete Pipelined Processor</li>
</ol>
