# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.

################################ Variables ####################################

set load_fp 1
set top_module FIR_Filter

########### Define Floorplan #################################################

if {$load_fp == 0} {

    floorPlan -d 280 230 4.0 4.0 4.0 4.0

} else {

    loadFPlan ./$top_module.fp

}
