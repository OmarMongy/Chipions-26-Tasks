module Moore_seq
#(parameter WIDTH = 4)  
(
input  wire             clk,reset_n,
input  wire             data_in,      // Input bit stream
output wire             seq_detected, // Sequence detected output
output reg  [WIDTH-1:0] current_seq
);

reg [2:0] state_reg, state_next; 

// State definitions
localparam S0 = 3'b000, 
           S1 = 3'b001, 
           S2 = 3'b010, 
           S3 = 3'b011, 
           S4 = 3'b100; 

// State register logic (sequential)
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
      begin
        state_reg   <= S0; // Reset to initial state
        current_seq <= 4'b0000;
      end
    else
      begin
        state_reg   <= state_next; // Move to next state
        current_seq <= {current_seq[WIDTH-2:0],data_in};
      end
end

// Next state logic (combinational)
always @(*) begin
    case (state_reg)
        S0 : 
            if (data_in) 
                state_next = S1;
            else
                state_next = S0;

        S1 : 
            if (data_in) 
                state_next = S2;
            else
                state_next = S0;

        S2 : 
            if (data_in) 
                state_next = S2;
            else
                state_next = S3;

        S3 : 
            if (data_in) 
                state_next = S4;
            else
                state_next = S0;

        S4 : 
            if (data_in) 
                state_next = S2;
            else
                state_next = S0;

        default:
            state_next = S0; 
    endcase   
end

// Output logic
assign seq_detected = (state_reg == S4);

endmodule

