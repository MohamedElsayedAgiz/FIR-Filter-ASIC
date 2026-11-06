# Original EDA evidence and publication status

All 38 reports are genuine tool exports and are available here for private review. Twenty-four match their source bytes. Fourteen are sanitized copies. The original files remain intact locally.

## Comparison with the previous project

The [public reference reports](https://github.com/MohamedElsayedAgiz/Low-Power-Multi-Clock-Digital-System/tree/main/reports) contain 29 tool-generated reports. Synopsys Design Compiler has three synthesis and five DFT exports (area, clocks, constraints, plus coverage and power for DFT). Formality has four point lists at each of post-synthesis, post-DFT, and post-PnR. Cadence First Encounter has antenna, connectivity, geometry, setup summary, hold summary, and power reports. PrimeTime has two timing-violation reports and one time-based power report. The SpyGlass Markdown file is a review summary.

The two projects use the same Design Compiler, Formality, Encounter, and PrimeTime report versions where version headers appear. The FIR PrimeTime violation files use a constraint-report header, while the reference uses a timing-report header. No copyright or proprietary boilerplate was found in the reviewed report text. That comparison establishes format precedent only. The FIR area and synthesis-stage power originals contain private library paths, and the detailed timing files contain mapped paths or technology identifiers. The linked FIR clock, constraint, coverage, compare-point, aggregate timing, and PrimeTime exports were selected for private review.

## What authorization is missing

- **Tool and lab:** The license holder or lab administrator must identify the applicable Synopsys or Cadence agreement and confirm it allows sharing the listed raw report type on GitHub. Obtain written permission from the applicable rights holder if the agreement does not grant that use. Confirm project-owner authorization for external distribution of project results.
- **Technology:** Where indicated, the foundry or library agreement must also permit disclosure of the named library, mapped cells, path details, or technology-derived values in that file.
- **Privacy:** The four restricted originals contain a private absolute library path. Keep the originals intact. A separately authorized and clearly labeled redacted derivative would need tool, lab, project, and technology clearance.

Each row requires the tool, lab, and project authorization above before public release. Linked filenames are the original tool exports or their redacted derivatives. In timing tables, [R] marks a removed standard-cell type. Path endpoints, arcs, clock names, delay and slack columns are preserved. SS and FF operating conditions are rendered from the original identifiers when those identifiers were redacted. The [SHA-256 manifest](TOOL_REPORT_PROVENANCE.csv) records the uploaded files. The last column describes any additional release issue. A copyright notice and the absence of a notice are both insufficient to establish publication rights.

| Source tool | Original filename within stage | Classification | Content and additional release issues |
|---|---|---|---|
| Synopsys Design Compiler | [synthesis/area.rpt](tool_exports/synthesis/area.rpt) | Sanitized original; private review | absolute library path, library or operating-condition identifier. |
| Synopsys Design Compiler | [synthesis/clocks.rpt](tool_exports/synthesis/clocks.rpt) | Private copy included; public permission required | Clock period, waveform, and attributes. |
| Synopsys Design Compiler | [synthesis/constraints.rpt](tool_exports/synthesis/constraints.rpt) | Private copy included; public permission required | Constraint-violation check. |
| Synopsys Design Compiler | [synthesis/setup.rpt](tool_exports/synthesis/setup.rpt) | Sanitized original; private review | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler | [synthesis/hold.rpt](tool_exports/synthesis/hold.rpt) | Sanitized original; private review | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler | [synthesis/power.rpt](tool_exports/synthesis/power.rpt) | Sanitized original; private review | absolute library path, library or operating-condition identifier. |
| Synopsys Design Compiler scan DFT | [dft/area.rpt](tool_exports/dft/area.rpt) | Sanitized original; private review | absolute library path, library or operating-condition identifier. |
| Synopsys Design Compiler scan DFT | [dft/clocks.rpt](tool_exports/dft/clocks.rpt) | Private copy included; public permission required | Clock period, waveform, and attributes. |
| Synopsys Design Compiler scan DFT | [dft/constraints_dft.rpt](tool_exports/dft/constraints_dft.rpt) | Private copy included; public permission required | Constraint-violation check. |
| Synopsys Design Compiler scan DFT | [dft/coverage_dft.rpt](tool_exports/dft/coverage_dft.rpt) | Private copy included; public permission required | Scan DRC, scan-cell data, and estimated test coverage. |
| Synopsys Design Compiler scan DFT | [dft/setup_dft.rpt](tool_exports/dft/setup_dft.rpt) | Sanitized original; private review | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler scan DFT | [dft/hold_dft.rpt](tool_exports/dft/hold_dft.rpt) | Sanitized original; private review | library or operating-condition identifier, standard-cell type in timing rows. |
| Synopsys Design Compiler scan DFT | [dft/power.rpt](tool_exports/dft/power.rpt) | Sanitized original; private review | absolute library path, library or operating-condition identifier. |
| Synopsys Formality | [formality/post_synthesis/passing_points.rpt](tool_exports/formality/post_synthesis/passing_points.rpt) | Private copy included; public permission required | Passing compare points and design hierarchy. Confirm any mapped-point disclosure under the technology terms. |
| Synopsys Formality | [formality/post_synthesis/failing_points.rpt](tool_exports/formality/post_synthesis/failing_points.rpt) | Private copy included; public permission required | Failing-point check. |
| Synopsys Formality | [formality/post_synthesis/aborted_points.rpt](tool_exports/formality/post_synthesis/aborted_points.rpt) | Private copy included; public permission required | Aborted-point check. |
| Synopsys Formality | [formality/post_synthesis/unverified_points.rpt](tool_exports/formality/post_synthesis/unverified_points.rpt) | Private copy included; public permission required | Unverified-point check. |
| Synopsys Formality | [formality/post_dft/passing_points.rpt](tool_exports/formality/post_dft/passing_points.rpt) | Private copy included; public permission required | Passing compare points and design hierarchy. Confirm any mapped-point disclosure under the technology terms. |
| Synopsys Formality | [formality/post_dft/failing_points.rpt](tool_exports/formality/post_dft/failing_points.rpt) | Private copy included; public permission required | Failing-point check. |
| Synopsys Formality | [formality/post_dft/aborted_points.rpt](tool_exports/formality/post_dft/aborted_points.rpt) | Private copy included; public permission required | Aborted-point check. |
| Synopsys Formality | [formality/post_dft/unverified_points.rpt](tool_exports/formality/post_dft/unverified_points.rpt) | Private copy included; public permission required | Unverified-point check. |
| Cadence First Encounter | [encounter/worst_setup.rpt](tool_exports/encounter/worst_setup.rpt) | Sanitized original; private review | Encounter host field, standard-cell type in timing rows. |
| Cadence First Encounter | [encounter/worst_hold_functional.rpt](tool_exports/encounter/worst_hold_functional.rpt) | Sanitized original; private review | Encounter host field, standard-cell type in timing rows. |
| Cadence First Encounter | [encounter/FIR_Filter_postCTS.summary](tool_exports/encounter/FIR_Filter_postCTS.summary) | Private copy included; public permission required | Setup stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postCTS_hold.summary](tool_exports/encounter/FIR_Filter_postCTS_hold.summary) | Private copy included; public permission required | Hold stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute.summary](tool_exports/encounter/FIR_Filter_postRoute.summary) | Private copy included; public permission required | Setup stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute_hold.summary](tool_exports/encounter/FIR_Filter_postRoute_hold.summary) | Private copy included; public permission required | Hold stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute_all.tarpt](tool_exports/encounter/FIR_Filter_postRoute_all.tarpt) | Sanitized original; private review | Encounter host field, standard-cell type in timing rows. |
| Cadence First Encounter | [encounter/FIR_Filter_postRoute_all_hold.tarpt](tool_exports/encounter/FIR_Filter_postRoute_all_hold.tarpt) | Sanitized original; private review | Encounter host field, standard-cell type in timing rows. |
| Synopsys PrimeTime | [primetime/setup_timing.rpt](tool_exports/primetime/setup_timing.rpt) | Sanitized original; private review | standard-cell type in timing rows. |
| Synopsys PrimeTime | [primetime/hold_timing.rpt](tool_exports/primetime/hold_timing.rpt) | Sanitized original; private review | standard-cell type in timing rows. |
| Synopsys PrimeTime | [primetime/setup_check_timing.rpt](tool_exports/primetime/setup_check_timing.rpt) | Unchanged original; private review | No redactions. |
| Synopsys PrimeTime | [primetime/hold_check_timing.rpt](tool_exports/primetime/hold_check_timing.rpt) | Unchanged original; private review | No redactions. |
| Synopsys PrimeTime | [primetime/setup_parasitics.rpt](tool_exports/primetime/setup_parasitics.rpt) | Unchanged original; private review | No redactions. |
| Synopsys PrimeTime | [primetime/hold_parasitics.rpt](tool_exports/primetime/hold_parasitics.rpt) | Unchanged original; private review | No redactions. |
| Synopsys PrimeTime | [primetime/setup_violations.rpt](tool_exports/primetime/setup_violations.rpt) | Private copy included; public permission required | Constraint violation check with slack-only report settings. |
| Synopsys PrimeTime | [primetime/hold_violations.rpt](tool_exports/primetime/hold_violations.rpt) | Private copy included; public permission required | Constraint violation check with slack-only report settings. |
| Synopsys PrimeTime | [primetime/power_tt.rpt](tool_exports/primetime/power_tt.rpt) | Private copy included; public permission required | Time-based power totals and group breakdown. Confirm disclosure of technology-derived power values under the technology terms. |

See the [project results summary](../docs/RESULTS.md) for the reported metrics and the [image review](../docs/IMAGE_SELECTION.md) for screenshot decisions.
