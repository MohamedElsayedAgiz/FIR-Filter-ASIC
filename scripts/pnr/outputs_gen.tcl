# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.


########### Reports & Netlist & GDS Generation ############

set top_module FIR_Filter

# Generate Post-PNR Gate Level Netlist
saveNetlist export/${top_module}.v 

# Generate Post-PNR Gate Level Netlist with PG Pins
saveNetlist export/${top_module}_pg.v -includePowerGround

# SPF File standard for defining netlist parasitics.
rcOut -spf export/${top_module}.spf

# Generate SPEF File for PrimeTime Parasitic Analysis 
rcOut -spef export/${top_module}.spef

# Generate SDF File
delayCal -sdf export/${top_module}.sdf -version 3.0

#report power
report_power -outfile report/power.rpt

# Generate SDC File
write_sdc export/${top_module}.sdc

# Generate GDS File
streamOut export/${top_module}.gds -mapFile ./import/gds2InLayer.map -libName DesignLib -stripes 1 -units 2000 -mode ALL
