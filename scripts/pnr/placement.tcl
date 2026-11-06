# PUBLIC SANITIZED REFERENCE COPY — NOT AN EXECUTABLE REPRODUCTION PACKAGE
# Configure PRIVATE_* paths, replace technology placeholders with licensed library names,
# and check tool version/paths before running. No PDK or vendor models provided.


########### Placement Standard Cells - TIE High/Low -- connect VDD/VSS ############
placeDesign -inPlaceOpt -prePlaceOpt
addTieHiLo -cell PRIVATE_TIE_LOW_CELL -prefix LTIE
addTieHiLo -cell PRIVATE_TIE_HIGH_CELL -prefix HTIE
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VSS -type pgpin -pin VSS -inst *
