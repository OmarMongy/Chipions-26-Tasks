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
    carry_out  = 1'b0;
    zero_flag  = 1'b1;
    valid_flag = 1'b0;
    slt_flag   = 1'b0;
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
        // SLT operation
        3'b101 : begin
            slt_flag   = data_in1 > data_in2;
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
