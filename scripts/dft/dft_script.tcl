# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.

########################### Define Top Module ############################

set top_module FIR_Filter

##################### Define Working Library Directory ######################

define_design_lib WORK -path ./work

############################# Formality Setup File ##########################

set_svf FIR_Filter.svf

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries          #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path ${PRIVATE_LIBRARY_DIR}
lappend search_path ${PRIVATE_RTL_DIR}

set SSLIB "PRIVATE_SS_LIB.db"
set TTLIB "PRIVATE_TT_LIB.db"
set FFLIB "PRIVATE_FF_LIB.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

######################## Reading RTL Files #################################

set file_format verilog
analyze -format verilog FIR_Filter_DFT.v
elaborate $top_module -library WORK

###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source ./cons.tcl

#################### Archirecture Scan Chains #########################
puts "###############################################"
puts "############ Configure scan chains ############"
puts "###############################################"

set_scan_configuration -clock_mixing no_mix  \
                       -style multiplexed_flip_flop \
		       -chain_count 2

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

#test_ready compile
compile_ultra -scan


################################################################### 
# Setting Test Timing Variables
################################################################### 

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0

########################## Define DFT Signals ##########################

set_dft_signal -port [get_ports SE]        -type ScanEnable  -view spec          -active_state 1   -usage scan
set_dft_signal -port [get_ports SI]        -type ScanDataIn  -view spec 
set_dft_signal -port [get_ports SO]        -type ScanDataOut -view spec
set_dft_signal -port [get_ports clk] \
               -type ScanClock \
               -view existing_dft \
               -timing {30 60}

set_dft_signal -port [get_ports rst_n] \
               -type Reset \
               -view existing_dft \
               -active_state 0

############################# Create Test Protocol #######################

create_test_protocol

###################### Pre-DFT Design Rule Checking #######################

dft_drc -verbose

############################# Preview DFT ##############################

preview_dft -show scan_summary

############################# Insert DFT ##############################

insert_dft


compile -scan -incremental


###################### Design Rule Checking #######################

dft_drc -verbose -coverage_estimate > reports/coverage_dft.rpt

##################### Close Formality Setup file ###########################

set_svf -off

#############################################################################
# Write out files
#############################################################################

write_file -format ddc     -hierarchy -output netlists/$top_module.ddc
write_file -format verilog -hierarchy -output netlists/$top_module.v
write_sdf  sdf/$top_module.sdf
write_sdc  -nosplit sdc/$top_module.sdc

####################### reporting ##########################################

report_area -hierarchy > reports/area.rpt
report_power -hierarchy > reports/power.rpt
report_timing -max_paths 100 -delay_type min -sort_by slack  > reports/hold_dft.rpt
report_timing -max_paths 100 -delay_type max -sort_by slack  > reports/setup_dft.rpt
report_clock -attributes > reports/clocks.rpt
report_constraint -all_violators > reports/constraints_dft.rpt

################# starting graphical user interface #######################

#gui_start

#exit
