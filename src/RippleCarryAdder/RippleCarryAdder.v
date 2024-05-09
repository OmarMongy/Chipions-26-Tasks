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
