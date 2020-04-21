onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ZBMem_opt

do {wave.do}

view wave
view structure
view signals

do {ZBMem.udo}

run -all

quit -force
