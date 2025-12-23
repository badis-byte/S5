import socket
import time

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('127.0.0.1', 55555))

for i in range(1):
    #message = f"Message {i + 1}".encode('utf-8')
    message = b"B" * 15361 #message of 2000 bytes
    client.sendall(message)

    response = client.recv(1024)
    print(f"Server response: {response.decode('utf-8')}")

    time.sleep(1)  # Pause between each transmission

client.close()
