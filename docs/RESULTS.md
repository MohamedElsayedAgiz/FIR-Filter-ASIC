# Results summary

These values describe the completed implementation at the recorded operating conditions. The [EDA report index](../reports/README.md) links to the published tool exports.

## Post-layout timing and correlation

| Analysis | Tool / corner | Reported WNS | Status |
|---|---|---:|---|
| Setup | Synopsys PrimeTime / SS, 1.08 V, 125°C, extracted SPEF | **+0.0516 ns** | MET |
| Setup | Cadence Encounter / corresponding late analysis | **+0.049 ns** | MET |
| Functional hold | Synopsys PrimeTime / FF, 1.32 V, −40°C, extracted SPEF | **+0.0987 ns** | MET |
| Functional hold | Cadence Encounter / corresponding early analysis | **+0.099 ns** | MET |

Absolute WNS difference: **2.6 ps** setup; **0.3 ps** functional hold. Functional PrimeTime hold used scan enable held low and reset inactive. These are **separate SS/FF practical timing runs, not a comprehensive MMMC/RC corner signoff**.

- Clock target: **3.5 ns** (approximately **285.7 MHz**).
- PrimeTime worst setup path: `FIR_REG_reg[4][15]` → `genblk1.genblk1.B_sum_2_3_reg[27]`.
- PrimeTime worst functional hold path: `FIR_REG_reg[2][15]` → `FIR_REG_reg[1][15]`.

## DFT and formal

| Measure | Evidence |
|---|---|
| Scan chains requested | 2 (scan insertion configuration) |
| DFT DRC violations | **0** (DFT coverage report) |
| Sequential cells | 207 |
| Valid scan cells | 205 |
| Non-scan shift-register cells | 2 (`out_valid_reg`, `valid_pipe_reg[1]`) |
| RTL vs post-synthesis | Formality `Verification SUCCEEDED` |
| Functional RTL vs scan-inserted netlist | Formality `Verification SUCCEEDED` with `SE=0` |

The [coverage_dft.rpt](../reports/tool_exports/dft/coverage_dft.rpt) reports **99.77% test coverage** from a tool-internal coverage-estimation phase that references deterministic ATPG. This does **not** establish a separate ATPG implementation, released test pattern set, silicon testing, or MBIST. Functional formal checking does not prove scan shifting behavior.

## Synthesis stage versus scan-ready synthesis

| Metric | Non-DFT synthesis report | DFT-stage synthesis report |
|---|---:|---:|
| Ports | 40 | 45 |
| Total cells | 1,588 | 2,550 |
| Combinational cells | 1,381 | 2,343 |
| Sequential cells | 207 | 207 |
| Total standard-cell area | 21,765.419995 µm² | **39,221.765051 µm²** |

Neither area should be labeled final post-layout core area or post-layout die area. The early synthesis script uses a **5 ns** timing constraint; post-layout timing is evaluated at **3.5 ns**.

## Physical implementation

| Check | Reported final value |
|---|---:|
| Geometry violations | 0 |
| Connectivity violations | 0 |
| Antenna violations | 0 |
| Filler gaps | 0 |

Original project summary reports a floorplanning command `floorPlan -d 280 230 4.0 4.0 4.0 4.0`; reported stage density post-route was approximately 83.507%. Filler occupancy reaching 100% must **not** be called 100% functional-cell utilization. These checks do not automatically imply foundry-certified DRC/LVS signoff.

## Time-based power analysis

| Item | Value |
|---|---:|
| Corner | TT, 1.2 V, 25°C |
| Activity / parasitics | VCD / extracted SPEF |
| **Total power** | **7.943 mW** |
| Peak power | 74.3 mW |
| Peak time | 422.349 ns |
| Clock network | 3.600 mW |
| Registers | 0.6932 mW |
| Combinational | 3.650 mW |
| Net switching | 2.785 mW |
| Cell internal | 5.141 mW |
| Leakage | 0.01674 mW |

The peak is an instantaneous sample; do not confuse it with the total reported power. Total power is simulation-activity-dependent, not a universally measured silicon power value.

## Functional simulation evidence

The screenshot `docs/images/rtl_test_summary.png` reports 85 passing checks, zero failures, and 2-cycle latency for `PIPELINED=1`, `SYMMETRIC=1`. **Do not interpret that screenshot as a post-route GLS PASS report.** The provided testbench's 16-bit output observation is narrower than the 20-bit final ASIC RTL port.

## Source record

- Clock period and setup WNS come from PrimeTime [setup_timing.rpt](../reports/tool_exports/primetime/setup_timing.rpt). Functional hold WNS comes from PrimeTime [hold_timing.rpt](../reports/tool_exports/primetime/hold_timing.rpt).
- Total and peak power come from PrimeTime [power_tt.rpt](../reports/tool_exports/primetime/power_tt.rpt).
- The two-chain configuration comes from [the DFT script](../scripts/dft/dft_script.tcl). DFT rule checks and coverage are recorded in the [coverage_dft.rpt](../reports/tool_exports/dft/coverage_dft.rpt).
- The correlated timing checks come from Encounter [worst_setup.rpt](../reports/tool_exports/encounter/worst_setup.rpt) and [worst_hold_functional.rpt](../reports/tool_exports/encounter/worst_hold_functional.rpt). The physical check counts above were reported in the project summary.
- The Formality point reports cover the [post-synthesis](../reports/tool_exports/formality/post_synthesis/passing_points.rpt) and [post-DFT](../reports/tool_exports/formality/post_dft/passing_points.rpt) comparisons. The project records verification success in the corresponding application logs.

PrimeTime also reported two unconstrained maximum-delay endpoints, two ports without driving cells, and 14 unannotated driverless nets. The timing results are limited to the documented checks and modes.
