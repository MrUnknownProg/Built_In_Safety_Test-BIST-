//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
//Date        : Sat Mar 21 00:57:50 2026
//Host        : HP15S running 64-bit major release  (build 9200)
//Command     : generate_target design_2.bd
//Design      : design_2
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_2,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_2,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=5,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "design_2.hwdef" *) 
module design_2
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

  wire addr_gen_0_addr_done_o;
  wire [7:0]addr_gen_0_addr_o;
  wire [7:0]blk_mem_gen_0_doutb;
  wire clk_i_0;
  wire control_logic_0_addr_en_o;
  wire control_logic_0_addr_rst_o;
  wire control_logic_0_compare_en_o;
  wire control_logic_0_we_o;
  wire [7:0]data_gen_0_data_o;
  wire done_o_0;
  wire [7:0]fail_count_o_0;
  wire fail_flag_o_0;
  wire fault_en_i_0;
  wire [7:0]fault_inject_0_data_o;
  wire rst_i_0;
  wire start_i_0;
  wire [0:0]xlconstant_0_dout;

  design_2_addr_gen_0_0 addr_gen_0
       (.addr_done_o(addr_gen_0_addr_done_o),
        .addr_en_i(control_logic_0_addr_en_o),
        .addr_o(addr_gen_0_addr_o),
        .addr_rst_i(control_logic_0_addr_rst_o),
        .clk_i(clk_i_0),
        .rst_i(rst_i_0));
  design_2_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(addr_gen_0_addr_o),
        .addrb(addr_gen_0_addr_o),
        .clka(clk_i_0),
        .clkb(clk_i_0),
        .dina(data_gen_0_data_o),
        .doutb(blk_mem_gen_0_doutb),
        .ena(xlconstant_0_dout),
        .enb(xlconstant_0_dout),
        .wea(control_logic_0_we_o));
  design_2_comparator_0_0 comparator_0
       (.clk_i(clk_i_0),
        .compare_en_i(control_logic_0_compare_en_o),
        .expected_data_i(data_gen_0_data_o),
        .fail_count_o(fail_count_o_0),
        .fail_flag_o(fail_flag_o_0),
        .read_data_i(fault_inject_0_data_o),
        .rst_i(rst_i_0));
  design_2_control_logic_0_0 control_logic_0
       (.addr_done_i(addr_gen_0_addr_done_o),
        .addr_en_o(control_logic_0_addr_en_o),
        .addr_rst_o(control_logic_0_addr_rst_o),
        .clk_i(clk_i_0),
        .compare_en_o(control_logic_0_compare_en_o),
        .done_o(done_o_0),
        .rst_i(rst_i_0),
        .start_i(start_i_0),
        .we_o(control_logic_0_we_o));
  design_2_data_gen_0_0 data_gen_0
       (.addr_i(addr_gen_0_addr_o),
        .data_o(data_gen_0_data_o),
        .pattern_sel_i({1'b0,1'b0}));
  design_2_fault_inject_0_0 fault_inject_0
       (.addr_i(addr_gen_0_addr_o),
        .data_i(blk_mem_gen_0_doutb),
        .data_o(fault_inject_0_data_o),
        .fault_en_i(fault_en_i_0));
  design_2_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule
