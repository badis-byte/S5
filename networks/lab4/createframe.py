from scapy.all import *

eth_frame = Ether(dst="ff:ff:ff:ff:ff:ff", src="00:11:22:33:44:55", type=1)

print("Ethernet Frame: ")
eth_frame.show()