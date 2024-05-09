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
output reg               slt_flag
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
    slt_flag = 1'b0;
    result = {WIDTH{1'b0}};
    case(op_code)
      3'b000 : result   = RCA_result;
      3'b001 : result   = RCA_result;
      3'b010 : result   = data_in1 & data_in2;
      3'b011 : result   = data_in1 | data_in2;
      3'b100 : result   = data_in1 ^ data_in2;
      3'b101 : slt_flag = data_in1 > data_in2;
      3'b110 : result   = data_in1 << 1'b1;
      3'b111 : result   = data_in2 << 1'b1;
      default: begin 
                result   = {WIDTH{1'b0}};
                slt_flag = 1'b0;
               end 
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

endmodule
