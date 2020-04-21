# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7k325tffg676-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.cache/wt [current_project]
set_property parent.project_path E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo e:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM.xci
set_property used_in_implementation false [get_files -all e:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.runs/InterruptManageROM_synth_1 -new_name InterruptManageROM -ip [get_ips InterruptManageROM]]

if { $cached_ip eq {} } {
close [open __synthesis_is_running__ w]

synth_design -top InterruptManageROM -part xc7k325tffg676-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
# disable binary constraint mode for IPCache checkpoints
set_param constraints.enableBinaryConstraints false

catch {
 write_checkpoint -force -noxdef -rename_prefix InterruptManageROM_ InterruptManageROM.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ InterruptManageROM_stub.v
 lappend ipCachedFiles InterruptManageROM_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ InterruptManageROM_stub.vhdl
 lappend ipCachedFiles InterruptManageROM_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ InterruptManageROM_sim_netlist.v
 lappend ipCachedFiles InterruptManageROM_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ InterruptManageROM_sim_netlist.vhdl
 lappend ipCachedFiles InterruptManageROM_sim_netlist.vhdl
set TIME_taken [expr [clock seconds] - $TIME_start]

 config_ip_cache -add -dcp InterruptManageROM.dcp -move_files $ipCachedFiles -use_project_ipc  -synth_runtime $TIME_taken  -ip [get_ips InterruptManageROM]
}

rename_ref -prefix_all InterruptManageROM_

# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef InterruptManageROM.dcp
create_report "InterruptManageROM_synth_1_synth_report_utilization_0" "report_utilization -file InterruptManageROM_utilization_synth.rpt -pb InterruptManageROM_utilization_synth.pb"

if { [catch {
  file copy -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.runs/InterruptManageROM_synth_1/InterruptManageROM.dcp E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.runs/InterruptManageROM_synth_1/InterruptManageROM.dcp E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.runs/InterruptManageROM_synth_1/InterruptManageROM_stub.v E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.runs/InterruptManageROM_synth_1/InterruptManageROM_stub.vhdl E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.runs/InterruptManageROM_synth_1/InterruptManageROM_sim_netlist.v E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.runs/InterruptManageROM_synth_1/InterruptManageROM_sim_netlist.vhdl E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.ip_user_files/ip/InterruptManageROM]} {
  catch { 
    file copy -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_stub.v E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.ip_user_files/ip/InterruptManageROM
  }
}

if {[file isdir E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.ip_user_files/ip/InterruptManageROM]} {
  catch { 
    file copy -force E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.srcs/sources_1/ip/InterruptManageROM/InterruptManageROM_stub.vhdl E:/works/AsmandInterface/HustPC3.2/HustPC3.2/HustPC3.0.ip_user_files/ip/InterruptManageROM
  }
}
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
