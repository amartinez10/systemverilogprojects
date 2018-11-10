# systemverilogprojects
SystemVerilog projects I have done in the past few months:

Bitcoin Hash - 
Final project was based on how fast can our design evaluate “nonces” (equivalent to how fast you can mine a Bitcoin). i.e.,
final project grade based on performance only compared to other teams designs.
Every “msg” will produce different 256-bit hash. Changing “nounce” will change “msg” and produce different 256-bit hash.
Bitcoin by design makes “target” increasingly difficult after certain number of bitcoins have been mined.



9-Bit CPU -
Processor with 9-bit instructions (machine code) and optimized for three simple programs, described below. My team and I designed the instruction set and instruction formats and code three programs to run on the instruction set. Given the tight limit on instruction bits, special consideration was made to target program needs.

 • Product --Write a program that finds the product of three unsigned numbers, ie, A * B * C. The operands are found in memory locations 1 (A), 2 (B), and 3 (C).  The result will be written into locations 4 (high bits) and 5 (low bits). There may be overflow, in which case you only store the low 16 bits.  Your ISA will not have a “multiply” operation. 

 • String match -- Write a program that finds the number of entries in an array which contain a 4-bit string. For example, if the 4-bit string is 0101, then 11010110 and 01010101 would both count (the latter would count once, even though the string occurs 3 times), while 00111011 would not. The array starts at position 32 and is 64 bytes long. The string you search for will be in the lower 4 bits of memory address 6. The result shall be written in location 7.

 • Closest pair -- Write a program to find the least distance among all pairs of values in an array of 20 bytes. Assume all values are signed 8-bit integers. The array of integers starts at location 128. Write the minimum distance in location 127.

