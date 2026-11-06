# Testbench scope and limitations

- `FIR_Filter_tb.sv` exercises the RTL with `PIPELINED=1` and `SYMMETRIC=1`.
- **Important:** This testbench declares a **16-bit `data_out` wire and 16-bit expected values**. The ASIC RTL in `rtl/FIR_Filter.v` defaults to a **20-bit output**. The testbench can therefore observe only the lower 16 bits; it is **not full-width verification of the 20-bit saturation behavior**.
- The [simulation summary](../docs/images/rtl_test_summary.png) shows **85 PASS / 0 FAIL** and a reported 2-clock latency, but this does not establish comprehensive final RTL/GLS correctness.
- A full-width scoreboard, explicit saturation boundary tests, and a documented post-route GLS run remain recommended future work.
- The waveform file `VCD/FIR_postroute.vcd` and SDF/netlist are intentionally not distributed.
- Original simulator scripts (`model_run.do`/`model_wave.do`) may require updates to point to the correct directories and versions.
