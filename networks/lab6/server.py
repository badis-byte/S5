import socket

server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_socket.bind(("0.0.0.0", 12345))

print("UDP server waiting for messages...")

while True:
    data, address = server_socket.recvfrom(1024)
    print(f"Message received: {data.decode()} from {address}")
    
    response = f"Message received: {data.decode()}"
    server_socket.sendto(response.encode(), address)
