`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 18:00:57
// Design Name: 
// Module Name: addr_gen
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

module addr_gen #(
    parameter ADDR_WIDTH = 8
)(
    input  wire                   clk_i,
    input  wire                   rst_i,
    input  wire                   addr_en_i,     // enable increment
    input  wire                   addr_rst_i,    // reset address to 0
    output reg  [ADDR_WIDTH-1:0]  addr_o,
    output wire                   addr_done_o    // high when last address reached
);

    // Max address (e.g., 255 for 8-bit)
    localparam [ADDR_WIDTH-1:0] MAX_ADDR = {ADDR_WIDTH{1'b1}};

    // Address counter
    always @(posedge clk_i) begin
        if (rst_i || addr_rst_i) begin
            addr_o <= {ADDR_WIDTH{1'b0}};
        end 
        else if (addr_en_i) begin
            addr_o <= addr_o + 1'b1;
        end
    end

    // Done signal
    assign addr_done_o = (addr_o == MAX_ADDR);

endmodule
