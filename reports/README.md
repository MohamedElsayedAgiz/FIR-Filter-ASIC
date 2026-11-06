# Original EDA evidence and publication status

The 38 files below are genuine tool exports. All original files matched the source manifest by SHA-256. Four originals are restricted as-is under this release's privacy rules. The other 34 require permission. No report was cleared for GitHub publication. Originals and previously redacted local copies remain local.

## What authorization is missing

- **Tool and lab:** The license holder or lab administrator must identify the applicable Synopsys or Cadence agreement and confirm it allows sharing the listed raw report type on GitHub. Obtain written permission from the applicable rights holder if the agreement does not grant that use. Confirm project-owner authorization for external distribution of project results.
- **Technology:** Where indicated, the foundry or library agreement must also permit disclosure of the named library, mapped cells, path details, or technology-derived values in that file.
- **Privacy:** The four restricted originals contain a private absolute library path. Keep the originals intact. A separately authorized and clearly labeled redacted derivative would need tool, lab, project, and technology clearance.

Each row requires the tool, lab, and project authorization above. The last column describes any additional release issue. A copyright notice and the absence of a notice are both insufficient to establish publication rights.

| Source tool | Original filename within stage | Classification | Content and additional release issues |
|---|---|---|---|
| Synopsys Design Compiler | `synthesis/area.rpt` | Restricted as-is | Cell area totals; private library path and named technology library. Technology clearance required. |
| Synopsys Design Compiler | `synthesis/clocks.rpt` | Requires permission | Clock period, waveform, and attributes. |
| Synopsys Design Compiler | `synthesis/constraints.rpt` | Requires permission | Constraint-violation check. |
| Synopsys Design Compiler | `synthesis/setup.rpt` | Requires permission | Mapped timing paths and technology corner/library identifiers. Technology clearance required. |
| Synopsys Design Compiler | `synthesis/hold.rpt` | Requires permission | Mapped timing paths and technology corner/library identifiers. Technology clearance required. |
| Synopsys Design Compiler | `synthesis/power.rpt` | Restricted as-is | Synthesis-stage power breakdown; private library path and named technology library. Technology clearance required. |
| Synopsys Design Compiler scan DFT | `dft/area.rpt` | Restricted as-is | Cell area totals; private library path and named technology library. Technology clearance required. |
| Synopsys Design Compiler scan DFT | `dft/clocks.rpt` | Requires permission | Clock period, waveform, and attributes. |
| Synopsys Design Compiler scan DFT | `dft/constraints_dft.rpt` | Requires permission | Constraint-violation check. |
| Synopsys Design Compiler scan DFT | `dft/coverage_dft.rpt` | Requires permission | Scan DRC, scan-cell data, and estimated test coverage. |
| Synopsys Design Compiler scan DFT | `dft/setup_dft.rpt` | Requires permission | Mapped timing paths and technology corner/library identifiers. Technology clearance required. |
| Synopsys Design Compiler scan DFT | `dft/hold_dft.rpt` | Requires permission | Mapped timing paths and technology corner/library identifiers. Technology clearance required. |
| Synopsys Design Compiler scan DFT | `dft/power.rpt` | Restricted as-is | Synthesis-stage power breakdown; private library path and named technology library. Technology clearance required. |
| Synopsys Formality | `formality/post_synthesis/passing_points.rpt` | Requires permission | Passing compare points and design hierarchy. Confirm any mapped-point disclosure under the technology terms. |
| Synopsys Formality | `formality/post_synthesis/failing_points.rpt` | Requires permission | Failing-point check. |
| Synopsys Formality | `formality/post_synthesis/aborted_points.rpt` | Requires permission | Aborted-point check. |
| Synopsys Formality | `formality/post_synthesis/unverified_points.rpt` | Requires permission | Unverified-point check. |
| Synopsys Formality | `formality/post_dft/passing_points.rpt` | Requires permission | Passing compare points and design hierarchy. Confirm any mapped-point disclosure under the technology terms. |
| Synopsys Formality | `formality/post_dft/failing_points.rpt` | Requires permission | Failing-point check. |
| Synopsys Formality | `formality/post_dft/aborted_points.rpt` | Requires permission | Aborted-point check. |
| Synopsys Formality | `formality/post_dft/unverified_points.rpt` | Requires permission | Unverified-point check. |
| Cadence First Encounter | `encounter/worst_setup.rpt` | Requires permission | Setup path detail with mapped cells and timing values. Technology clearance required. |
| Cadence First Encounter | `encounter/worst_hold_functional.rpt` | Requires permission | Hold path detail with mapped cells and timing values. Technology clearance required. |
| Cadence First Encounter | `encounter/FIR_Filter_postCTS.summary` | Requires permission | Setup stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | `encounter/FIR_Filter_postCTS_hold.summary` | Requires permission | Hold stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | `encounter/FIR_Filter_postRoute.summary` | Requires permission | Setup stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | `encounter/FIR_Filter_postRoute_hold.summary` | Requires permission | Hold stage summary with aggregate timing/constraint results. |
| Cadence First Encounter | `encounter/FIR_Filter_postRoute_all.tarpt` | Requires permission | Setup path detail with mapped cells and timing values. Technology clearance required. |
| Cadence First Encounter | `encounter/FIR_Filter_postRoute_all_hold.tarpt` | Requires permission | Hold path detail with mapped cells and timing values. Technology clearance required. |
| Synopsys PrimeTime | `primetime/setup_timing.rpt` | Requires permission | Expanded clock and data paths with mapped cells and timing values. Technology clearance required. |
| Synopsys PrimeTime | `primetime/hold_timing.rpt` | Requires permission | Expanded clock and data paths with mapped cells and timing values. Technology clearance required. |
| Synopsys PrimeTime | `primetime/setup_check_timing.rpt` | Requires permission | Timing setup diagnostics and endpoint warnings. |
| Synopsys PrimeTime | `primetime/hold_check_timing.rpt` | Requires permission | Timing setup diagnostics and endpoint warnings. |
| Synopsys PrimeTime | `primetime/setup_parasitics.rpt` | Requires permission | Aggregate annotation counts by net category. |
| Synopsys PrimeTime | `primetime/hold_parasitics.rpt` | Requires permission | Aggregate annotation counts by net category. |
| Synopsys PrimeTime | `primetime/setup_violations.rpt` | Requires permission | Constraint violation check with slack-only report settings. |
| Synopsys PrimeTime | `primetime/hold_violations.rpt` | Requires permission | Constraint violation check with slack-only report settings. |
| Synopsys PrimeTime | `primetime/power_tt.rpt` | Requires permission | Time-based power totals and group breakdown. Confirm disclosure of technology-derived power values under the technology terms. |

See the [project results summary](../docs/RESULTS.md) for the reported metrics and the [image review](../docs/IMAGE_SELECTION.md) for screenshot decisions.
