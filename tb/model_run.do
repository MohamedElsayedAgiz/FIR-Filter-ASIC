vlog FIR_Filter.v
vlog -sv FIR_Filter_tb.sv
vsim work.FIR_Filter_tb
do wave.do
run -all