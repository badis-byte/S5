from scapy.all import *

# Update the IP address to wherever your UDP server is running
packet = IP(dst="10.80.2.2") / UDP(dport=55555) / "ويييييي شبيبآا"

print("Packet generated:")
packet.show()

send(packet)
