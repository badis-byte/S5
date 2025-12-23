from scapy.all import *

# Create an Ethernet + ARP request
eth_arp_packet = Ether(dst="ff:ff:ff:ff:ff:ff") / ARP(pdst="10.80.1.1")

# Send the packet and wait for a response
response = srp1(eth_arp_packet, timeout=2, verbose=False)

# Display the response if received
if response:
    print("Received response:")
    response.show()
else:
    print("No response received.")
