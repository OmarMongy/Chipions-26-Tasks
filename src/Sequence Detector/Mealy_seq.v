module Mealy_seq
#(parameter WIDTH = 4)
( 
input  wire             clk, reset_n,
input  wire             data_in,
output wire             seq_detected,
output reg  [WIDTH-1:0] current_seq 
);
reg[1:0] state_reg, state_next;
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

always@(posedge clk, negedge reset_n)
begin
  if(!reset_n)
      begin
       state_reg <= S0;  
        current_seq <= 4'd0;
      end
  else
      begin
        state_reg <= state_next; 
         current_seq <= {current_seq[WIDTH-2:0],data_in};        
      end
end

always@(*)
  begin
    case(state_reg)
      S0 : 
          if(data_in)
            state_next = S1;
          else
            state_next = S0;
            
      S1 : 
          if(data_in)
            state_next = S2;
          else
            state_next = S0; 
             
       S2 : 
          if(data_in)
            state_next = S1;
          else
            state_next = S3;
  
        S3 : 
          if(data_in)
            begin
            state_next = S1;
            end
          else
            state_next = S0;  
            
        default : 
                  state_next = S0;                           
    endcase      
  end

assign seq_detected = (state_reg == S3) && data_in;  
endmodule
