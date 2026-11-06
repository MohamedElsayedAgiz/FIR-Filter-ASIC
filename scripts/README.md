# Scripts and reproducibility limitations

These reference scripts document the FIR implementation flow. The sanitized versions have not been rerun with EDA tools. Tool commands and corner labels are preserved for educational reference where possible, but private paths/library identifiers were replaced with `PRIVATE_*` placeholders.

To reproduce the physical results, an authorized user needs their own access to compatible tools and PDK/standard-cell timing, physical, and simulation libraries, plus scan/netlist/SDC/SPEF inputs. The repository excludes these inputs. The `scripts/synthesis/cons.tcl` file is from a **5 ns synthesis stage**, whereas the published post-layout STA target is **3.5 ns**.

Formal scripts reference private post-synthesis/post-DFT netlists, libraries and SVF files that are intentionally not distributed. PnR scripts reference stage databases/cell names and technology inputs not present here. The post-route GLS simulator script references licensed cell simulation models that are not distributed.
