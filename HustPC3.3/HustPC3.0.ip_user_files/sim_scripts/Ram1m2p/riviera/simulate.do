onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Ram1m2p -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_1 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Ram1m2p xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Ram1m2p.udo}

run -all

endsim

quit -force
