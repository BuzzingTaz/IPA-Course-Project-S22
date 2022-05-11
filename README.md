# Intro to Processor Architecture - Project (Spring 2022)

*Reuploaded to a different repository since the earlier one was under the institue*

**This was a group project with [Jaishnav Yarammaneni](https://github.com/jaishnavyarramaneni) in Spring 2022**
## Sequential and 5-staged Pipelined processor implemetations of the Y86-64 ISA

- This processor has a instruction memory size of 2kB and data memory size of 8kB
- All necessary funcionalities including call and ret are working in both implemetations.

```
.      
├── ALU
│   ├── ALU.v
│   ├── Add_64bit.v
│   ├── CLA_Adder_4bit.v
│   ├── Sub_64bit.v
│   ├── gates64.v
│   └── testbenches
│       ├── ALU_test.v
│       ├── Add_test.v
│       ├── Sub_test.v
│       ├── and_test.v
│       └── xor_test.v
├── Instrmems
│   ├── gcd_fun.s
│   ├── gcd_fun.v
│   ├── gcd_with_call_ret.v
│   └── gcd_wtih_call_ret.s
├── Pipe
│   ├── decode.v
│   ├── decode_test.v
│   ├── execute.v
│   ├── fetch.v
│   ├── fetch_test.v
│   ├── memory.v
│   ├── pipe_control.v
│   └── processor.v
├── Project Report.pdf
├── README.md
├── Sequential
│   ├── decode.v
│   ├── decode_test.v
│   ├── execute.v
│   ├── execute_pc_test.v
│   ├── fetch.v
│   ├── fetch_test.v
│   ├── memory.v
│   ├── pc_update.v
│   └── processor.v
```
## Running the code

### For `seq`

```bash
cd Sequential
iverilog -o seq processor.v
vvp seq
```

### For `pipe`
```bash
cd Pipe
iverilog -o pipe processor.v
vvp pipe
```

- Replace the instr_mem defined inside the initial block in `fetch.v` in pipe to execute different programs from `instrmems` folder

## Working functions
All functionalities including call and ret are working.
```
halt
nop
cmovxx
irmov
rmmov
mrmov
addq
subq
andq
xorq
jxx
call
ret
push
pop
```