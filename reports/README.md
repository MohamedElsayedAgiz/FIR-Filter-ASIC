# EDA reports

These 38 text exports document synthesis, scan DFT, formal equivalence, physical implementation, and post-route timing and power. Twenty-four are byte-identical to the originals. Fourteen preserve the original measurements, tool headers, timing status, and technical conclusions with explicit redactions.

In timing tables, [R] marks a redacted standard-cell type. Longer markers identify redacted paths, library identifiers, and host fields. Where a library identifier encoded the corner, the report retains the corner, voltage, and temperature. The [SHA-256 manifest](TOOL_REPORT_PROVENANCE.csv) identifies each file and records the redactions applied.

| Source tool | Report | Preservation | Report content or redaction |
|---|---|---|---|
| Synopsys Design Compiler | [synthesis/area.rpt](tool_exports/synthesis/area.rpt) | Sanitized original | absolute library path, library or operating-condition identifier. |
| Synopsys Design Compiler | [synthesis/clocks.rpt](tool_exports/synthesis/clocks.rpt) | Unchanged original | Clock period, waveform, and attributes. |
| Synopsys Design Compiler | [synthesis/constraints.rpt](tool_exports/synthesis/constraints.rpt) | Unchanged original | Constraint-violation check. |
| Synopsys Design Compiler | [synthesis/setup.rpt](tool_exports/synthesis/setup.rpt) | Sanitized original | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler | [synthesis/hold.rpt](tool_exports/synthesis/hold.rpt) | Sanitized original | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler | [synthesis/power.rpt](tool_exports/synthesis/power.rpt) | Sanitized original | absolute library path, library or operating-condition identifier. |
| Synopsys Design Compiler scan DFT | [dft/area.rpt](tool_exports/dft/area.rpt) | Sanitized original | absolute library path, library or operating-condition identifier. |
| Synopsys Design Compiler scan DFT | [dft/clocks.rpt](tool_exports/dft/clocks.rpt) | Unchanged original | Clock period, waveform, and attributes. |
| Synopsys Design Compiler scan DFT | [dft/constraints_dft.rpt](tool_exports/dft/constraints_dft.rpt) | Unchanged original | Constraint-violation check. |
| Synopsys Design Compiler scan DFT | [dft/coverage_dft.rpt](tool_exports/dft/coverage_dft.rpt) | Unchanged original | Scan DRC, scan-cell data, and estimated test coverage. |
| Synopsys Design Compiler scan DFT | [dft/setup_dft.rpt](tool_exports/dft/setup_dft.rpt) | Sanitized original | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler scan DFT | [dft/hold_dft.rpt](tool_exports/dft/hold_dft.rpt) | Sanitized original | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler scan DFT | [dft/power.rpt](tool_exports/dft/power.rpt) | Sanitized original | absolute library path, library or operating-condition identifier. |
| Synopsys Formality | [formality/post_synthesis/passing_points.rpt](tool_exports/formality/post_synthesis/passing_points.rpt) | Unchanged original | Passing compare points and design hierarchy. |
| Synopsys Formality | [formality/post_synthesis/failing_points.rpt](tool_exports/formality/post_synthesis/failing_points.rpt) | Unchanged original | Failing-point check. |
| Synopsys Formality | [formality/post_synthesis/aborted_points.rpt](tool_exports/formality/post_synthesis/aborted_points.rpt) | Unchanged original | Aborted-point check. |
| Synopsys Formality | [formality/post_synthesis/unverified_points.rpt](tool_exports/formality/post_synthesis/unverified_points.rpt) | Unchanged original | Unverified-point check. |
| Synopsys Formality | [formality/post_dft/passing_points.rpt](tool_exports/formality/post_dft/passing_points.rpt) | Unchanged original | Passing compare points and design hierarchy. |
| Synopsys Formality | [formality/post_dft/failing_points.rpt](tool_exports/formality/post_dft/failing_points.rpt) | Unchanged original | Failing-point check. |
| Synopsys Formality | [formality/post_dft/aborted_points.rpt](tool_exports/formality/post_dft/aborted_points.rpt) | Unchanged original | Aborted-point check. |
| Synopsys Formality | [formality/post_dft/unverified_points.rpt](tool_exports/formality/post_dft/unverified_points.rpt) | Unchanged original | Unverified-point check. |
| Cadence First Encounter | [encounter/worst_setup.rpt](tool_exports/encounter/worst_setup.rpt) | Sanitized original | Encounter host field, standard-cell type in timing rows. |
| Cadence First Encounter | [encounter/worst_hold_functional.rpt](tool_exports/encounter/worst_hold_functional.rpt) | Sanitized original | Encounter host field, standard-cell type in timing rows. |
| Cadence First Encounter | [encounter/FIR_Filter_postCTS.summary](tool_exports/encounter/FIR_Filter_postCTS.summary) | Unchanged original | Setup stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postCTS_hold.summary](tool_exports/encounter/FIR_Filter_postCTS_hold.summary) | Unchanged original | Hold stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute.summary](tool_exports/encounter/FIR_Filter_postRoute.summary) | Unchanged original | Setup stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute_hold.summary](tool_exports/encounter/FIR_Filter_postRoute_hold.summary) | Unchanged original | Hold stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute_all.tarpt](tool_exports/encounter/FIR_Filter_postRoute_all.tarpt) | Sanitized original | Encounter host field, standard-cell type in timing rows. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute_all_hold.tarpt](tool_exports/encounter/FIR_Filter_postRoute_all_hold.tarpt) | Sanitized original | Encounter host field, standard-cell type in timing rows. |
| Synopsys PrimeTime | [primetime/setup_timing.rpt](tool_exports/primetime/setup_timing.rpt) | Sanitized original | standard-cell type in timing rows. |
| Synopsys PrimeTime | [primetime/hold_timing.rpt](tool_exports/primetime/hold_timing.rpt) | Sanitized original | standard-cell type in timing rows. |
| Synopsys PrimeTime | [primetime/setup_check_timing.rpt](tool_exports/primetime/setup_check_timing.rpt) | Unchanged original | No redactions. |
| Synopsys PrimeTime | [primetime/hold_check_timing.rpt](tool_exports/primetime/hold_check_timing.rpt) | Unchanged original | No redactions. |
| Synopsys PrimeTime | [primetime/setup_parasitics.rpt](tool_exports/primetime/setup_parasitics.rpt) | Unchanged original | No redactions. |
| Synopsys PrimeTime | [primetime/hold_parasitics.rpt](tool_exports/primetime/hold_parasitics.rpt) | Unchanged original | No redactions. |
| Synopsys PrimeTime | [primetime/setup_violations.rpt](tool_exports/primetime/setup_violations.rpt) | Unchanged original | Constraint violation check with slack-only report settings. |
| Synopsys PrimeTime | [primetime/hold_violations.rpt](tool_exports/primetime/hold_violations.rpt) | Unchanged original | Constraint violation check with slack-only report settings. |
| Synopsys PrimeTime | [primetime/power_tt.rpt](tool_exports/primetime/power_tt.rpt) | Unchanged original | Time-based power totals and group breakdown. |

See the [results notes](../docs/RESULTS.md) for analysis conditions and the [simulation captures](../docs/IMAGE_SELECTION.md) for RTL verification evidence.
