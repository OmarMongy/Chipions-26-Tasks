module ALU(
  input [7:0] x, y,
  input [2:0] sel,
  output reg [15:0] z
);
always @(*)
begin
    case (sel)
      3'b000 : z = x + y;
      3'b001 : z = x - y;
      3'b010 : z = x * y;
      3'b011 : z = { x % y, x / y };
      3'b100 : z = x | y;
      3'b101 : z = x & y;
      3'b110 : z = ~x;
      3'b111 : z = ~y;
    endcase
end
endmodule 
