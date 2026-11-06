# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.

########################################################################
# Required Files:
# 1) Post-PNR Gate-Level Netlist (.v)
# 2) Post-PNR SDC File (.sdc)
# 3) Post-Route SPEF File (.spef)
# 4) VCD Switching Activity File (.vcd)
# 5) SS Timing Library (.db)
# 6) TT Timing Library (.db)
# 7) FF Timing Library (.db)
########################################################################

set_app_var power_enable_analysis true
set_app_var power_analysis_mode time_based
set power_vcd_time_unit 1ns

#------------------------------------------------------------------------------
# Paths
#------------------------------------------------------------------------------

set NETLIST ${PRIVATE_POSTROUTE_DIR}/FIR_Filter.v

set SDC ${PRIVATE_POSTROUTE_DIR}/FIR_Filter.sdc

set SPEF ${PRIVATE_POSTROUTE_DIR}/FIR_Filter.spef

set VCD ${PRIVATE_VCD_DIR}/FIR_postroute.vcd

set LIB_DIR ${PRIVATE_LIBRARY_DIR}

set report_dir ${PRIVATE_REPORT_DIR}

file mkdir $report_dir

#------------------------------------------------------------------------------
# Design Name
#------------------------------------------------------------------------------

set TOP_MODULE [file rootname [file tail $NETLIST]]

#------------------------------------------------------------------------------
# Libraries
#------------------------------------------------------------------------------

lappend search_path $LIB_DIR

set SSLIB PRIVATE_SS_LIB.db

set TTLIB PRIVATE_TT_LIB.db

set FFLIB PRIVATE_FF_LIB.db

set SSLIB_NAME PRIVATE_SS_LIB

set TTLIB_NAME PRIVATE_TT_LIB

set FFLIB_NAME PRIVATE_FF_LIB

#------------------------------------------------------------------------------
# Generate FF and TT SDC Files
#------------------------------------------------------------------------------

set SDC_FF $report_dir/${TOP_MODULE}_FF.sdc

set SDC_TT $report_dir/${TOP_MODULE}_TT.sdc

set fin [open $SDC r]
set sdc_data [read $fin]
close $fin

set fout [open $SDC_FF w]
puts -nonewline $fout [string map [list $SSLIB_NAME $FFLIB_NAME] $sdc_data]
close $fout

set fout [open $SDC_TT w]
puts -nonewline $fout [string map [list $SSLIB_NAME $TTLIB_NAME] $sdc_data]
close $fout

#------------------------------------------------------------------------------
# Setup Timing Analysis - SS Corner
#------------------------------------------------------------------------------

set target_library [list $SSLIB]

set link_library [list * $SSLIB]

read_verilog $NETLIST

link_design $TOP_MODULE

current_design $TOP_MODULE

read_sdc $SDC

foreach port_name {SE scan_en scan_enable test_en test_enable} {
    if {[sizeof_collection [get_ports -quiet $port_name]] > 0} {
        set_case_analysis 0 [get_ports $port_name]
    }
}

foreach port_name {rst_n reset_n RST_N RESET_N reset_b RESET_B} {
    if {[sizeof_collection [get_ports -quiet $port_name]] > 0} {
        set_case_analysis 1 [get_ports $port_name]
    }
}

read_parasitics -format spef $SPEF

update_timing

check_timing > $report_dir/setup_check_timing.rpt

report_annotated_parasitics -check > $report_dir/setup_parasitics.rpt

report_timing -delay_type max -path_type full_clock_expanded -max_paths 20 -slack_lesser_than 1000 -significant_digits 4 > $report_dir/setup_timing.rpt

report_constraint -all_violators -significant_digits 4 > $report_dir/setup_violations.rpt

#------------------------------------------------------------------------------
# Hold Timing Analysis - FF Corner
#------------------------------------------------------------------------------

remove_design -all

set target_library [list $FFLIB]

set link_library [list * $FFLIB]

read_verilog $NETLIST

link_design $TOP_MODULE

current_design $TOP_MODULE

read_sdc $SDC_FF

foreach port_name {SE scan_en scan_enable test_en test_enable} {
    if {[sizeof_collection [get_ports -quiet $port_name]] > 0} {
        set_case_analysis 0 [get_ports $port_name]
    }
}

foreach port_name {rst_n reset_n RST_N RESET_N reset_b RESET_B} {
    if {[sizeof_collection [get_ports -quiet $port_name]] > 0} {
        set_case_analysis 1 [get_ports $port_name]
    }
}

read_parasitics -format spef $SPEF

update_timing

check_timing > $report_dir/hold_check_timing.rpt

report_annotated_parasitics -check > $report_dir/hold_parasitics.rpt

report_timing -delay_type min -path_type full_clock_expanded -max_paths 20 -slack_lesser_than 1000 -significant_digits 4 > $report_dir/hold_timing.rpt

report_constraint -all_violators -significant_digits 4 > $report_dir/hold_violations.rpt

#------------------------------------------------------------------------------
# Power Analysis - TT Corner
#------------------------------------------------------------------------------

remove_design -all

set target_library [list $TTLIB]

set link_library [list * $TTLIB]

read_verilog $NETLIST

link_design $TOP_MODULE

current_design $TOP_MODULE

read_sdc $SDC_TT

foreach port_name {SE scan_en scan_enable test_en test_enable} {
    if {[sizeof_collection [get_ports -quiet $port_name]] > 0} {
        set_case_analysis 0 [get_ports $port_name]
    }
}

read_parasitics -format spef $SPEF

update_timing

read_vcd -strip_path ${TOP_MODULE}_tb/DUT $VCD

update_power

report_power > $report_dir/power_tt.rpt

#------------------------------------------------------------------------------
# Finish
#------------------------------------------------------------------------------

echo "----------------------------------------"
echo "PrimeTime Analysis Finished"
echo "Top Module: $TOP_MODULE"
echo "Reports saved in:"
echo "$report_dir"
echo "----------------------------------------"

exit
