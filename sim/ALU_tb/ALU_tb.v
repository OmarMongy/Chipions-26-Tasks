module ALU_tb;
parameter WIDTH = 8, OPCODE = 3, T = 1;
// Inputs
reg [WIDTH-1:0]  data_in1, data_in2;
reg [OPCODE-1:0] op_code;
reg              valid_data;
// Outputs
wire [WIDTH-1:0] data_out;
wire             carry_out, zero_flag, valid_flag, slt_flag;
// Instantiate ALU module 
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
// Stimulus
initial
begin
  data_in1   = 'd0;
  data_in2   = 'd0;
  valid_data = 1'b0;
  op_code    = 3'b000;
  #(5*T);
  data_in1   = 'd255;
  data_in2   = 'd255;
  op_code    = 3'b000;
  #(5*T);
  valid_data = 1'b1;
  op_code    = 3'b000;
  #(5*T);
  data_in1   = 'd40;
  data_in2   = 'd50;
  op_code    = 3'b001;
  #(5*T);
  data_in1   = 'd30;
  data_in2   = 'd30;
  op_code    = 3'b010;
  #(5*T);
  data_in1   = 'd0;
  data_in2   = 'd0;
  op_code    = 3'b011;
  valid_data = 1'b0;
  #(5*T);
  valid_data = 1'b1;  
  #(5*T);
  data_in1   = 'd0;
  data_in2   = 'd30;
  op_code    = 3'b100;
  #(5*T);
  data_in1   = 'd10;
  data_in2   = 'd0;
  op_code    = 3'b101;
  #(5*T);
  data_in1   = 'd10;
  data_in2   = 'd10;
  op_code    = 3'b110;
  #(5*T);
  op_code    = 3'b111;
  #(5*T);
  $stop;
end
endmodule
