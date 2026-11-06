
module FIR_Filter #(
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

    input wire signed [   Data_Width-1:0] data_in,
    input wire                            data_valid,
    input wire                            clk,
    input wire                            rst_n,
    input wire        [NUM_OF_CHAINS-1:0] SI,
    input wire                            SE,

    output wire       [NUM_OF_CHAINS-1:0] SO,
    output reg signed [    OUT_WIDTH-1:0] data_out,
    output reg                            out_valid

);

  localparam N_TAPS = 8;
  localparam PRODUCT_WIDTH = COEFF_WIDTH + Data_Width;

  reg signed [Data_Width-1:0] FIR_REG[N_TAPS-1:0];

  integer i;

  always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
      for (i = 0; i < N_TAPS; i = i + 1) begin
        FIR_REG[i] <= 'd0;
      end
    end else if (data_valid) begin
      FIR_REG[N_TAPS-1] <= data_in;
      for (i = N_TAPS - 2; i >= 0; i = i - 1) begin
        FIR_REG[i] <= FIR_REG[i+1];
      end
    end

  end

  localparam ACC_WIDTH = PRODUCT_WIDTH + 3;

  localparam signed [OUT_WIDTH-1:0] MAX_VALUE = {1'b0, {(OUT_WIDTH - 1) {1'b1}}};
  localparam signed [OUT_WIDTH-1:0] MIN_VALUE = {1'b1, {(OUT_WIDTH - 1) {1'b0}}};

  generate

    if (SYMMETRIC == 0) begin

      wire signed [PRODUCT_WIDTH-1:0] product0;
      wire signed [PRODUCT_WIDTH-1:0] product1;
      wire signed [PRODUCT_WIDTH-1:0] product2;
      wire signed [PRODUCT_WIDTH-1:0] product3;
      wire signed [PRODUCT_WIDTH-1:0] product4;
      wire signed [PRODUCT_WIDTH-1:0] product5;
      wire signed [PRODUCT_WIDTH-1:0] product6;
      wire signed [PRODUCT_WIDTH-1:0] product7;

      assign product0 = FIR_REG[7] * H0;
      assign product1 = FIR_REG[6] * H1;
      assign product2 = FIR_REG[5] * H2;
      assign product3 = FIR_REG[4] * H3;
      assign product4 = FIR_REG[3] * H4;
      assign product5 = FIR_REG[2] * H5;
      assign product6 = FIR_REG[1] * H6;
      assign product7 = FIR_REG[0] * H7;

      if (PIPELINED == 0) begin

        wire signed [  PRODUCT_WIDTH:0] A_sum_0_1;
        wire signed [  PRODUCT_WIDTH:0] B_sum_2_3;
        wire signed [  PRODUCT_WIDTH:0] C_sum_4_5;
        wire signed [  PRODUCT_WIDTH:0] D_sum_6_7;

        wire signed [PRODUCT_WIDTH+1:0] A1_sum_A_B;
        wire signed [PRODUCT_WIDTH+1:0] B1_sum_C_D;

        wire signed [PRODUCT_WIDTH+2:0] accumulator;

        assign A_sum_0_1 =   {product0[PRODUCT_WIDTH-1],product0} + {product1[PRODUCT_WIDTH-1],product1};
        assign B_sum_2_3 =   {product2[PRODUCT_WIDTH-1],product2} + {product3[PRODUCT_WIDTH-1],product3};
        assign C_sum_4_5 =   {product4[PRODUCT_WIDTH-1],product4} + {product5[PRODUCT_WIDTH-1],product5};
        assign D_sum_6_7 =   {product6[PRODUCT_WIDTH-1],product6} + {product7[PRODUCT_WIDTH-1],product7};

        assign A1_sum_A_B =  {A_sum_0_1[PRODUCT_WIDTH],A_sum_0_1}   + {B_sum_2_3[PRODUCT_WIDTH],B_sum_2_3};
        assign B1_sum_C_D =  {C_sum_4_5[PRODUCT_WIDTH],C_sum_4_5}   + {D_sum_6_7[PRODUCT_WIDTH],D_sum_6_7};

        assign accumulator = {A1_sum_A_B[PRODUCT_WIDTH+1],A1_sum_A_B} + {B1_sum_C_D[PRODUCT_WIDTH+1],B1_sum_C_D};

        wire signed [ACC_WIDTH-1:0] Result;
        wire signed [ACC_WIDTH-1:0] MAX_VALUE_EXT;
        wire signed [ACC_WIDTH-1:0] MIN_VALUE_EXT;

        assign Result        = accumulator >>> FRAC_BITS;
        assign MAX_VALUE_EXT = MAX_VALUE;
        assign MIN_VALUE_EXT = MIN_VALUE;

        always @(posedge clk or negedge rst_n) begin
          if (!rst_n) begin
            data_out <= 'd0;
          end else begin
            if (Result > MAX_VALUE_EXT) data_out <= MAX_VALUE;
            else if (Result < MIN_VALUE_EXT) data_out <= MIN_VALUE;
            else data_out <= Result[OUT_WIDTH-1:0];
          end
        end

        reg valid_pipe;

        always @(posedge clk or negedge rst_n) begin
          if (!rst_n) begin
            valid_pipe <= 'd0;
            out_valid  <= 'd0;
          end else begin
            valid_pipe <= data_valid;
            out_valid  <= valid_pipe;
          end
        end
      end else begin

        reg signed [PRODUCT_WIDTH:0] A_sum_0_1;
        reg signed [PRODUCT_WIDTH:0] B_sum_2_3;
        reg signed [PRODUCT_WIDTH:0] C_sum_4_5;
        reg signed [PRODUCT_WIDTH:0] D_sum_6_7;

        reg signed [PRODUCT_WIDTH+1:0] A1_sum_A_B;
        reg signed [PRODUCT_WIDTH+1:0] B1_sum_C_D;

        wire signed [PRODUCT_WIDTH+2:0] Final_Sum;

        wire signed [ACC_WIDTH-1:0] Result;
        wire signed [ACC_WIDTH-1:0] MAX_VALUE_EXT;
        wire signed [ACC_WIDTH-1:0] MIN_VALUE_EXT;

        assign Result        = Final_Sum >>> FRAC_BITS;
        assign MAX_VALUE_EXT = MAX_VALUE;
        assign MIN_VALUE_EXT = MIN_VALUE;

        always @(posedge clk or negedge rst_n) begin

          if (!rst_n) begin
            A_sum_0_1  <= 'd0;
            B_sum_2_3  <= 'd0;
            C_sum_4_5  <= 'd0;
            D_sum_6_7  <= 'd0;
            A1_sum_A_B <= 'd0;
            B1_sum_C_D <= 'd0;
            data_out   <= 'd0;
          end else begin
            A_sum_0_1 <= {product0[PRODUCT_WIDTH-1], product0} + {product1[PRODUCT_WIDTH-1], product1};
            B_sum_2_3 <= {product2[PRODUCT_WIDTH-1], product2} + {product3[PRODUCT_WIDTH-1], product3};
            C_sum_4_5 <= {product4[PRODUCT_WIDTH-1], product4} + {product5[PRODUCT_WIDTH-1], product5};
            D_sum_6_7 <= {product6[PRODUCT_WIDTH-1], product6} + {product7[PRODUCT_WIDTH-1], product7};

            A1_sum_A_B <= {A_sum_0_1[PRODUCT_WIDTH],A_sum_0_1} + {B_sum_2_3[PRODUCT_WIDTH],B_sum_2_3};
            B1_sum_C_D <= {C_sum_4_5[PRODUCT_WIDTH],C_sum_4_5} + {D_sum_6_7[PRODUCT_WIDTH],D_sum_6_7};

            if (Result > MAX_VALUE_EXT) data_out <= MAX_VALUE;
            else if (Result < MIN_VALUE_EXT) data_out <= MIN_VALUE;
            else data_out <= Result[OUT_WIDTH-1:0];
          end

        end

        assign Final_Sum = ({A1_sum_A_B[PRODUCT_WIDTH+1],A1_sum_A_B} + {B1_sum_C_D[PRODUCT_WIDTH+1],B1_sum_C_D});

        reg [2:0] valid_pipe;

        always @(posedge clk or negedge rst_n) begin
          if (!rst_n) begin
            valid_pipe <= 'd0;
            out_valid  <= 'd0;
          end else begin
            valid_pipe <= {valid_pipe[1:0], data_valid};
            out_valid  <= valid_pipe[2];
          end
        end
      end
    end else begin

      wire signed [PRODUCT_WIDTH:0] product0;
      wire signed [PRODUCT_WIDTH:0] product1;
      wire signed [PRODUCT_WIDTH:0] product2;
      wire signed [PRODUCT_WIDTH:0] product3;

      wire signed [Data_Width:0] pre_sum0;
      wire signed [Data_Width:0] pre_sum1;
      wire signed [Data_Width:0] pre_sum2;
      wire signed [Data_Width:0] pre_sum3;
      /*
      assign pre_sum0 = ({FIR_REG[7][Data_Width-1:0],FIR_REG[7]} + {FIR_REG[0][Data_Width-1:0],FIR_REG[0]});
      assign pre_sum1 = ({FIR_REG[6][Data_Width-1:0],FIR_REG[6]} + {FIR_REG[1][Data_Width-1:0],FIR_REG[1]});
      assign pre_sum2 = ({FIR_REG[5][Data_Width-1:0],FIR_REG[5]} + {FIR_REG[2][Data_Width-1:0],FIR_REG[2]});
      assign pre_sum3 = ({FIR_REG[4][Data_Width-1:0],FIR_REG[4]} + {FIR_REG[3][Data_Width-1:0],FIR_REG[3]});
*/

      assign pre_sum0 = ({FIR_REG[7][Data_Width-1],FIR_REG[7]} + {FIR_REG[0][Data_Width-1],FIR_REG[0]});
      assign pre_sum1 = ({FIR_REG[6][Data_Width-1],FIR_REG[6]} + {FIR_REG[1][Data_Width-1],FIR_REG[1]});
      assign pre_sum2 = ({FIR_REG[5][Data_Width-1],FIR_REG[5]} + {FIR_REG[2][Data_Width-1],FIR_REG[2]});
      assign pre_sum3 = ({FIR_REG[4][Data_Width-1],FIR_REG[4]} + {FIR_REG[3][Data_Width-1],FIR_REG[3]});

      assign product0 = pre_sum0 * H0;
      assign product1 = pre_sum1 * H1;
      assign product2 = pre_sum2 * H2;
      assign product3 = pre_sum3 * H3;

      if (PIPELINED == 0) begin
        wire signed [PRODUCT_WIDTH+1:0] A_sum_0_1;
        wire signed [PRODUCT_WIDTH+1:0] B_sum_2_3;

        wire signed [PRODUCT_WIDTH+2:0] accumulator;

        assign A_sum_0_1 =   {product0[PRODUCT_WIDTH],product0} + {product1[PRODUCT_WIDTH],product1};
        assign B_sum_2_3 =   {product2[PRODUCT_WIDTH],product2} + {product3[PRODUCT_WIDTH],product3};

        assign accumulator =  {A_sum_0_1[PRODUCT_WIDTH+1],A_sum_0_1}   + {B_sum_2_3[PRODUCT_WIDTH+1],B_sum_2_3};

        wire signed [ACC_WIDTH-1:0] Result;
        wire signed [ACC_WIDTH-1:0] MAX_VALUE_EXT;
        wire signed [ACC_WIDTH-1:0] MIN_VALUE_EXT;

        assign Result        = accumulator >>> FRAC_BITS;
        assign MAX_VALUE_EXT = MAX_VALUE;
        assign MIN_VALUE_EXT = MIN_VALUE;

        always @(posedge clk or negedge rst_n) begin
          if (!rst_n) begin
            data_out <= 'd0;
          end else begin
            if (Result > MAX_VALUE_EXT) data_out <= MAX_VALUE;
            else if (Result < MIN_VALUE_EXT) data_out <= MIN_VALUE;
            else data_out <= Result[OUT_WIDTH-1:0];
          end
        end

        reg valid_pipe;

        always @(posedge clk or negedge rst_n) begin
          if (!rst_n) begin
            valid_pipe <= 'd0;
            out_valid  <= 'd0;
          end else begin
            valid_pipe <= data_valid;
            out_valid  <= valid_pipe;
          end
        end
      end else begin
        reg signed [PRODUCT_WIDTH+1:0] A_sum_0_1;
        reg signed [PRODUCT_WIDTH+1:0] B_sum_2_3;

        wire signed [PRODUCT_WIDTH+2:0] Final_Sum;

        wire signed [ACC_WIDTH-1:0] Result;
        wire signed [ACC_WIDTH-1:0] MAX_VALUE_EXT;
        wire signed [ACC_WIDTH-1:0] MIN_VALUE_EXT;

        assign Result        = Final_Sum >>> FRAC_BITS;
        assign MAX_VALUE_EXT = MAX_VALUE;
        assign MIN_VALUE_EXT = MIN_VALUE;

        always @(posedge clk or negedge rst_n) begin

          if (!rst_n) begin
            A_sum_0_1 <= 'd0;
            B_sum_2_3 <= 'd0;
            data_out  <= 'd0;
          end else begin
            A_sum_0_1 <= {product0[PRODUCT_WIDTH], product0} + {product1[PRODUCT_WIDTH], product1};
            B_sum_2_3 <= {product2[PRODUCT_WIDTH], product2} + {product3[PRODUCT_WIDTH], product3};

            if (Result > MAX_VALUE_EXT) data_out <= MAX_VALUE;
            else if (Result < MIN_VALUE_EXT) data_out <= MIN_VALUE;
            else data_out <= Result[OUT_WIDTH-1:0];
          end

        end

        assign Final_Sum = ({A_sum_0_1[PRODUCT_WIDTH+1],A_sum_0_1} + {B_sum_2_3[PRODUCT_WIDTH+1],B_sum_2_3});

        reg [1:0] valid_pipe;

        always @(posedge clk or negedge rst_n) begin
          if (!rst_n) begin
            valid_pipe <= 'd0;
            out_valid  <= 'd0;
          end else begin
            valid_pipe <= {valid_pipe[0], data_valid};
            out_valid  <= valid_pipe[1];
          end
        end
      end

    end

  endgenerate

endmodule
