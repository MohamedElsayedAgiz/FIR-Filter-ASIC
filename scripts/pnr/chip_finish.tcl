# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.


set top_cell FIR_Filter

# Add Filler Cells
set filler_cell_list {PRIVATE_FILLER_CELLS}
addFiller -cell $filler_cell_list -prefix FILLER -markFixed
