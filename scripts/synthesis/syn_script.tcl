# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.


########################### Define Top Module ############################

set top_module FIR_Filter

##################### Define Working Library Directory ######################

define_design_lib WORK -path ./work

############################# Formality Setup File ##########################

set_svf $top_module.svf

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
analyze -format verilog  FIR_Filter.v

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

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile_ultra 

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
report_timing -delay_type max -max_paths 100 > reports/setup.rpt
report_timing -delay_type min -max_paths 100 > reports/hold.rpt
report_clock -attributes > reports/clocks.rpt
report_constraint -all_violators -nosplit > reports/constraints.rpt

################# starting graphical user interface #######################

#gui_start

#exit
