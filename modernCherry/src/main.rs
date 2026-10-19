/*

ModC (Modern Cherry)

interpreted programming language based on a former joke language i made

instruction set:

- set: [var] [value]                                    sets var to value
- show: [output]                                        shows output
- input: [var]                                          records input to var 
- loc: [name]                                           records location loc
- jump: [locname]                                       jumps to location locname
- sum: [val1] [val2] etc                                sums all the valN's. usable as value
- sub: [val1] [val2] etc                                subtracts all the valN's. usable as value
- mul: [val1] [val2] etc                                multiplies all the valN's. usable as value
- div: [val1] [val2] etc                                divides all the valN's. usable as value
- mod: [val1] [val2] etc                                modulo's all the valN's. usable as value
- when: [val1] [& < >] [val2] (
  [thing to do]
  )                                                     if val1 and val2 are the [equal 1<2 1>2], do the thing inside the parentheses
- nwhen: [val1] [& < >] [val2] (
  [thing to do]
  )                                                     if val1 and val2 are not the [equal 1<2 1>2], do the thing inside the parentheses
- !                                                     comment

variable types:
- $var                                                  string
- #var                                                  number
- @var                                                  bool

_ in plaintext converts to \n

only one instruction per line 

*/

use std::fs;


#[derive(Debug)]
struct Location{
    name:String,
    pos:i32,
}

struct IntVariable{
    name:String,
    value:i32,
}
struct StrVariable{
    name:String,
    value:String,
}
struct BoolVariable{
    name:String,
    value:bool,
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len()==2{

        let mut lines: Vec<&str> = vec![];
        let mut programcounter = 0;
        let mut opcodes:Vec<&str> = vec![];
        let mut operands:Vec<String> = vec![];
        let mut locs: Vec<Location> = vec![];
        let mut skip = false;
        let mut intvars: Vec<IntVariable>=vec![];
        let mut strvars: Vec<StrVariable>=vec![];
        let mut boolvars: Vec<BoolVariable>=vec![];
            
        let contents = fs::read_to_string(&args[1])
            .expect("Should have been able to read the file");

        let parts = contents.split("\n");
        let blines:Vec<&str> = parts.collect();
        for line in blines{
            lines.push(line.trim());
        }

        for line in &lines{
            let tmp = line.split(":");
            let tmpb:Vec<&str> = tmp.collect();
            opcodes.push(tmpb[0]); 
        }

        for line in &lines{
            let tmp = line.split(":");
            let tmpb:Vec<&str> = tmp.collect();
            if tmpb.len()<2{
                operands.push("".to_string()); 
            }else{
                let mut tmpc: String = "".to_string();
                for op in 1..tmpb.len(){
                    tmpc=tmpc.to_owned()+tmpb[op];
                    if op < tmpb.len()-1{
                        tmpc=tmpc.to_owned()+":";
                    }
                }
                operands.push(tmpc); 
            }
        }
        
        for op in 0..lines.len(){
            if opcodes[op] == "loc"{
                locs.push(
                    Location { name: operands[op].to_string(), pos: op as i32 }
                );
            }
        }

        //dbg!(locs);

        while programcounter<lines.len() {
            if skip{
                
            }else{
                match opcodes[programcounter] {
                    "show" => {
                        print!("{}",operands[programcounter].replace("_", "\n"));
                        programcounter+=1;
                    }
                    "jump" => {
                        let mut tmp: i32 = programcounter as i32+1;
                        for loc in &locs{
                            if loc.name==operands[programcounter]{
                                tmp = loc.pos;
                                break;
                            }
                        }
                        programcounter=tmp as usize;
                    }
                    "set" => {
                        let para = contents.split(" ");
                        let bpara:Vec<&str> = para.collect();
                        if operands[programcounter].chars().nth(0).unwrap()=='#'
                        {
                            let mut bwee = false;
                            for var in &mut intvars{
                                if var.name==bpara[0]{
                                    var.value=bpara[1].parse().unwrap();
                                    bwee=true;
                                }
                            }
                            if !bwee{
                                intvars.push(
                                    IntVariable { name: bpara[0].trim().to_string(), value: bpara[1].trim().parse().unwrap() }
                                )
                            }
                        }
                    }
                    _ => {
                        programcounter+=1;
                    }
                }
            }
        }

    } else if args.len()<2 {
        println!("please enter a file")
    } else {
        println!("please enter only one file")
    }
}
