from opcua import Server
from opcua import ua
from random import randint
import datetime
import time
import serial

ADC_CH1          = "ADC_CH1"
ADC_CH1_RAW      = "ADC_CH1_RAW"
ADC_CH1_MEAN     = "ADC_CH1_MEAN_20"
ADC_CH1_MEAN_RAW = "ADC_CH1_MEAN_RAW_20"

class OpcManager:
    def __init__(self, url):
        self.server = Server() 
        self.url = url
        
    def configure_server(self):
        self.server.set_endpoint(self.url)
        
        # server namespace
        self.serverName = "OPCUA_SIMULATION_SERVER"
        self.namespace = self.server.register_namespace(self.serverName)
    
    def configure_certificates(self):
        self.server.load_certificate("pem/cert.pem")
        self.server.load_private_key("pem/key.pem")
        self.server.set_security_policy([ua.SecurityPolicyType.Basic256Sha256_SignAndEncrypt])

    def configure_nodes(self):
        node = self.server.get_objects_node()
        param = node.add_object(self.namespace, "parameters")

        self.adc_ch1 = param.add_variable(self.namespace, ADC_CH1, 0)
        self.adc_ch1_raw = param.add_variable(self.namespace, ADC_CH1_RAW, 0)
        self.adc_ch1_mean = param.add_variable(self.namespace, ADC_CH1_MEAN, 0)
        self.adc_ch1_mean_raw = param.add_variable(self.namespace, ADC_CH1_MEAN_RAW, 0)

        self.adc_ch1.set_writable()
        self.adc_ch1_raw.set_writable()
        self.adc_ch1_mean.set_writable()
        self.adc_ch1_mean_raw.set_writable()

    def parseData(self, data):

        try:
            if(data[0] == ADC_CH1):
                self.adc_ch1_raw.set_value(int(data[1]))
                self.adc_ch1.set_value(float(data[2]))
            if(data[0] == ADC_CH1_MEAN):
                self.adc_ch1_mean_raw.set_value(int(data[1]))
                self.adc_ch1_mean.set_value(float(data[2]))
        except ValueError:
            print("conversion problem")

if __name__ == "__main__":
    opcManager = OpcManager("opc.tcp://172.18.0.2:4840")
    opcManager.configure_server()
    opcManager.configure_certificates()
    opcManager.configure_nodes()
    
    opcManager.server.start()

    print("Server started at {}", opcManager.url)
    
    ser = serial.Serial(
        port='/dev/ttyACM0',
        baudrate=115200,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS
    )

    while True:
        byte_response = ser.readline()
        char_response = byte_response.decode('UTF-8')
        data = char_response.split()
        print(char_response)
   
        opcManager.parseData(data)

        #temp.set_value(response)

        #time.sleep(2)
