//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
//Date        : Sat Mar 21 00:57:50 2026
//Host        : HP15S running 64-bit major release  (build 9200)
//Command     : generate_target design_2_wrapper.bd
//Design      : design_2_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_2_wrapper
   (clk_i_0,
    done_o_0,
    fail_count_o_0,
    fail_flag_o_0,
    fault_en_i_0,
    rst_i_0,
    start_i_0);
  input clk_i_0;
  output done_o_0;
  output [7:0]fail_count_o_0;
  output fail_flag_o_0;
  input fault_en_i_0;
  input rst_i_0;
  input start_i_0;

  wire clk_i_0;
  wire done_o_0;
  wire [7:0]fail_count_o_0;
  wire fail_flag_o_0;
  wire fault_en_i_0;
  wire rst_i_0;
  wire start_i_0;

  design_2 design_2_i
       (.clk_i_0(clk_i_0),
        .done_o_0(done_o_0),
        .fail_count_o_0(fail_count_o_0),
        .fail_flag_o_0(fail_flag_o_0),
        .fault_en_i_0(fault_en_i_0),
        .rst_i_0(rst_i_0),
        .start_i_0(start_i_0));
endmodule
