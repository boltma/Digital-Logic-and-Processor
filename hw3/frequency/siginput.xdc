
# System clock
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports {sysclk}]

# Switch
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {testmode[0]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {testmode[1]}]

# LED as output
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {sigin1}]

create_clock -period 10.000 -name CLK -waveform {0.000 5.000} [get_ports sysclk]
