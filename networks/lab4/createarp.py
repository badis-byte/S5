from scapy.all import *

# Create an ARP request
arp_request = ARP(pdst="192.168.1.1", psrc="192.168.1.100", op=1)

# Display the ARP request
print("ARP request:")
arp_request.show()
