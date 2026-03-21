`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2026 19:58:32
// Design Name: 
// Module Name: tb_comparator
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

module tb_comparator;

    parameter DATA_WIDTH  = 8;
    parameter COUNT_WIDTH = 8;

    reg clk_i;
    reg rst_i;
    reg compare_en_i;

    reg [DATA_WIDTH-1:0] read_data_i;
    reg [DATA_WIDTH-1:0] expected_data_i;

    wire fail_flag_o;
    wire [COUNT_WIDTH-1:0] fail_count_o;

    // DUT
    comparator #(
        .DATA_WIDTH(DATA_WIDTH),
        .COUNT_WIDTH(COUNT_WIDTH)
    ) uut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .compare_en_i(compare_en_i),
        .read_data_i(read_data_i),
        .expected_data_i(expected_data_i),
        .fail_flag_o(fail_flag_o),
        .fail_count_o(fail_count_o)
    );

    // Clock (10 ns period)
    always #5 clk_i = ~clk_i;

    initial begin
        clk_i = 0;
        rst_i = 1;
        compare_en_i = 0;
        read_data_i = 0;
        expected_data_i = 0;

        // RESET
        #20;
        rst_i = 0;

        // -------------------------------
        // CASE 1: MATCH (no fail)
        // -------------------------------
        compare_en_i = 1;
        read_data_i = 8'hAA;
        expected_data_i = 8'hAA;
        @(posedge clk_i);

        // -------------------------------
        // CASE 2: FIRST MISMATCH
        // -------------------------------
        read_data_i = 8'hAA;
        expected_data_i = 8'h55;
        @(posedge clk_i);

        // -------------------------------
        // CASE 3: SECOND MISMATCH
        // -------------------------------
        read_data_i = 8'h0F;
        expected_data_i = 8'hF0;
        @(posedge clk_i);

        // -------------------------------
        // CASE 4: MATCH AGAIN (no increment)
        // -------------------------------
        read_data_i = 8'hFF;
        expected_data_i = 8'hFF;
        @(posedge clk_i);

        // -------------------------------
        // CASE 5: DISABLE COMPARE
        // -------------------------------
        compare_en_i = 0;
        read_data_i = 8'h00;
        expected_data_i = 8'hFF;
        @(posedge clk_i);

        // -------------------------------
        // CASE 6: RESET (clear everything)
        // -------------------------------
        rst_i = 1;
        @(posedge clk_i);
        rst_i = 0;

        // -------------------------------
        // CASE 7: AFTER RESET (new mismatch)
        // -------------------------------
        compare_en_i = 1;
        read_data_i = 8'h11;
        expected_data_i = 8'h22;
        @(posedge clk_i);

        $display("Comparator with counter test completed");
        $finish;
    end

    // Monitor
    always @(posedge clk_i) begin
        $monitor("read=%h exp=%h | en=%b | fail=%b | count=%0d",
                 read_data_i, expected_data_i,
                 compare_en_i, fail_flag_o, fail_count_o);
    end

endmodule