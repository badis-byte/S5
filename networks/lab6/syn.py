from scapy.all import *

target_ip = "127.0.0.1"   # Replace with the target IP address
target_port = 80              # Destination port

syn_packet = IP(dst=target_ip) / TCP(dport=target_port, flags="S")
syn_response = sr1(syn_packet, timeout=2, verbose=False)

if syn_response:
    print(syn_response.summary())
else:
    print("No response received")

ack_packet = IP(dst=target_ip) / TCP(
    dport=target_port,
    flags="A",
    seq=syn_response.ack,
    ack=syn_response.seq + 1
)

send(ack_packet, verbose=False)
print("Handshake completed.")

