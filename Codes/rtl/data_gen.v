`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 19:49:34
// Design Name: 
// Module Name: data_gen
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

module data_gen #(
    parameter DATA_WIDTH = 8
)(
    input  wire [1:0]                 pattern_sel_i,  // selects pattern
    input  wire [DATA_WIDTH-1:0]      addr_i,         // optional use
    output reg  [DATA_WIDTH-1:0]      data_o
);

    always @(*) begin
        case (pattern_sel_i)

            2'b00: data_o = {DATA_WIDTH{1'b0}};           // 0x00

            2'b01: data_o = {DATA_WIDTH{1'b1}};           // 0xFF

            2'b10: data_o = {DATA_WIDTH/2{2'b10}};        // 0xAA

            2'b11: data_o = {DATA_WIDTH/2{2'b01}};        // 0x55

            default: data_o = {DATA_WIDTH{1'b0}};

        endcase
    end

endmodule
