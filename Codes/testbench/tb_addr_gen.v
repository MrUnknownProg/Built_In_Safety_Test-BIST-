`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 18:14:31
// Design Name: 
// Module Name: tb_addr_gen
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

module tb_addr_gen;

    parameter ADDR_WIDTH = 8;

    reg clk_i;
    reg rst_i;
    reg addr_en_i;
    reg addr_rst_i;

    wire [ADDR_WIDTH-1:0] addr_o;
    wire addr_done_o;

    addr_gen #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .addr_en_i(addr_en_i),
        .addr_rst_i(addr_rst_i),
        .addr_o(addr_o),
        .addr_done_o(addr_done_o)
    );

    // Clock
    always #5 clk_i = ~clk_i;

    initial begin
        clk_i = 0;
        rst_i = 1;
        addr_en_i = 0;
        addr_rst_i = 0;

        // Reset
        #20;
        rst_i = 0;

        // Start counting
        addr_en_i = 1;

        // Wait until FULL count reached (addr = 255)
        wait (addr_done_o == 1);

        // Wait one extra cycle (important)
        @(posedge clk_i);

        $display("Full count completed (0-255)");

        // Stop simulation
        $finish;
    end

    // Debug monitor
    always @(posedge clk_i) begin
        $display("T=%0t | addr=%0d | done=%b", $time, addr_o, addr_done_o);
    end

endmodule
