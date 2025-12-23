from scapy.all import *

# Create an Ethernet frame with an ARP request
eth_arp_packet = Ether(dst="ff:ff:ff:ff:ff:ff") / ARP(pdst="192.168.1.1")

# Display the combined packet
print("Ethernet + ARP packet:")
eth_arp_packet.show()
