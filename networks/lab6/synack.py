ack_packet = IP(dst=target_ip) / TCP(
    dport=target_port,
    flags="A",
    seq=syn_response.ack,
    ack=syn_response.seq + 1
)

send(ack_packet, verbose=False)
print("Handshake completed.")
