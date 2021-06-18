set design "Ex9"
set top top
set device xcvu9p-fsgd2104-2L-e
set proj_dir ./project
set repo_dir ./ip_repo
set project_constraints constraints.xdc

set test_name "test"

# Build project.
create_project -name ${design} -force -dir "." -part ${device}
set_property source_mgmt_mode DisplayOnly [current_project]  
set_property top ${top} [current_fileset]
puts "Creating Project"

create_fileset -constrset -quiet constraints
add_files -fileset constraints -norecurse ${project_constraints}
set_property is_enabled true [get_files ${project_constraints}]

# Add IPs

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name bram_lights
set_property -dict [list CONFIG.Component_Name {bram_lights} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Write_Width_A {6} CONFIG.Write_Depth_A {4} CONFIG.Read_Width_A {6} CONFIG.Write_Width_B {6} CONFIG.Read_Width_B {6} CONFIG.Load_Init_File {true} CONFIG.Coe_File {/home/centos/CWM-ECAD/Ex9/mem_lights.coe}] [get_ips bram_lights]
reset_target all [get_ips bram_lights]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name bram_order
set_property -dict [list CONFIG.Component_Name {bram_order} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Write_Width_A {6} CONFIG.Write_Depth_A {8} CONFIG.Read_Width_A {6} CONFIG.Write_Width_B {6} CONFIG.Read_Width_B {6} CONFIG.Load_Init_File {true} CONFIG.Coe_File {/home/centos/CWM-ECAD/Ex9/mem_order.coe}] [get_ips bram_order]
reset_target all [get_ips bram_order]


read_verilog "aircon.v"
read_verilog "rgb_converter.v"
read_verilog "select_light.v"

read_verilog "smoke_detector.v"

read_verilog "fridge.v"
read_verilog "shopping_list.v"
read_verilog "select_order.v"

read_verilog "top.v"
read_verilog "top_tb.v"


update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

#Setting Synthesis options
create_run -flow {Vivado Synthesis 2019} synth
set_property write_incremental_synth_checkpoint true [get_runs synth_1]
set_property AUTO_INCREMENTAL_CHECKPOINT 1 [get_runs synth_1]
set_property constrset constraints [get_runs synth_1]

#Setting Implementation options
create_run impl -parent_run synth -flow {Vivado Implementation 2019} 
set_property strategy Performance_Explore [get_runs impl_1]
set_property steps.phys_opt_design.is_enabled true [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]
set_property STEPS.PLACE_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]
## This is a simple design, can set to false
#set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.is_enabled true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.is_enabled false [get_runs impl_1]

set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]
set_property constrset constraints [get_runs impl_1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
launch_runs synth
wait_on_run synth
launch_runs impl_1
wait_on_run impl_1
## Usually we need the following steps, but we currently don't use the FPGA
## And it saves a lot of time
#open_checkpoint ${design}.runs/impl_1/top_postroute_physopt.dcp
#write_bitstream -force ${design}.bit
exit

