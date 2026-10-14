# neumannlang design doc thing

Neumannlang is a programming language inspired in the Von Neumann architecture (not the same tho). It frankly doesnt count as a programming language and isn't even turing complete but its an experiment i wanna make.

## instruction list:
```
0: end program (param of >0 means file is overwritten)
1: set address
2: add to second memory
3: substract to second memory
4: set second memory 
5: set ram[address] to second memory
6: set second memory to ram[param]
7: swap ram[address] and second memory
8: jump to address in second memory
9: jump param[address] steps if second memory is 0
A: print ram[param]
B: print second memory
C: stall param[address] eighths of a second
D: secmem = gates between secmem and ram[address]. see below
E: 
F: mode 0-2 (no load scr, normal, print every time)

the address advances when an instruction is finished, except when the instruction affects the ram.

(given sm 10010110 ri 01011010)
D0 = and            00010010
D1 = or             11011110
D2 = nand           11101101
D3 = nor            00100001
D4 = xor            11001100
D5 = xnor           00110011
D6 = not secmem     01101001
D7 = not ram[i]     10100101
```

might make an assembler. might not.