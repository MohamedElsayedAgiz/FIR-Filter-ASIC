# Constraints provenance

- Final *post-route* clock target is **3.5 ns** as documented in the final results.
- `scripts/dft/cons.tcl` defines a **3.5 ns** clock for the DFT stage.
- `scripts/synthesis/cons.tcl` defines a **5 ns** clock: it is an earlier synthesis-stage constraint and **must not be mistaken for final STA constraints**.
- Vendor-generated SDC exports and technology library paths are **not published**. The final post-route timing settings are described in `docs/RESULTS.md`.
- The sanitized scripts are study references and need an authorized local technology setup before execution.
