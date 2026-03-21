`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2026 00:09:24
// Design Name: 
// Module Name: tb_top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top_module2;

    reg clk_i_0;
    reg rst_i_0;
    reg start_i_0;
    reg fault_en_i_0;

    wire done_o_0;
    wire fail_flag_o_0;
    wire [7:0] fail_count_o_0;

    // DUT (Positional Instantiation)
    // Order MUST match module definition exactly
   top_module2 uut (
    clk_i_0,
    done_o_0,
    fail_count_o_0,
    fail_flag_o_0,
    fault_en_i_0,
    rst_i_0,
    start_i_0
);

    // Clock (10ns)
    always #5 clk_i_0 = ~clk_i_0;

    // Task: run one MBIST cycle
    task run_mbist;
    begin
        start_i_0 = 1;
        @(posedge clk_i_0);
        start_i_0 = 0;

        // Wait for completion
        wait(done_o_0 == 1);
        @(posedge clk_i_0);
    end
    endtask

    initial begin
        clk_i_0 = 0;
        rst_i_0 = 1;
        start_i_0 = 0;
        fault_en_i_0 = 0;

        // RESET
        #20;
        rst_i_0 = 0;

        // CASE 1: NO FAULT
        $display("\n===== CASE 1: NO FAULT =====");
        fault_en_i_0 = 0;

        run_mbist();

        $display("Result:");
        $display("FAIL FLAG  = %b", fail_flag_o_0);
        $display("FAIL COUNT = %d", fail_count_o_0);

        if (fail_flag_o_0 == 0 && fail_count_o_0 == 0)
            $display("PASS: No fault detected (correct)");
        else
            $display("ERROR: Unexpected failure!");

        // RESET before next test
        rst_i_0 = 1;
        @(posedge clk_i_0);
        rst_i_0 = 0;

        // CASE 2: FAULT ENABLED
        $display("\n===== CASE 2: FAULT ENABLED =====");
        fault_en_i_0 = 1;

        run_mbist();

        $display("Result:");
        $display("FAIL FLAG  = %b", fail_flag_o_0);
        $display("FAIL COUNT = %d", fail_count_o_0);

        if (fail_flag_o_0 == 1 && fail_count_o_0 > 0)
            $display("PASS: Fault detected correctly");
        else
            $display("ERROR: Fault NOT detected!");

        $display("\n===== TEST COMPLETED =====");
        $finish;
    end

    // Monitor
    initial begin
        $monitor("done=%b | fail=%b | count=%0d | fault_en=%b",
                 done_o_0, fail_flag_o_0,
                 fail_count_o_0, fault_en_i_0);
    end
    
    //Time required
    initial begin
        $timeformat(-9, 2, " ns", 10);
    end
    
    always @(posedge done_o_0) begin
        $display("MBIST completed at time = %t", $time);
    end

endmodule
