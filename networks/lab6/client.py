import socket

client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

server_address = ("127.0.0.1", 12345)

while True:
    message = input("Enter a message to send: ")
    client_socket.sendto(message.encode(), server_address)

    response, _ = client_socket.recvfrom(1024)
    print(f"Server response: {response.decode()}")
