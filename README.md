# ALU

## Overview
This repository contains Verilog implementations of essential arithmetic logic units (ALUs) and supporting components. These modules are designed to facilitate arithmetic and logical operations in digital circuits. 

## Table of Contents
1. Introduction
2. Project Structure
3. Usage
4. Opcode and Operations
5. Verification
6. Simulation Results
7. Transcript Report

## Introduction
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

## Simulation Results
![Simulation Image 1](simulation_image1.png)
*Caption for Simulation Image 1*

![Simulation Image 2](simulation_image2.png)
*Caption for Simulation Image 2*

## Transcript Report
Include your transcript report here, summarizing the results of the simulations and any observations or conclusions drawn from them.
