module tb_Mealy_seq;
parameter WIDTH =4;
// Testbench signals
reg clk;
reg reset_n;
reg data_in;
wire seq_detected;
wire [WIDTH-1:0] current_seq;

// Instantiate the sequence detector module
Mealy_seq uut (
    .clk(clk),
    .reset_n(reset_n),
    .data_in(data_in),
    .seq_detected(seq_detected),
    .current_seq(current_seq)
);

// Clock generation
initial begin
    clk = 0;
    forever #10 clk = ~clk; // 10 time units period
end

// Test sequence
initial begin
    // Initialize inputs
    reset_n = 0;
    data_in = 0;

    // Apply reset
    #20 reset_n = 1;

    // Apply test vectors
    #20 data_in = 0;  
    #20 data_in = 1;  
    #20 data_in = 1; 
    #20 data_in = 0;  
    #20 data_in = 1; 
    #20 data_in = 1;  
    #20 data_in = 0;  
    #20 data_in = 1;  
    #20 data_in = 0;  

    // Finish the simulation
    #50 $stop;
end

// Monitor the output
initial begin
    $monitor("At time %t, data_in = %b, seq_detected = %b", $time, data_in, seq_detected);
end

endmodule
