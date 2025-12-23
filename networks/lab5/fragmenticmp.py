from scapy.all import *
## from scapy.all import IP, ICMP, sr1

# Building an ICMP Echo Request packet
icmp_request = IP(dst="8.8.8.8") / ICMP(type=8) / "Hello, this is a test"

# Send the packet and receive the reply
response = sr1(icmp_request, timeout=5)

# Check answer
if response:
    print("Response received")
    response.show()
else:
    print("No response from the server.")
