`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2026 19:47:25
// Design Name: 
// Module Name: comparator
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


module comparator #(
    parameter DATA_WIDTH = 8,
    parameter COUNT_WIDTH = 8   // can count up to 255 errors
)(
    input  wire                     clk_i,
    input  wire                     rst_i,
    input  wire                     compare_en_i,

    input  wire [DATA_WIDTH-1:0]    read_data_i,
    input  wire [DATA_WIDTH-1:0]    expected_data_i,

    output reg                      fail_flag_o,
    output reg [COUNT_WIDTH-1:0]    fail_count_o
);

    always @(posedge clk_i) begin
        if (rst_i) begin
            fail_flag_o  <= 1'b0;
            fail_count_o <= {COUNT_WIDTH{1'b0}};
        end 
        else if (compare_en_i) begin
            if (read_data_i != expected_data_i) begin
                fail_flag_o  <= 1'b1;              // latch fail
                fail_count_o <= fail_count_o + 1;  // increment count
            end
        end
    end

endmodule
