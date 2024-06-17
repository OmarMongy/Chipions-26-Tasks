# Overview
- Welcome to the Chipions`26 Digital IC Training Tasks and Assignments repository!
- This repository serves as a centralized hub for all tasks, assignments, and related materials to my digital integrated circuit (IC) training program

## Table of Contents
1. `ALU ` : - [Arithmetic logic unit](#Arithmetic_logic_unit)
2. `Sequence Detector FSM ` : - [Sequence Detector FSM](#Sequence_Detector_FSM)
## Arithmetic_logic_unit
Digital circuits often require arithmetic and logical operations to process data efficiently. This project aims to provide reusable Verilog modules for implementing such operations, enhancing the design and development process of digital systems.

## Project Structure
The project is structured as follows:
- **`FullAdder.v`**: This module implements a full adder circuit capable of adding two binary inputs along with a carry-in.
- **`RippleCarryAdder.v`**: The ripple carry adder module utilizes multiple instances of the full adder to perform binary addition for multiple bits.
- **`ALU.v`**: This module serves as an arithmetic logic unit supporting various arithmetic and logical operations based on an opcode.
- **`ALU_Golden.v`**: A golden model of the ALU is provided for verification purposes, ensuring the correctness of the main ALU module.
- **`ALU_tb.v`**: This testbench module is designed to validate the functionality of the ALU module against the golden model.

## Usage
To integrate these Verilog modules into your digital circuit designs:
1. **Instantiate Modules**: Incorporate the desired modules (`FullAdder`, `RippleCarryAdder`, or `ALU`) into your Verilog designs by instantiating them and connecting input and output ports appropriately.
2. **Configure Parameters**: For modules with configurable parameters (such as `WIDTH` and `OPCODE`), adjust the parameters to suit your specific requirements.
3. **Simulation and Synthesis**: Simulate the designs using a Verilog simulator to verify functionality. Additionally, these modules can be synthesized for implementation on FPGA or ASIC platforms.

## Opcode and Operations
The ALU module supports various operations based on the opcode provided:
- `000`: Addition
- `001`: Subtraction
- `010`: Bitwise AND
- `011`: Bitwise OR
- `100`: Bitwise XOR
- `101`: Set on Less Than [Inp1 > Inp2]
- `110`: Left Shift Inp1 with 1 bit
- `111`: Left Shift Inp2 with 1 bit

## Verification
Verification is essential to ensure the correctness of digital designs. The provided testbench `ALU_tb.v` facilitates verification by comparing the outputs of the main ALU module with the outputs of the golden model `ALU_Golden.v`. Running simulations using this testbench enables thorough testing of the ALU functionality.

### Simulation Results
`Golden Model Verification`
![Simulation Image 1](https://i.ibb.co/fD0hhrm/Screenshot-2024-05-09-210230.png)
`Testing the ALU model`
![Simulation Image 1](https://i.ibb.co/QCgVVsf/Screenshot-2024-05-09-205912.png)

### Transcript Report
- ![Transcript Report 1](https://i.ibb.co/K50B4jS/Screenshot-2024-05-09-002227.png)
- ![Transcript Report 1](https://i.ibb.co/tcF181v/Screenshot-2024-05-09-002238.png)


# Sequence_Detector_FSM

This project contains the Verilog code for sequence detectors implemented using Moore and Mealy state machines. It includes testbenches to verify the functionality of both implementations.

## Overview

A sequence detector is a finite state machine (FSM) that can detect a specific sequence of bits from a stream of input bits. This project demonstrates two different implementations of sequence detectors:

1. **Moore State Machine**
2. **Mealy State Machine**

### Moore State Machine

The Moore state machine is a type of FSM where the output depends only on the current state. The sequence is detected based on the state transitions.

- **State Definitions**: Five states (S0, S1, S2, S3, S4).
- **State Transition**: Transitions between states based on the input bit stream.
- **Output Logic**: Sequence detected output is based on the state.

### Mealy State Machine

The Mealy state machine is a type of FSM where the output depends on both the current state and the current inputs. This allows for potentially faster reaction to inputs since outputs can change in the middle of a state transition.

- **State Definitions**: Four states (S0, S1, S2, S3).
- **State Transition**: Transitions between states based on the input bit stream.
- **Output Logic**: Sequence detected output is based on both the state and input.

## File Structure

- **Moore State Machine**
  - `Moore_seq.v`: Verilog module for the Moore sequence detector.
  - `tb_Moore_seq.v`: Testbench for the Moore sequence detector.

- **Mealy State Machine**
  - `Mealy_seq.v`: Verilog module for the Mealy sequence detector.
  - `tb_Mealy_seq.v`: Testbench for the Mealy sequence detector.


## Simulation Results
`Moore Machine`
![Simulation Image 1](https://i.ibb.co/MNWTZhg/Moore-Sequence-Detector.png)
`Mealy Machine`
![Simulation Image 1](https://i.ibb.co/KwrLFb7/Mealy-Sequence-Detector.png)
## Comparison between Moore and Mealy Machines
- Output Logic:

`Moore`: The output depends solely on the current state. This can lead to a more stable and predictable output but might introduce a delay since the output only changes at state boundaries.
`Mealy`: The output depends on both the current state and the input. This can allow the FSM to react faster to inputs since the output can change as soon as the input changes.

  
- State Complexity:

`Moore`: Typically requires more states than a Mealy machine for the same functionality because it cannot produce different outputs in the same state based on inputs.
`Mealy`: Can often achieve the same functionality with fewer states compared to a Moore machine.
- Design Simplicity:

`Moore`: Simpler to design and understand since outputs are associated directly with states.
`Mealy`: Slightly more complex due to the dependence on both state and input, but can result in more efficient designs.
-Conclusion
Both Moore and Mealy machines have their own advantages and are used based on the requirements of the system. Moore machines provide more predictable outputs, while Mealy machines can be more responsive to inputs.
