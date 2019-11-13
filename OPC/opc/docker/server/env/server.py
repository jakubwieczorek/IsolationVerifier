from opcua import Server 
from random import randint
import datetime
import time

server = Server()

url = "opc.tcp://opc_server:4840"
server.set_endpoint(url)

name = "OPCUA_SIMULATION_SERVER"
addspace = server.register_namespace(name)

node = server.get_objects_node()

Param = node.add_object(addspace, "Parameters")

Temp = Param.add_variable(addspace, "Temperature", 0)
Press = Param.add_variable(addspace, "Pressure", 0)
Time = Param.add_variable(addspace, "Time", 0)

Temp.set_writable()
Press.set_writable()
Time.set_writable()

server.start()
print("Server started at {}", url)

while True:
    temperature = randint(10, 50)
    pressure = randint(200, 999)
    mTime = datetime.datetime.now()

    print(temperature, pressure, mTime)

    Temp.set_value(temperature)
    Press.set_value(pressure)
    Time.set_value(mTime)

    time.sleep(2)

