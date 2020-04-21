onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ROM8k_opt

do {wave.do}

view wave
view structure
view signals

do {ROM8k.udo}

run -all

quit -force
