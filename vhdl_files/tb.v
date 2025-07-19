`timescale 1ps / 1ps

module tb;

    // Clock and reset
    reg clk = 0;
    reg rst = 1;

    // Testbench signals
    reg  [31:0] a_tb = 32'b0;
    reg  [31:0] b_tb = 32'b0;
    reg         cin_tb = 1'b0;
    wire        cout_tb;
    wire [31:0] s_tb;

    // Clock generation
    always #750 clk = ~clk; 

    // Instantiate the Unit Under Test (UUT)
    knowles_adder32_reg uut (
        .clk(clk),
        .rst(rst),
        .A(a_tb),
        .B(b_tb),
        .Cin(cin_tb),
        .Cout(cout_tb),
        .S(s_tb)
    );

    // SDF Annotation
    initial begin
        $sdf_annotate("knowles_adder32_reg_m.sdf", uut, , , "MAXIMUM");
    end

    // Stimulus
    initial begin
        // Apply reset
        #10 rst = 1;
        #20 rst = 0;

        // Apply test vectors
        @(posedge clk);
        a_tb = 32'h00000000; b_tb = 32'h00000000; cin_tb = 1'b0;
        @(posedge clk);
        a_tb = 32'h000000FF; b_tb = 32'h00000001; cin_tb = 1'b0;
        @(posedge clk);
        a_tb = 32'h12340000; b_tb = 32'h43210000; cin_tb = 1'b1;
        @(posedge clk);
        a_tb = 32'hFFFFFFFF; b_tb = 32'h0001FFFF; cin_tb = 1'b1;
        @(posedge clk);
        a_tb = 32'hABCD0000; b_tb = 32'h12340001; cin_tb = 1'b0;

        // Stop after some time
        #20000 $stop;
    end

endmodule
