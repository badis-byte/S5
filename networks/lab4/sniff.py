from scapy.all import *

# Sniff packets and display only ARP packets
print("Listening for ARP packets...")
sniff(filter="arp", count=125, prn=lambda pkt: pkt.summary())
