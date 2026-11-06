# Rights and publication policy

This repository is prepared for private review. Obtain the applicable project owner, co-author, lab, tool, and foundry permissions before making the repository public or distributing additional artifacts. The [license notice](LICENSE) reserves applicable rights.

## Included scope

- Authored Verilog, a SystemVerilog testbench, and simulator command files.
- Sanitized reference Tcl and documentation. Private paths, library names, and technology cell identifiers use placeholders in the release copies.
- Project cover graphic and selected functional simulation captures.
- Project results summary and 20 byte-identical EDA exports for private review, listed in the [EDA report source index](reports/README.md). Public redistribution clearance remains pending.

## Local-only material

- The 18 withheld EDA exports listed in the report index. Copyright and license notices must be preserved.
- Mapped synthesis and DFT schematics, the routed layout screenshot, and full application screenshots with account or machine information.
- PDKs, foundry process data, standard-cell models and libraries, mapped netlists, generated SDC, logs, SDF, SPEF, VCD, design databases, and physical exports such as GDS and DEF.
- Internal publication drafts and checklists.

## Release checks

Run `python tools/check_public_release.py` and inspect the exact Git tree before pushing. Review each image visually for private information and third-party material. The automated check screens file types, selected paths, and known text patterns. Legal permission and pixel review require separate review. Keep excluded material outside the uploaded tree and Git history.
