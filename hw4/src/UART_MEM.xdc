#100MHz
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name clk -period 10.000 [get_ports clk]

#S6
set_property PACKAGE_PIN T18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

#S0
set_property PACKAGE_PIN V17 [get_ports mem2uart]
set_property IOSTANDARD LVCMOS33 [get_ports mem2uart]


#led 0
set_property PACKAGE_PIN U16 [get_ports recv_done]
set_property IOSTANDARD LVCMOS33 [get_ports recv_done]

#led 1
set_property PACKAGE_PIN E19 [get_ports send_done]
set_property IOSTANDARD LVCMOS33 [get_ports send_done]


#UART
set_property PACKAGE_PIN B18 [get_ports Rx_Serial]
set_property PACKAGE_PIN A18 [get_ports Tx_Serial]

set_property IOSTANDARD LVCMOS33 [get_ports Rx_Serial]
set_property IOSTANDARD LVCMOS33 [get_ports Tx_Serial]
