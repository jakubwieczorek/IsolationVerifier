from opcua import Server
from opcua import ua
from random import randint
import datetime
import time
import serial

ser = serial.Serial(
    port='/dev/ttyACM0',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS
)

server = Server()

url = "opc.tcp://172.18.0.2:4841"
server.set_endpoint(url)

# server namespace
name = "OPCUA_SIMULATION_SERVER"
addspace = server.register_namespace(name)

# certificates
server.load_certificate("pem/cert.pem")
server.load_private_key("pem/key.pem")
server.set_security_policy([ua.SecurityPolicyType.Basic256Sha256_SignAndEncrypt])


# configure nodes
node = server.get_objects_node()
param = node.add_object(addspace, "parameters")
temp = param.add_variable(addspace, "temperature", 0)
temp.set_writable()

server.start()

print("Server started at {}", url)

while True:
    response = ser.readline()
    print(response)

    #temperature = randint(10, 50)
    #pressure = randint(200, 999)
    #mTime = datetime.datetime.now()

    # print(temperature, pressure, mTime)

    #temp.set_value(response)

    time.sleep(2)

