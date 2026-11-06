# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.

########################### Define Top Module ############################

set top_module FIR_Filter

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "../../DFT/FIR_Filter.svf"

set SSLIB "${PRIVATE_LIBRARY_DIR}/PRIVATE_SS_LIB.db"
set TTLIB "${PRIVATE_LIBRARY_DIR}/PRIVATE_TT_LIB.db"
set FFLIB "${PRIVATE_LIBRARY_DIR}/PRIVATE_FF_LIB.db"

######################### Reference Container ############################

## Read Reference technology libraries

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

## Read Reference Design Files

read_verilog -container Ref "${PRIVATE_RTL_DIR}/FIR_Filter_DFT.v"

## set the top Reference Design 

set_reference_design FIR_Filter
set_top FIR_Filter

######################## Implementation Container #########################

## Read Implementation technology libraries

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

## Read Implementation Design Files

read_verilog -container Imp "${PRIVATE_PROJECT_DIR}/DFT/netlists/FIR_Filter.v"

## set the top Implementation Design

set_implementation_design FIR_Filter
set_top FIR_Filter

############################### Don't verify #################################

# do not verify scan output ports as compare points
# because they are connected by DFT insertion

set_dont_verify_point -type port {Ref:/WORK/FIR_Filter/SO[1]}
set_dont_verify_point -type port {Ref:/WORK/FIR_Filter/SO[0]}

############################### constants #####################################

# scan_enable = 0 during functional formal compare

set_constant Ref:/WORK/FIR_Filter/SE 0
set_constant Imp:/WORK/FIR_Filter/SE 0

########################### matching Compare points ##########################

match

################################# verify #####################################

set successful [verify]

if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points    > "reports/passing_points.rpt"
report_failing_points    > "reports/failing_points.rpt"
report_aborted_points    > "reports/aborted_points.rpt"
report_unverified_points > "reports/unverified_points.rpt"

start_gui
