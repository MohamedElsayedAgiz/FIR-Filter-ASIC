
module TOP #(
    parameter PIPELINED = 1,
    parameter SYMMETRIC = 1,  // H0 = H7 , H1 = H6 , H2 = H5 , H3 = H4
    parameter Data_Width = 16,
    parameter COEFF_WIDTH = 16,
    parameter FRAC_BITS = 15,
    parameter NUM_OF_CHAINS = 2,
    parameter OUT_WIDTH = Data_Width + COEFF_WIDTH + 3 - FRAC_BITS,
    parameter signed [COEFF_WIDTH-1:0] H0 = -132,  //-0.00401878
    parameter signed [COEFF_WIDTH-1:0] H1 = 583,  //0.01780684
    parameter signed [COEFF_WIDTH-1:0] H2 = 4934,  //0.15058760
    parameter signed [COEFF_WIDTH-1:0] H3 = 10998,  //0.33562434
    parameter signed [COEFF_WIDTH-1:0] H4 = 10998,  //0.33562434
    parameter signed [COEFF_WIDTH-1:0] H5 = 4934,  //0.15058760
    parameter signed [COEFF_WIDTH-1:0] H6 = 583,  //0.01780684
    parameter signed [COEFF_WIDTH-1:0] H7 = -132  //-0.00401878
) (

    input  wire signed [   Data_Width-1:0] data_in,
    input  wire                            data_valid,
    input  wire                            clk,
    input  wire                            rst_n,
    input              [NUM_OF_CHAINS-1:0] SI,
    input                                  SE,
    input                                  test_mode,
    input                                  scan_clk,
    input                                  scan_rst,
    
    output signed      [    OUT_WIDTH-1:0] data_out,
    output                                 out_valid,
    output             [NUM_OF_CHAINS-1:0] SO

);

  wire clk_dft, rst_dft;

  assign clk_dft = test_mode ? scan_clk : clk;
  assign rst_dft = test_mode ? scan_rst : rst_n;

  FIR_Filter #(
      .PIPELINED  (PIPELINED),
      .SYMMETRIC  (SYMMETRIC),
      .Data_Width (Data_Width),
      .COEFF_WIDTH(COEFF_WIDTH),
      .FRAC_BITS  (FRAC_BITS),
      .OUT_WIDTH  (OUT_WIDTH),
      .H0         (H0),
      .H1         (H1),
      .H2         (H2),
      .H3         (H3),
      .H4         (H4),
      .H5         (H5),
      .H6         (H6),
      .H7         (H7)
  ) U0_FIR_Filter (

      .data_in   (data_in),
      .data_valid(data_valid),
      .clk       (clk_dft),
      .rst_n     (rst_dft),
      .data_out  (data_out),
      .out_valid (out_valid)

  );

endmodule
