from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets, status
from rest_framework.views import APIView
from django.http import JsonResponse
import paho.mqtt.client as mqtt
from .models import Phrase, Command, Scene, Device, Session
from django.conf import settings

class ValueIsNotPercent(Exception):
    '''Raised when the value given to Alice to change on dimmer is not in percentage range (0-100)'''
    pass

class NoAuthProvided(Exception):
    ''' Raise when user didn't authorize in any location '''
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
client.connect(host = "192.168.0.83", port = 1883)

def on_disconnect(client, userdata, rc):
    if rc != 0:
        print("Unexpected disconnection.")
        client.reconnect()

def on_connect(client, userdata, flags, rc):
    if rc==0:
        print("connected OK Returned code=",rc)
    else:
        print("Bad connection Returned code=",rc)
def on_message_callback(client, userdata, message):
    global payload 
    payload = message.payload
    print('payload = ' + payload.decode('utf-8'))
    client.disconnect()

client.on_disconnect = on_disconnect
client.on_connect = on_connect
client.on_message = on_message_callback

def scale_value(old_value, old_min, old_max, new_min, new_max):
    # is using to convert percentages to different range
    new_value = (((old_value - old_min) * (new_max - new_min)) / (old_max - old_min)) + new_min
    if new_value:
        return new_value
    return 0

def auth_handler(request, token):
    ''' True if authorized, NoAuthProvided exception otherwise as well as in case of changing room'''
    sessions = Session.objects.all().filter(token = token, expired = False)
    command = request.data.get('request').get('command')
    command = greetings_handler(command.lower())
    if 'поменять помещение' in command:
        for session in sessions:
            session.expired = True
            session.save()
        raise NoAuthProvided('Room changed')
    if not sessions:
        raise NoAuthProvided('No auth provided')
    else:
        return True


def greetings_handler(command):
    ''' Is using to recognise greetings replies such as 'Алиса' and 'Слушай, Алиса' '''
    greetings_replies = ['Алиса', 'Слушай Алиса']
    greetings_replies = sorted(greetings_replies, key = len)
    # is using to sort array by length so the longest substring goes first
    for reply in reversed(greetings_replies):
        if reply.lower() in command:
            command = command.replace(reply.lower(), '')
            break
    return command

payload = 0

def execute_command(command, request):
    ''' Returns None if value is published or given value otherwise '''
    client.reconnect()
    print(command.value_to_set)
    if command.get_value == True:
        client.subscribe(command.device.connection)
        client.loop_forever()
        print(payload)
        client.reconnect()
        client.unsubscribe(command.device.connection)
        return payload.decode('utf-8')
    # in request, value is string so we cast to int assuming it's IntegerField so there will be no exceptions occured
    if int(command.value_to_set) == -1:
        print('if')
        print(request.data)
        for entity in request.data.get('request').get('nlu').get('entities'):
            if entity.get('type') == 'YANDEX.NUMBER':
                print('publishing')
                print(command.device.connection)
                print(entity.get('value'))
                value = entity.get('value')
                if command.device.percent:
                    if value > 100 or value < 0:
                        raise ValueIsNotPercent('Value is not a percent')
                    value = int(scale_value(old_value = value, old_min = 0, old_max = 100, new_min = 
                    command.device.start_value, new_max = command.device.max_value))
                print('new value: ' + str(value))
                client.publish(command.device.connection, value, retain = True)
            print(entity)
        # print(request.data)
    else:
        print(command.value_to_set)
        print('else')
        client.publish(command.device.connection, command.value_to_set, retain = True)
    return None
    

def text_handler(request):
    command = request.data.get('request').get('command')
    try:
        print(request.data.get('session').get('user_id'))
        auth_handler(request, request.data.get('session').get('user_id')) # Checking auth, also handles logging out from rooms

        command = ''.join([i for i in command if not i.isdigit()]) # delete numbers from string, we will retain them later from yandex's info
        command = greetings_handler(command.lower())
        try:
            command = command.strip()
        except:
            command = ''
        print(command)
        original = request.data.get('request').get('original_utterance')
        original = ''.join([i for i in original if not i.isdigit()])
        try:
            original = original.strip()
        except:
            original = ''
        try:
            phrase = Phrase.objects.all().get(phrase__iexact = command.lower())
            value_to_return = execute_command(phrase.command, request)
            text_to_return = phrase.success_response
            if value_to_return is not None:
                if phrase.command.device.percent:
                    value_to_return = scale_value(old_value = int(value_to_return), old_min = phrase.command.device.start_value, old_max = phrase.command.device.max_value, 
                    new_min = 0, new_max = 100) # scale to percents
                text_to_return += ' ' + str(int(value_to_return))
        except Phrase.DoesNotExist:
            print('exception')
            try:
                phrase = Phrase.objects.all().get(phrase__iexact = original.lower())
                execute_command(phrase.command, request)
                text_to_return = phrase.success_response
                if value_to_return is not None:
                    text_to_return += ' ' + value_to_return
            except Phrase.DoesNotExist:
                text_to_return = "К сожалению, я не знаю такой команды"
        except ValueIsNotPercent:
            text_to_return = "Значение не является процентом"
        
        return text_to_return
    except NoAuthProvided:
        command = greetings_handler(command.lower())
        if 'кодовое слово' in command:
            word_list = command.split()
            key_word = word_list[-1]
            try:
                location = Scene.objects.all().get(activation__iexact = key_word) # if there is location with certain key word
                session = Session(token = request.data.get('session').get('user_id'), location = location, expired = False)
                session.save()
                text_to_return = 'Спасибо, вы авторизовались в помещении кодовой фразой ' + location.activation
            except Scene.DoesNotExist:
                return 'К сожалению, я не знаю такого кодового слова'
            except:
                return 'К сожалению, произошла внутренняя ошибка с кодовыми словами. Возможно, одинаковых кодовых слов больше одного.'
        else:
            print('No auth provided exception') # TODO auth
            text_to_return = "Вам нужно авторизоваться в помещении. Пожалуйста, скажите кодовое слово"
        return text_to_return
        