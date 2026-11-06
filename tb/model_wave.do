onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Interface /FIR_Filter_tb/clk
add wave -noupdate -expand -group Interface /FIR_Filter_tb/rst_n
add wave -noupdate -expand -group Interface /FIR_Filter_tb/data_valid
add wave -noupdate -expand -group Interface /FIR_Filter_tb/data_in
add wave -noupdate -expand -group Interface /FIR_Filter_tb/data_out
add wave -noupdate -expand -group Interface /FIR_Filter_tb/out_valid
add wave -noupdate -expand -group Product -color Cyan -itemcolor Cyan /FIR_Filter_tb/DUT/genblk1/product0
add wave -noupdate -expand -group Product -color Cyan -itemcolor Cyan /FIR_Filter_tb/DUT/genblk1/product1
add wave -noupdate -expand -group Product -color Cyan -itemcolor Cyan /FIR_Filter_tb/DUT/genblk1/product2
add wave -noupdate -expand -group Product -color Cyan -itemcolor Cyan /FIR_Filter_tb/DUT/genblk1/product3
add wave -noupdate -expand -group Sum -color Magenta -itemcolor Black /FIR_Filter_tb/DUT/genblk1/pre_sum0
add wave -noupdate -expand -group Sum -color Magenta -itemcolor Black /FIR_Filter_tb/DUT/genblk1/pre_sum1
add wave -noupdate -expand -group Sum -color Magenta -itemcolor Black /FIR_Filter_tb/DUT/genblk1/pre_sum2
add wave -noupdate -expand -group Sum -color Magenta -itemcolor Black /FIR_Filter_tb/DUT/genblk1/pre_sum3
add wave -noupdate -expand -group Sum -color Magenta -itemcolor Black /FIR_Filter_tb/DUT/genblk1/genblk1/A_sum_0_1
add wave -noupdate -expand -group Sum -color Magenta -itemcolor Black /FIR_Filter_tb/DUT/genblk1/genblk1/B_sum_2_3
add wave -noupdate -expand -group Sum -color Magenta -itemcolor Black /FIR_Filter_tb/DUT/genblk1/genblk1/Final_Sum
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 122
configure wave -valuecolwidth 81
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1438500 ps}
