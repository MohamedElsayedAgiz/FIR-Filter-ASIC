`timescale 1ns / 1ps

module FIR_Filter_tb;

  localparam DATA_WIDTH = 16;
  localparam COEFF_WIDTH = 16;
  localparam FRAC_BITS = 15;

  // Change these to test the 4 architectures
  localparam PIPELINED = 1;
  localparam SYMMETRIC = 1;

  localparam LATENCY = (PIPELINED == 0) ? 1 : (SYMMETRIC == 1) ? 2 : 3;

  localparam signed [COEFF_WIDTH-1:0] H0 = -132;
  localparam signed [COEFF_WIDTH-1:0] H1 = 583;
  localparam signed [COEFF_WIDTH-1:0] H2 = 4934;
  localparam signed [COEFF_WIDTH-1:0] H3 = 10998;
  localparam signed [COEFF_WIDTH-1:0] H4 = 10998;
  localparam signed [COEFF_WIDTH-1:0] H5 = 4934;
  localparam signed [COEFF_WIDTH-1:0] H6 = 583;
  localparam signed [COEFF_WIDTH-1:0] H7 = -132;


  logic signed [DATA_WIDTH-1:0] data_in;
  logic                         data_valid;
  logic                         clk;
  logic                         rst_n;

  wire signed  [DATA_WIDTH-1:0] data_out;
  wire                          out_valid;


  FIR_Filter #(
      .PIPELINED(PIPELINED),
      .SYMMETRIC(SYMMETRIC),
      .Data_Width(DATA_WIDTH),
      .COEFF_WIDTH(COEFF_WIDTH),
      .FRAC_BITS(FRAC_BITS),
      .H0(H0),
      .H1(H1),
      .H2(H2),
      .H3(H3),
      .H4(H4),
      .H5(H5),
      .H6(H6),
      .H7(H7)
  ) DUT (
      .data_in   (data_in),
      .data_valid(data_valid),
      .clk       (clk),
      .rst_n     (rst_n),
      .data_out  (data_out),
      .out_valid (out_valid)
  );


  //============================================================
  // Clock
  //============================================================

  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end


  //============================================================
  // Reference Model
  //============================================================

  logic signed [DATA_WIDTH-1:0] ref_delay[0:7];

  integer signed coeff[0:7];

  task automatic calculate_expected(input logic signed [DATA_WIDTH-1:0] sample,
                                    output logic signed [DATA_WIDTH-1:0] expected);

    longint signed accumulator_ref;
    integer j;

    begin

      for (j = 7; j > 0; j = j - 1) ref_delay[j] = ref_delay[j-1];

      ref_delay[0] = sample;

      accumulator_ref = 0;

      for (j = 0; j < 8; j = j + 1) accumulator_ref = accumulator_ref + (ref_delay[j] * coeff[j]);

      expected = accumulator_ref >>> FRAC_BITS;

    end

  endtask


  //============================================================
  // Expected Output Queue
  //============================================================

  typedef struct {
    logic signed [DATA_WIDTH-1:0] value;
    integer due_cycle;
  } expected_item_t;

  expected_item_t expected_queue[$];
  expected_item_t temp_item;

  logic signed [DATA_WIDTH-1:0] expected_now;

  integer cycle_count;
  integer pass_count;
  integer fail_count;


  //============================================================
  // Scoreboard
  //============================================================

  always @(posedge clk) begin

    if (!rst_n) begin

      cycle_count = 0;
      expected_queue.delete();

      for (integer k = 0; k < 8; k = k + 1) ref_delay[k] = '0;

    end else begin

      cycle_count = cycle_count + 1;

      if (data_valid) begin

        calculate_expected(data_in, expected_now);

        temp_item.value     = expected_now;
        temp_item.due_cycle = cycle_count + LATENCY;

        expected_queue.push_back(temp_item);

      end

      // Wait until DUT non-blocking assignments are updated
      #1;

      if (out_valid) begin

        if (expected_queue.size() == 0) begin

          $display("[FAIL] Cycle %0d : out_valid without expected data", cycle_count);

          fail_count = fail_count + 1;

        end else begin

          temp_item = expected_queue.pop_front();

          if (temp_item.due_cycle != cycle_count) begin

            $display("[FAIL] LATENCY : Expected cycle %0d, got cycle %0d", temp_item.due_cycle,
                     cycle_count);

            fail_count = fail_count + 1;

          end else if (data_out !== temp_item.value) begin

            $display("[FAIL] Cycle %0d : Expected = %0d, Actual = %0d", cycle_count,
                     temp_item.value, data_out);

            fail_count = fail_count + 1;

          end else begin

            $display("[PASS] Cycle %0d : Output = %0d", cycle_count, data_out);

            pass_count = pass_count + 1;

          end

        end

      end
      else if ((expected_queue.size() != 0) &&
               (expected_queue[0].due_cycle == cycle_count)) begin

        $display("[FAIL] Cycle %0d : Expected out_valid = 1", cycle_count);

        fail_count = fail_count + 1;

      end

    end

  end


  //============================================================
  // Stimulus Tasks
  //============================================================

  task automatic apply_reset;

    begin

      @(negedge clk);

      rst_n      = 1'b0;
      data_valid = 1'b0;
      data_in    = '0;

      repeat (2) @(negedge clk);

      rst_n = 1'b1;

    end

  endtask


  task automatic send_sample(input integer signed sample);

    begin

      @(negedge clk);

      data_in    = sample;
      data_valid = 1'b1;

    end

  endtask


  task automatic idle_cycle;

    begin

      @(negedge clk);

      data_in    = '0;
      data_valid = 1'b0;

    end

  endtask


  task automatic flush_pipeline;

    begin

      repeat (LATENCY + 2) idle_cycle();

    end

  endtask


  //============================================================
  // Tests
  //============================================================

  integer test_i;
  integer random_sample;

  initial begin

    $dumpfile("VCD/FIR_postroute.vcd");
    $dumpvars(0, FIR_Filter_tb);

    data_in    = '0;
    data_valid = 1'b0;
    rst_n      = 1'b0;

    pass_count = 0;
    fail_count = 0;

    coeff[0]   = H0;
    coeff[1]   = H1;
    coeff[2]   = H2;
    coeff[3]   = H3;
    coeff[4]   = H4;
    coeff[5]   = H5;
    coeff[6]   = H6;
    coeff[7]   = H7;


    //==========================================================
    // TEST 1 : IMPULSE RESPONSE
    //==========================================================

    $display("\n==========================================");
    $display("TEST 1 : IMPULSE RESPONSE");
    $display("==========================================");

    apply_reset();

    send_sample(32767);

    repeat (7) send_sample(0);

    flush_pipeline();


    //==========================================================
    // TEST 2 : POSITIVE DC
    //==========================================================

    $display("\n==========================================");
    $display("TEST 2 : POSITIVE DC");
    $display("==========================================");

    apply_reset();

    repeat (16) send_sample(1000);

    flush_pipeline();


    //==========================================================
    // TEST 3 : HIGH FREQUENCY / ALTERNATING INPUT
    //==========================================================

    $display("\n==========================================");
    $display("TEST 3 : ALTERNATING INPUT");
    $display("==========================================");

    apply_reset();

    for (test_i = 0; test_i < 16; test_i = test_i + 1) begin

      if (test_i % 2 == 0) send_sample(12000);
      else send_sample(-12000);

    end

    flush_pipeline();


    //==========================================================
    // TEST 4 : DATA_VALID GAPS
    //==========================================================

    $display("\n==========================================");
    $display("TEST 4 : DATA_VALID GAPS");
    $display("==========================================");

    apply_reset();

    send_sample(5000);

    idle_cycle();
    idle_cycle();

    send_sample(-3000);

    idle_cycle();

    send_sample(7000);

    idle_cycle();
    idle_cycle();
    idle_cycle();

    send_sample(2000);

    flush_pipeline();


    //==========================================================
    // TEST 5 : RANDOM
    //==========================================================

    $display("\n==========================================");
    $display("TEST 5 : RANDOM SAMPLES");
    $display("==========================================");

    apply_reset();

    for (test_i = 0; test_i < 50; test_i = test_i + 1) begin

      if ($urandom_range(0, 3) == 0) begin

        idle_cycle();

      end else begin

        random_sample = $urandom_range(0, 60000) - 30000;

        send_sample(random_sample);

      end

    end

    flush_pipeline();


    //==========================================================
    // FINAL RESULT
    //==========================================================

    $display("\n==========================================");
    $display("FIR FILTER TEST SUMMARY");
    $display("==========================================");
    $display("PIPELINED : %0d", PIPELINED);
    $display("SYMMETRIC : %0d", SYMMETRIC);
    $display("LATENCY   : %0d clocks", LATENCY);
    $display("PASS      : %0d", pass_count);
    $display("FAIL      : %0d", fail_count);
    $display("==========================================");

    if (fail_count == 0) $display("TEST RESULT : PASS");
    else $display("TEST RESULT : FAIL");

    #20;

    $finish;

  end

endmodule
