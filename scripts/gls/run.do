# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.

vlib work
vmap work

# Compile Standard Cell Library
vlog -sv ${PRIVATE_LIBRARY_DIR}/PRIVATE_STD_CELL_MODELS.v

# Compile Post-PnR Netlist
vlog -sv ${PRIVATE_POSTROUTE_DIR}/FIR_Filter.v

# Compile Testbench
vlog -sv tb.v

# Start Post-Route GLS + SDF
vsim -sdfmax /FIR_Filter_tb/DUT=${PRIVATE_POSTROUTE_DIR}/FIR_Filter.sdf \
     -sdfnoerror work.FIR_Filter_tb

run -all
