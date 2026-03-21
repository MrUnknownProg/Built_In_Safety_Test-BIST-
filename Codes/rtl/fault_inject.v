`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2026 00:53:26
// Design Name: 
// Module Name: fault_inject
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

module fault_inject #(
    parameter DATA_WIDTH = 8
)(
    input  wire [DATA_WIDTH-1:0] data_i,
    input  wire [DATA_WIDTH-1:0] addr_i,
    input  wire                  fault_en_i,   // NEW control signal
    output reg  [DATA_WIDTH-1:0] data_o
);

    always @(*) begin
        data_o = data_i;   // default: pass-through

        if (fault_en_i) begin
            // Inject fault only at specific address
            if (addr_i == 8'd10) begin
                data_o = ~data_i;   // invert data
            end
        end
    end

endmodule
