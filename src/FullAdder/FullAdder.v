module FullAdder(
input  wire data_in1, data_in2,
input  wire carry_in,
output wire sum,
output wire carry_out
);

assign {carry_out, sum} = data_in1 + data_in2 + carry_in;

endmodule
////************************\\\\
