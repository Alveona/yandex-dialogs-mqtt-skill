from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets, status
from rest_framework.views import APIView
from django.http import JsonResponse
import paho.mqtt.client as mqtt
from .models import Phrase, Command, Scene, Device
from django.conf import settings

class ValueIsNotPercent(Exception):
    '''Raised when the value given to Alice to change on dimmer is not in percentage range (0-100)'''
    pass

class WebhookView(APIView):
    def post(self, request):
        # print(request.data)
        session = request.data.get('session')
        # print(session)
        session_id = session.get('session_id')
        message_id = session.get('message_id')
        user_id = session.get('user_id')

        response_text = text_handler(request)
        return JsonResponse({
            "response" : 
                {
                    "text": response_text,
                    "tts": response_text,
                    "end_session": False
                },
            "session" :
                {
                    "session_id": session_id,
                    "message_id": message_id,
                    "user_id": user_id
                },
            "version" : "1.0"
            }, 
            status = status.HTTP_200_OK)
# Create your views here.

client = mqtt.Client(client_id='1234', clean_session=True, userdata=None, transport='tcp')
client.connect(host = "192.168.1.176")

def on_disconnect(client, userdata, rc):
    if rc != 0:
        print("Unexpected disconnection.")
        client.reconnect()

client.on_disconnect = on_disconnect

# uses to convert percentages to different range
def scale_value(old_value, old_min, old_max, new_min, new_max):
    new_value = (((old_value - old_min) * (new_max - new_min)) / (old_max - old_min)) + new_min
    if new_value:
        return new_value
    return 0


def execute_command(command, request):
    print(command.value_to_set)
    # in request, value is string so we cast to int assuming it's IntegerField so there will be no exceptions occured
    if int(command.value_to_set) == -1:
        print('if')
        for entity in request.data.get('request').get('nlu').get('entities'):
            if entity.get('type') == 'YANDEX.NUMBER':
                print('publishing')
                print(command.device.connection)
                print(entity.get('value'))
                value = entity.get('value')
                if value > 100 or value < 0 :
                    raise ValueIsNotPercent('Value is not a percent')
                client.publish(command.device.connection, entity.get('value'))
            print(entity)
        # print(request.data)
    else:
        print(command.value_to_set)
        print('else')
        client.publish(command.device.connection, command.value_to_set)
    

def text_handler(request):
    command = request.data.get('request').get('command')
    command = ''.join([i for i in command if not i.isdigit()]) # delete numbers from string
    try:
        if command[-1] == ' ': # remove trailing space
            command = command[0:-1]
    except:
        command = ''
    print(command)
    original = request.data.get('request').get('original_utterance')
    original = ''.join([i for i in original if not i.isdigit()])
    try:
        if original[-1] == ' ':
            original = original[0:-1]
    except:
        original = ''
    # print(request.data)
    try:
        phrase = Phrase.objects.all().get(phrase__iexact = command.lower())
        # print(phrase)
        execute_command(phrase.command, request)
        text_to_return = phrase.success_response
    except Phrase.DoesNotExist:
        print('exception')
        try:
            phrase = Phrase.objects.all().get(phrase__iexact = original.lower())
            execute_command(phrase.command, request)
            text_to_return = phrase.success_response
        except Phrase.DoesNotExist:
            text_to_return = "К сожалению, я не знаю такой команды"
    except ValueIsNotPercent:
        text_to_return = "Значение не является процентом"
    
    return text_to_return