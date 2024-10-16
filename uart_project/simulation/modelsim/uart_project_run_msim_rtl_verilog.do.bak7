transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/lykan/MTRX3700_Major/uart_project {C:/Users/lykan/MTRX3700_Major/uart_project/uart_tx.sv}
vlog -sv -work work +incdir+C:/Users/lykan/MTRX3700_Major/uart_project {C:/Users/lykan/MTRX3700_Major/uart_project/top_level.sv}
vlog -sv -work work +incdir+C:/Users/lykan/MTRX3700_Major/uart_project {C:/Users/lykan/MTRX3700_Major/uart_project/arduino_uart_buffer.sv}

vlog -sv -work work +incdir+C:/Users/lykan/MTRX3700_Major/uart_project {C:/Users/lykan/MTRX3700_Major/uart_project/tb_top_level.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_top_level

add wave *
view structure
view signals
run -all
