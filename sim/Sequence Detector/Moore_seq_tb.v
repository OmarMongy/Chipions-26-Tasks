module Moore_seq_tb;
parameter WIDTH =4;
// Testbench signals
reg clk;
reg reset_n;
reg data_in;
wire seq_detected;
wire [WIDTH-1:0] current_seq;

// Instantiate the sequence detector module
Moore_seq uut (
    .clk(clk),
    .reset_n(reset_n),
    .data_in(data_in),
    .seq_detected(seq_detected),
    .current_seq(current_seq)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
end

// Test sequence
initial begin
    // Initialize inputs
    reset_n = 0;
    data_in = 0;

    // Apply reset
    #10 reset_n = 1;

    // Apply test vectors
    #10 data_in = 0;  
    #10 data_in = 1;  
    #10 data_in = 1;  
    #10 data_in = 0;  
    #10 data_in = 1;  // Should detect 
    #10 data_in = 1;   
    #10 data_in = 0;  
    #10 data_in = 1;  // Should detect again 
    #10 data_in = 0;  

    // Finish the simulation
    #50 $stop;
end
