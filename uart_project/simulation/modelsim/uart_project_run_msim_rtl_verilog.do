transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib uart
vmap uart uart
vlog -vlog01compat -work uart +incdir+C:/Users/lykan/MTRX3700_Major/uart_project/uart/synthesis/submodules {C:/Users/lykan/MTRX3700_Major/uart_project/uart/synthesis/submodules/uart_rs232_0.v}
vlog -sv -work work +incdir+C:/Users/lykan/MTRX3700_Major/uart_project {C:/Users/lykan/MTRX3700_Major/uart_project/arduino_uart_buffer.sv}
vlog -sv -work work +incdir+C:/Users/lykan/MTRX3700_Major/uart_project {C:/Users/lykan/MTRX3700_Major/uart_project/top_level.sv}

vlog -sv -work work +incdir+C:/Users/lykan/MTRX3700_Major/uart_project {C:/Users/lykan/MTRX3700_Major/uart_project/arduino_uart_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L uart -voptargs="+acc"  arduino_uart_tb

add wave *
view structure
view signals
run -all
