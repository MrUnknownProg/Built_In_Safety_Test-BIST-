`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2026 21:27:14
// Design Name: 
// Module Name: control_logic
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


module control_logic #(
    parameter ADDR_WIDTH = 8
)(
    input  wire clk_i,
    input  wire rst_i,
    input  wire start_i,
    input  wire addr_done_i,

    output reg addr_en_o,
    output reg addr_rst_o,
    output reg we_o,
    output reg compare_en_o,
    output reg done_o
);

    // State encoding (Verilog style)
    parameter IDLE         = 3'b000;
    parameter INIT         = 3'b001;
    parameter WRITE        = 3'b010;
    parameter READ_SETUP   = 3'b011;
    parameter READ_WAIT    = 3'b100;
    parameter READ_COMPARE = 3'b101;
    parameter DONE         = 3'b110;

    reg [2:0] state, next_state;

    // State register
    always @(posedge clk_i) begin
        if (rst_i)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)

            IDLE:
                next_state = (start_i) ? INIT : IDLE;

            INIT:
                next_state = WRITE;

            WRITE:
                next_state = (addr_done_i) ? READ_SETUP : WRITE;

            READ_SETUP:
                next_state = READ_WAIT;

            READ_WAIT:
                next_state = READ_COMPARE;

            READ_COMPARE:
                next_state = (addr_done_i) ? DONE : READ_WAIT;

            DONE:
                next_state = DONE;

            default:
                next_state = IDLE;

        endcase
    end

    // Output logic
    always @(*) begin
        // default values
        addr_en_o    = 0;
        addr_rst_o   = 0;
        we_o         = 0;
        compare_en_o = 0;
        done_o       = 0;

        case (state)

            INIT: begin
                addr_rst_o = 1;
            end

            WRITE: begin
                addr_en_o = 1;
                we_o      = 1;
            end

            READ_SETUP: begin
                addr_rst_o = 1;
            end

            READ_WAIT: begin
                addr_en_o = 1;
            end

            READ_COMPARE: begin
                compare_en_o = 1;
            end

            DONE: begin
                done_o = 1;
            end

        endcase
    end

endmodule