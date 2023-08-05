# ALU_16bit


## Description:

The objective of this design problem is to create an Arithmetic Logic Unit (ALU) capable of performing various arithmetic and logical operations on two 16-bit inputs, based on a third input known as the "opcode." The ALU should produce a 32-bit output representing the result of the selected operation.

An ALU is a fundamental digital circuit found in central processing units (CPUs) and microprocessors. Its primary function is to perform arithmetic (e.g., addition, subtraction) and logical (e.g., AND, OR, XOR) operations on binary data. In this design problem, we are tasked with developing a specific 16-bit ALU that supports a variety of operations, including addition, subtraction, bitwise AND, bitwise OR, bitwise XOR, and other logical operations based on the opcode provided.



## Inputs :
•	Two inputs (Inp1 , Inp2) of 16-bit , These inputs hold the data on which the ALU will perform the designated operation.
•	Opcode (Operation Code) of 3-bit , The opcode  input selects the operation that the ALU should perform on the two input operands. The opcode should be capable of representing different operations uniquely.
## Outputs :
•	The ALU should produce a 32-bit output (Result) that represents the result of the selected operation. The output width is determined by the maximum result size of the supported operations.

## Operations :

## Opcode	Operation 

- 000	Addition           { Inp1 + Inp2 }        
- 001	Subtraction        { Inp1 – Inp2 }
- 010	Multiplication     { Inp1 * Inp2 }
- 011	Division           { Inp1 / Inp2 }
- 100	Logical OR         { Inp1 | Inp2 }
- 101	Logical AND        { Inp1 & Inp2 }
- 110	Logical NOT        { ~ Inp1 }
- 111	Logical NOT        { ~ Inp2 }
