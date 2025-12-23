import socket
import time

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('0.0.0.0', 20))
server.listen(10)

print("Server ready, waiting for connections...")

client_socket, addr = server.accept()
print(f"Connection established with {addr}")

while True:
    #time.sleep(0.5)
    data = client_socket.recv(1024)
    if not data:
        break

    print(f"Data received: {data.decode('utf-8')}")
    client_socket.sendall(data)   # Echo back the received data

client_socket.close()
server.close()


