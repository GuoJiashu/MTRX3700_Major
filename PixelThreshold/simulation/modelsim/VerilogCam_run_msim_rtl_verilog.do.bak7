transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib vga
vmap vga vga
vlog -vlog01compat -work vga +incdir+C:/Users/Alienware/Documents/GitHub/MTRX3700_Assignment2/Pixel/vga/synthesis/submodules {C:/Users/Alienware/Documents/GitHub/MTRX3700_Assignment2/Pixel/vga/synthesis/submodules/vga_video_scaler_0.v}
vlog -sv -work work +incdir+C:/Users/Alienware/Documents/GitHub/MTRX3700_Assignment2/Pixel {C:/Users/Alienware/Documents/GitHub/MTRX3700_Assignment2/Pixel/pixel_filter.sv}

vlog -sv -work work +incdir+C:/Users/Alienware/Documents/GitHub/MTRX3700_Assignment2/Pixel {C:/Users/Alienware/Documents/GitHub/MTRX3700_Assignment2/Pixel/pixel_filter_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L vga -voptargs="+acc"  pixel_filter_tb

add wave *
view structure
view signals
run -all
