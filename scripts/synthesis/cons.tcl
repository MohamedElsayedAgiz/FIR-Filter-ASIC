# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.


####################################################################################
# Constraints
# ----------------------------------------------------------------------------
#
# 0. Design Compiler variables
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. #set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 0 : DC Variables ####
           #########################################################
#################################################################################### 

# Prevent assign statements in the generated netlist (must be applied before compile command)
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

set REF_CLK_NAME       REF_CLK
set REF_CLK_PER        5
set REF_CLK_SETUP_SKEW 0.2
set REF_CLK_HOLD_SKEW  0.1
set REF_CLK_LAT        0
set REF_CLK_RISE       0.05
set REF_CLK_FALL       0.05


#1. Master Clocks

#REF_CLK
create_clock -name $REF_CLK_NAME -period $REF_CLK_PER -waveform "0 [expr $REF_CLK_PER/2]" [get_ports clk]
set_clock_uncertainty -setup $REF_CLK_SETUP_SKEW  [get_clocks $REF_CLK_NAME]
set_clock_uncertainty -hold  $REF_CLK_HOLD_SKEW   [get_clocks $REF_CLK_NAME]
set_clock_transition  -rise  $REF_CLK_RISE        [get_clocks $REF_CLK_NAME]
set_clock_transition  -fall  $REF_CLK_FALL        [get_clocks $REF_CLK_NAME]
set_clock_latency            $REF_CLK_LAT         [get_clocks $REF_CLK_NAME]

set_dont_touch_network [get_clocks $REF_CLK_NAME]
set_dont_touch_network [get_ports rst_n]

####################################################################################
           #########################################################
             #### Section 2 : Clocks Relationship ####
           #########################################################
####################################################################################


####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################

set in_delay  [expr 0.2*$REF_CLK_PER]
set out_delay [expr 0.2*$REF_CLK_PER]


#Constrain Input Paths
set_input_delay $in_delay      -clock REF_CLK [get_ports data_in]
set_input_delay $in_delay      -clock REF_CLK [get_ports data_valid]

#Constrain Output Paths
set_output_delay $out_delay    -clock REF_CLK [get_ports data_out]
set_output_delay $out_delay    -clock REF_CLK [get_ports out_valid]


####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library PRIVATE_SS_LIB -lib_cell PRIVATE_DRIVE_CELL -pin Y [get_ports data_in]
set_driving_cell -library PRIVATE_SS_LIB -lib_cell PRIVATE_DRIVE_CELL -pin Y [get_ports data_valid]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.1 [get_ports data_out]
set_load 0.1 [get_ports out_valid]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "PRIVATE_FF_LIB" -min "PRIVATE_FF_LIB" -max_library "PRIVATE_SS_LIB" -max "PRIVATE_SS_LIB"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################


####################################################################################
           #########################################################
                  #### Section 8 : premapped cells ####
           #########################################################
####################################################################################



####################################################################################
