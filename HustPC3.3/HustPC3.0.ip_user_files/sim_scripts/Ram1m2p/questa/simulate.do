onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Ram1m2p_opt

do {wave.do}

view wave
view structure
view signals

do {Ram1m2p.udo}

run -all

quit -force
