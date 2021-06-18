##############################################
# Part         - xcvu9p
# Package      - fsgd2104
# Speed grade  - -2L
# Xilinx Reference Board is VCU1525

###########################################################################

#####Constraints should be developed in the following order:
##1. Baseline constraints – Optimise Internal Paths.
##2. Add I/O constraints – Optimise entire chip.
##3. Add timing exceptions and Floorplan – Fine-tuning step.


###############################################################################

# General configuration - Do not modify
set_property CFGBVS GND                                [current_design]
set_property CONFIG_VOLTAGE 1.8                        [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true           [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN {DIV-1} [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES       [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4           [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES        [current_design]


############################################################################################
########Physical Constraints Section


#####I/O constraints are typically mandatory. 
#For example, all the design’s ports (RTL) must be assigned to physical pins (package):
#set_property PACKAGE_PIN AR22 [get_ports {led}]

set_property PACKAGE_PIN AY38 [get_ports clk_n]
set_property PACKAGE_PIN AY37 [get_ports clk_p]

set_property PACKAGE_PIN BF18 [get_ports smoke]
set_property PACKAGE_PIN BF19 [get_ports alarm]

set_property PACKAGE_PIN BC21 [get_ports temperature_0]
set_property PACKAGE_PIN BB21 [get_ports temperature_1]
set_property PACKAGE_PIN BA20 [get_ports temperature_2]
set_property PACKAGE_PIN AL20 [get_ports temperature_3]
set_property PACKAGE_PIN AT20 [get_ports temperature_4]
set_property PACKAGE_PIN AY20 [get_ports temperature_5]

set_property PACKAGE_PIN AU22 [get_ports weight_0]
set_property PACKAGE_PIN AT22 [get_ports weight_1]
set_property PACKAGE_PIN AR21 [get_ports weight_2]
set_property PACKAGE_PIN AR22 [get_ports weight_3]
set_property PACKAGE_PIN AU20 [get_ports weight_4]
set_property PACKAGE_PIN AU21 [get_ports weight_5]

set_property PACKAGE_PIN BE20 [get_ports aircon_light_0]
set_property PACKAGE_PIN BE21 [get_ports aircon_light_1]
set_property PACKAGE_PIN BD18 [get_ports aircon_light_2]
set_property PACKAGE_PIN BD19 [get_ports aircon_light_3]
set_property PACKAGE_PIN BF19 [get_ports aircon_light_4]
set_property PACKAGE_PIN BF20 [get_ports aircon_light_5]

set_property PACKAGE_PIN AV19 [get_ports order_0]
set_property PACKAGE_PIN AU19 [get_ports order_1]
set_property PACKAGE_PIN AW19 [get_ports order_2]
set_property PACKAGE_PIN AW20 [get_ports order_3]
set_property PACKAGE_PIN AT19 [get_ports order_4]
set_property PACKAGE_PIN AT20 [get_ports order_5]

#####It is also required to set the type of I/O used per port. 
#This includes both the I/O family (e.g., LVCMOS, SSTL) 
#and voltage level (e.g., 1.2V, 1.5V). For example:
#set_property IOSTANDARD LVCMOS15 [get_ports {led}]


set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_p]

set_property IOSTANDARD LVCMOS18 [get_ports smoke]
set_property IOSTANDARD LVCMOS18 [get_ports alarm]

set_property IOSTANDARD LVCMOS18 [get_ports temperature_0]
set_property IOSTANDARD LVCMOS18 [get_ports temperature_1]
set_property IOSTANDARD LVCMOS18 [get_ports temperature_2]
set_property IOSTANDARD LVCMOS18 [get_ports temperature_3]
set_property IOSTANDARD LVCMOS18 [get_ports temperature_4]
set_property IOSTANDARD LVCMOS18 [get_ports temperature_5]

set_property IOSTANDARD LVCMOS18 [get_ports weight_0]
set_property IOSTANDARD LVCMOS18 [get_ports weight_1]
set_property IOSTANDARD LVCMOS18 [get_ports weight_2]
set_property IOSTANDARD LVCMOS18 [get_ports weight_3]
set_property IOSTANDARD LVCMOS18 [get_ports weight_4]
set_property IOSTANDARD LVCMOS18 [get_ports weight_5]

set_property IOSTANDARD LVCMOS18 [get_ports aircon_light_0]
set_property IOSTANDARD LVCMOS18 [get_ports aircon_light_1]
set_property IOSTANDARD LVCMOS18 [get_ports aircon_light_2]
set_property IOSTANDARD LVCMOS18 [get_ports aircon_light_3]
set_property IOSTANDARD LVCMOS18 [get_ports aircon_light_4]
set_property IOSTANDARD LVCMOS18 [get_ports aircon_light_5]

set_property IOSTANDARD LVCMOS18 [get_ports order_0]
set_property IOSTANDARD LVCMOS18 [get_ports order_1]
set_property IOSTANDARD LVCMOS18 [get_ports order_2]
set_property IOSTANDARD LVCMOS18 [get_ports order_3]
set_property IOSTANDARD LVCMOS18 [get_ports order_4]
set_property IOSTANDARD LVCMOS18 [get_ports order_5]



#####Certain types of signals, such as reset, also require a weak pull-up or pull-down
#This is further defined in the constraints:
#set_property PULLUP true [get_ports reset_n]

#set_property PULLUP true [get_ports rst_n]




#############################################################################################################
########Timing Assertions Section
## Primary clocks
## Virtual clocks
## Generated clocks


#Hint: the timing constraints required are of the form:
#create_clock -period 10 -name <clk_name> [get_ports clk_p]
#set_clock_groups -asynchronous -group [get_clocks <clk_name> -include_generated_clocks]

#Clocks with phase offsets and different duty cycle can be created using “waveform” option:
#waveform <edges> - list of numbers representing times of successive edges. For example:
#create_clock -name sys_clk1 -period 5.0 -waveform {1.0 4.0} [get_ports clk_in1]

## Clock groups
#set_clock_groups -asynchronous –group [get_clocks –include_generated_clocks clk_oxo]  #group [get_clocks –include_generated_clocks clk_core]

#Bad approach:
create_clock -period 10 -name clk_p [get_ports {clk_p}]
#create_clock -period 10 -name clk_n -waveform {5.0 10.0} [get_ports {clk_n}]
set_clock_groups -asynchronous -group {clk_p}
#-group [get_clocks -include_generated_clocks {clk_n}]

#Better approach:
#create_generated_clock -name clk -source [get_ports {clk_p}]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks {clk}] -group [get_clocks -include_generated_clocks {clk_p}] 






## Input and output delay constraints
#Wrong delay value (e.g. 0 ns) can cause incorrect HOLD violations

#Input delay refers to data propagation from external chip 
#to input package pin of FPGA device, and relative reference board clock. 
#Use set_input_delay

#Output delay is the requirement of an external sampling source 
#and it combines data propagating from the output pin of the FPGA, 
#through the board to another device and, and a relative reference board clock. 
#Use set_output_delay

################################################################################################
########### Timing Exceptions Section
#Timing exceptions are needed when the logic behaves differently 
#than time constrainted by default.

## False paths
# set_false_path 
#Logic path in the design that should not be analysed.


## Max and Min delay
#set_max_delay, 
#set_min_delay 
#Overrides the default setup and hold constraints with user specified maximum and minimum delays.

## Multicycle paths
#set_multicycle_path 
#Number of clock cycles required to propagate data from the start to the end of a path.

## Case analysis
#set_case_analysis 
#Restricts certain signals from being propagated through the design.

## Disable timing
