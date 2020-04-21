onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib InterruptManageROM_opt

do {wave.do}

view wave
view structure
view signals

do {InterruptManageROM.udo}

run -all

quit -force
