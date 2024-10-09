set_global_assignment -entity "uartip" -library "lib_uartip" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "uartip" -library "lib_uartip" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "uartip" -library "lib_uartip" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_uartip" -name SPD_FILE [file join $::quartus(sip_path) "../uartip.spd"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "../../uartip.qsys"]

set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "uartip.v"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_rs232_counters.v"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_rs232_in_deserializer.v"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_rs232_out_serializer.v"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_sync_fifo.v"]
set_global_assignment -library "lib_uartip" -name MISC_FILE [file join $::quartus(sip_path) "submodules/uartip_rs232_0.v"]
