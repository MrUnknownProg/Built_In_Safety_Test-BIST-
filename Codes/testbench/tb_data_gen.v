`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:51:06
// Design Name: 
// Module Name: tb_data_gen
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

module tb_data_gen;

    parameter DATA_WIDTH = 8;

    reg  [1:0] pattern_sel_i;
    reg  [DATA_WIDTH-1:0] addr_i;   // not used now, but included
    wire [DATA_WIDTH-1:0] data_o;

    // DUT
    data_gen #(
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .pattern_sel_i(pattern_sel_i),
        .addr_i(addr_i),
        .data_o(data_o)
    );

    initial begin
        // Initialize
        pattern_sel_i = 2'b00;
        addr_i = 0;

        $display("---- DATA GENERATOR TEST START ----");

        // Test 0x00
        #10;
        $display("Pattern 00 | Expected = 00 | Got = %h", data_o);

        // Test 0xFF
        pattern_sel_i = 2'b01;
        #10;
        $display("Pattern 01 | Expected = FF | Got = %h", data_o);

        // Test 0xAA
        pattern_sel_i = 2'b10;
        #10;
        $display("Pattern 10 | Expected = AA | Got = %h", data_o);

        // Test 0x55
        pattern_sel_i = 2'b11;
        #10;
        $display("Pattern 11 | Expected = 55 | Got = %h", data_o);

//        // Optional: random switching check
//        pattern_sel_i = 2'b00; #10;
//        pattern_sel_i = 2'b11; #10;
//        pattern_sel_i = 2'b01; #10;

        $display("---- TEST COMPLETED ----");

        $finish;
    end

endmodule
