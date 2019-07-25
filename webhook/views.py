from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets, status
from rest_framework.views import APIView
from django.http import JsonResponse
import paho.mqtt.client as mqtt
from .models import Phrase, Command, Scene, Device

class WebhookView(APIView):
    def post(self, request):
        print(request.data)
        session = request.data.get('session')
        print(session)
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

def execute_command(command):
    if command.value_to_set != -1:
        client.publish(command.device.connection, command.value_to_set)


def text_handler(request):
    command = request.data.get('request').get('command')
    original = request.data.get('request').get('original_utterance')
    
    try:
        phrase = Phrase.objects.all().get(phrase__iexact = command)
        execute_command(phrase.command)
        text_to_return = phrase.success_response
    except Phrase.DoesNotExist:
        try:
            phrase = Phrase.objects.all().get(phrase__iexact = original)
            execute_command(phrase.command)
            text_to_return = phrase.success_response
        except Phrase.DoesNotExist:
            text_to_return = "К сожалению, я не знаю такой команды"
    # text_to_return = ""
    # if "включи" in command or "включи" in original:
    #     text_to_return = "Включаю"
    #     client.publish("/devices/wb-gpio/controls/EXT2_R3A2/on", 1)
    # elif "выключи" in command or "выключи" in original:
    #     text_to_return = "Выключаю"
    #     client.publish("/devices/wb-gpio/controls/EXT2_R3A2/on", 0)
    # else:
    #     text_to_return = "Дороу"
    
    return text_to_return