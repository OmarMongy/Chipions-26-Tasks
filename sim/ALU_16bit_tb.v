 module ALU_tb();
  reg [7:0] x, y;
  reg [2:0] sel;
  wire [15:0] z;
  wire overflow;
  ALU uut (
    .x(x),
    .y(y),
    .sel(sel),
    .z(z)
  );
  initial
  begin
    x = 16'b1010_1111_1111_0000;
    y = 16'b1010_1111_1111_0000;
    sel = 3'b000;
        #5
    sel = 3'b001;
        #5
    sel = 3'b010;
        #5
    sel = 3'b011;
        #5
    sel = 3'b100;
        #5
    sel = 3'b101;
        #5
    sel = 3'b110;
        #5
    sel = 3'b111;
    
  end
 endmodule
