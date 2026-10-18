/*

ModC (Modern Cherry)

interpreted programming language based on C (and C-likes) and a former joke language i made

instruction set:

- set: [var] [value]                            sets var to value
- show: [output]                                shows output
- input: [var]                                  records input to var 
- loc: [name]                                   records location loc
- jump: [locname]                               jumps to location locname
- sum: [val1] [val2] etc                        sums all the valN's. usable as value
- sub: [val1] [val2] etc                        subtracts all the valN's. usable as value
- mul: [val1] [val2] etc                        multiplies all the valN's. usable as value
- div: [val1] [val2] etc                        divides all the valN's. usable as value
- mod: [val1] [val2] etc                        modulo's all the valN's. usable as value
- when [val1] [& < >] [val2] ([thing to do])          if val1 and val2 are the [equal 1<2 1>2], do the thing inside the parentheses
- nwhen [val1] [& < >] [val2] ([thing to do])         if val1 and val2 are not the [equal 1<2 1>2], do the thing inside the parentheses

variable types:
- $var                                          string
- #var                                          number
- @var                                          char

*/

