import paho.mqtt.client as mqtt

client = mqtt.Client(client_id='02302', clean_session=True, userdata=None, transport='tcp')

def on_subscribe(client, userdata, mid, granted_qos):
    # print('on_sub: ' + mid)
    print('subscribed')

def cmd():
    def test():
        return 28
    val = test()
    return val
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("successful connection")
    else:
        print('connection didnt go well')        
payload = 0
def on_message_callback(client, userdata, message):
    global payload 
    print(payload)
    payload = message.payload
    print(payload)
    client.disconnect()
    # print(message.title)
    # print(message.payload)
# def on_publish(client, userdata, mid):
#     print('on_pub' + mid)



# client.loop()
# client.loop_start()
# client.connect(host = "192.168.0.83", port = 1883)
# client.on_publish = on_publish
# client.loop_start()
client.on_connect = on_connect
client.on_subscribe = on_subscribe
client.on_message = on_message_callback
client.connect(host = "192.168.0.83", port = 1883)

# client.loop_start()
# client.reconnect()
client.subscribe('/devices/siemens_rdf302_70/controls/current_temperature')
# client.publish('/devices/gr7_1_dimm/controls/Value/on', 55, retain = True)
# client.publish('/devices/gr7_1_dimm/controls/Value/on', 55, retain = True)
print(payload)
client.loop_forever()
print('payload:',  payload.decode('utf-8'))
# print(cmd())
# client.loop_stop()

# while True:
    # pass# value1 = client.subscribe('/devices/wb-gpio/controls/EXT2_R3A4/on')
# value2 = client.subscribe('/devices/wb-gpio/controls/EXT2_R3A4/on')
# value3 = client.subscribe('/devices/wb-gpio/controls/EXT2_R3A4/on')
# print(value1, value2, value3)
# value2 = client.subscribe('/devices/gr7_1_dimm/controls/Value/on')
# value3 = client.subscribe('/devices/gr7_1_dimm/controls/Value/on')
# client.loop()
# client.loop()
# client.loop()
# client.loop()
# client.loop()
# client.loop()
# print(value1, value2, value3)
# print(value1)
# client.loop_start()
# client.loop_forever()
# client.loop_forever()

# while True:
#     client.loop()
# client.loop_stop()

