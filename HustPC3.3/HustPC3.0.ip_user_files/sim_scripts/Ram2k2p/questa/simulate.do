onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Ram2k2p_opt

do {wave.do}

view wave
view structure
view signals

do {Ram2k2p.udo}

run -all

quit -force
