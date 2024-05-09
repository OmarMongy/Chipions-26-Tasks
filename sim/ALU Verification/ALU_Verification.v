module ALU_Verification;
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
