////************************\\\\
module FullAdder(
input  wire data_in1, data_in2,
input  wire carry_in,
output wire sum,
output wire carry_out
);

assign {carry_out, sum} = data_in1 + data_in2 + carry_in;

endmodule
////************************\\\\
module RippleCarryAdder
#(parameter WIDTH = 8)
(
input  wire [WIDTH-1:0] data_in1, data_in2, 
input  wire             control_signal,
input  wire             enable,// Enable signal to control the circuit
output reg  [WIDTH-1:0] data_out,
output reg              carry_out        
);
wire   [WIDTH:0]   carry;
wire   [WIDTH-1:0] xored;
wire   [WIDTH-1:0] data;

assign carry[0]  = control_signal; 
assign xored     = data_in2 ^ {WIDTH{control_signal}};

generate
    genvar i;
      for(i=0;i<WIDTH;i=i+1)
        begin  
            FullAdder FA(
            .data_in1(data_in1[i]),
            .data_in2(xored[i]),
            .carry_in(carry[i]),
            .carry_out(carry[i+1]),
            .sum(data[i])
            );
        end
endgenerate

always@(*)
  begin
    if(enable)
        begin
          data_out  = data;
          carry_out = carry[WIDTH] & ~control_signal;
        end
    else
        begin
          data_out  = 0;
          carry_out = 0;      
        end     
  end
endmodule
////************************\\\\
module ALU
#(parameter WIDTH = 8, OPCODE = 3)
(
input  wire [WIDTH-1:0]  data_in1, data_in2, 
input  wire [OPCODE-1:0] op_code,
input  wire              valid_data,//Indicates whether the input data is valid or not.
output reg  [WIDTH-1:0]  data_out,
output wire              carry_out,
output wire              zero_flag,
output wire              valid_flag,
output wire              slt_flag
);
wire [WIDTH-1:0] RCA_result;
reg  [WIDTH-1:0] result;
RippleCarryAdder RCA(
.data_in1(data_in1),
.data_in2(data_in2),
.enable(~op_code[2]&~op_code[1]), // Enable signal for the adder
.control_signal(op_code[0]),
.carry_out(carry_out),
.data_out(RCA_result)
);

always@(*)
  begin
    case(op_code)
      3'b000 : result = RCA_result;
      3'b001 : result = RCA_result;
      3'b010 : result = data_in1 & data_in2;
      3'b011 : result = data_in1 | data_in2;
      3'b100 : result = data_in1 ^ data_in2;
    //3'b101 : result = data_in1 >> data_in2;
      3'b110 : result = data_in1 << 1'b1;
      3'b111 : result = data_in2 << 1'b1;
      default: result = {WIDTH{1'b0}}; 
    endcase
  end

always@(*)
  begin
    if(valid_data)
      data_out = result;   // Update data_out with ALU result when valid_data is asserted
    else  
      data_out = data_out; // Keep data_out unchanged when valid_data is deasserted
  end  
assign zero_flag  =  ~(|data_out); 
assign valid_flag = ~ zero_flag;
assign slt_flag   = data_in1 > data_in2;
endmodule
////************************\\\\
module ALU_Golden
#(parameter WIDTH = 8, OPCODE = 3)
(
    input  wire [WIDTH-1:0]  data_in1,
    input  wire [WIDTH-1:0]  data_in2,
    input  wire [OPCODE-1:0] op_code,
    input  wire              valid_data,
    output wire [WIDTH-1:0]  data_out,
    output reg               carry_out,
    output reg               zero_flag,
    output reg               valid_flag,
    output reg               slt_flag
);
reg [WIDTH:0] data;
assign data_out = (valid_data)? data[WIDTH-1:0] : 0;
// Perform the same operations as the ALU module based on the provided inputs
always @* begin
    data = {WIDTH{1'b0}};
    carry_out = 1'b0;
    zero_flag = 1'b1;
    valid_flag = 1'b0;
    slt_flag = (data_in1 > data_in2);
    case(op_code)
        // Addition operations
        3'b000 : begin
            data = data_in1 + data_in2;
            carry_out = (data[WIDTH]);
            zero_flag = (data == 0);
            valid_flag = ~zero_flag;
        end      
        3'b001 : begin
            data = data_in1 - data_in2;
            zero_flag = (data == 0);
            valid_flag = ~zero_flag;
        end
        // Bitwise AND operation
        3'b010 : begin
            data = data_in1 & data_in2;
            zero_flag = (data == 0);
            valid_flag = ~zero_flag;
        end
        // Bitwise OR operation
        3'b011 : begin
            data = data_in1 | data_in2;
            zero_flag = (data == 0);
            valid_flag = ~zero_flag;
        end
        // Bitwise XOR operation
        3'b100 : begin
            data = data_in1 ^ data_in2;
            zero_flag = (data == 0);
            valid_flag = ~zero_flag;
        end
        // Right shift operation
        3'b110 : begin
            data = data_in1 << 1'b1;
            zero_flag = (data == 0);
            valid_flag = ~zero_flag;
        end
        // Left shift operation
        3'b111 : begin
            data = data_in2 << 1;
            zero_flag = (data == 0);
            valid_flag = ~zero_flag;
        end
    endcase
end

endmodule
////************************\\\\

module ALU_tb;

// Parameters
parameter WIDTH = 8;
parameter OPCODE = 3;

// Inputs
reg [WIDTH-1:0]  data_in1, data_in2;
reg [OPCODE-1:0] op_code;
reg              valid_data;

// Outputs
wire [WIDTH-1:0] data_out;
wire [WIDTH-1:0] golden_data_out;
wire             carry_out, zero_flag, valid_flag, slt_flag;
wire             golden_carry_out, golden_zero_flag, golden_valid_flag, golden_slt_flag;
    // Instantiate ALU module and golden model
    ALU #(
        .WIDTH(WIDTH),
        .OPCODE(OPCODE)
    ) dut (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .op_code(op_code),
        .valid_data(valid_data),
        .data_out(data_out),
        .carry_out(carry_out),
        .zero_flag(zero_flag),
        .valid_flag(valid_flag),
        .slt_flag(slt_flag)
    );

    ALU_Golden #(
        .WIDTH(WIDTH),
        .OPCODE(OPCODE)
    ) golden (
        .data_in1(data_in1),
        .data_in2(data_in2),
        .op_code(op_code),
        .valid_data(valid_data),
        .data_out(golden_data_out),
        .carry_out(golden_carry_out),
        .zero_flag(golden_zero_flag),
        .valid_flag(golden_valid_flag),
        .slt_flag(golden_slt_flag)
    );


    // Stimulus
initial
begin
        repeat (20) begin
            // Generate random inputs
            data_in1 = $random;
            data_in2 = $random;
            op_code = $random;
            valid_data = 1'b1;

            // Apply inputs and validate outputs
            #10;
            $display("Test Case: data_in1 = %h, data_in2 = %h, op_code = %h, valid_data = %b",
            data_in1, data_in2, op_code, valid_data);
            #10;
            if (data_out   === golden_data_out    && 
                carry_out  === golden_carry_out   &&
                zero_flag  === golden_zero_flag   && 
                valid_flag === golden_valid_flag  &&
                slt_flag   === golden_slt_flag)
                $display("Result: Match\n");
            else
                $display("Result: Mismatch\n");
        end
        #10 $stop;
end

endmodule



