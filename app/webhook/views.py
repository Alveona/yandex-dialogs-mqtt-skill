from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets, status
from rest_framework.views import APIView
from django.http import JsonResponse
import paho.mqtt.client as mqtt
from .models import Phrase, Command, Scene, Device, Session, UsualPhrase, Board
from django.conf import settings

class ValueIsNotPercent(Exception):
    ''' Raised when the value given to Alice to change on dimmer is not in percentage range (0-100)'''
    pass

class NotInitializedYet(Exception):
    ''' Raised when user didn't initialize itself in any appartment '''
    pass

class ResetInProgress(Exception):
    ''' Raised when reset is in progress '''
    pass

class NoAuthProvided(Exception):
    ''' Raised when user didn't authorize in any location '''
    pass

class NoDeviceStateChange(Exception):
    ''' Raised when simple command is executed, is used to avoid block of code with command handling '''
    def __init__(self, arg):
        self.strerror = arg
        self.args = {arg}

class StartOfDialog(Exception):
    ''' Raised when session has 'new = True' which means it is first message of dialog and Alice should introduce herself '''
    pass

class LocationFound(Exception):
    ''' Raised when the 'Где я' phrase is invoked '''
    def __init__(self, arg):
        self.strerror = arg
        self.args = {arg}

class WrongLocation(Exception):
    ''' Raise when there is requested command in database, but it is in the different room '''
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

client = mqtt.Client(client_id='1234', clean_session=True, userdata=None, transport='tcp')
client.connect(host = "192.168.0.69", port = 1883)

def on_disconnect(client, userdata, rc):
    print('Disconnect, rc:' + str(rc))
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
    # is using to convert percentages to specific value range or opposite
    new_value = (((old_value - old_min) * (new_max - new_min)) / (old_max - old_min)) + new_min
    if new_value:
        return new_value
    return 0

def introduction_handler(request):
    ''' Checks if it is start of dialog, in this case raises StartOfDialog exception, otherwise returns False'''
    print(request.data.get('session').get('new'))
    if request.data.get('session').get('new') == True:
        raise StartOfDialog
    return False

reset_in_progress = False
def initialization_handler(request, token):
    ''' True if initialized in any appartments, NotInitializedYet exception otherwise.
    Also handles soft reset option, using special dialog to confirm it;  '''
    sessions = Session.objects.all().filter(token = token, expired = False)
    command = request.data.get('request').get('command')
    command = greetings_handler(command.lower())
    global reset_in_progress
    if reset_in_progress == True:
        raise ResetInProgress
    if 'полный сброс' in command:
        raise ResetInProgress(reset_in_progress)
        # TODO
    
    
    if not sessions:
        raise NotInitializedYet('Not initialized yet')

    else:
        return True


def auth_handler(request, token):
    ''' True if authorized, NoAuthProvided exception otherwise as well as in case of changing room'''
    sessions = Session.objects.all().filter(token = token, expired = False)
    sessions = sessions.exclude(location__isnull = True) # drop sessions where you initialized in board but not in room yet
    print('Sessions: ' + str(sessions))
    command = request.data.get('request').get('command')
    command = greetings_handler(command.lower())
    if 'поменять помещение' in command:
        for session in sessions:
            #session.expired = True
            session.location = None #TODO check if work properly
            session.save()
        raise NoAuthProvided('Room changed')
    if not sessions:
        raise NoAuthProvided('No auth provided')
    else:
        return True

def usual_phrases_handler(command):
    ''' Is using to do simple responses without executing any commands to devices
        False if there is no simple command, NoDeviceStateChange exception otherwise '''
    command = greetings_handler(command.lower())
    try:
        phrase = UsualPhrase.objects.all().get(phrase__iexact = command)
    except UsualPhrase.DoesNotExist:
        return False
    if phrase:
        raise NoDeviceStateChange(phrase.success_response)
    return False
    
def greetings_handler(command):
    ''' Is using to recognise greetings replies such as 'Алиса' and 'Слушай, Алиса' '''
    greetings_replies = ['Алиса', 'Слушай Алиса']
    greetings_replies = sorted(greetings_replies, key = len)
    # is using to sort array by length so the longest substring goes first which is required for 'contains' method proper work
    for reply in reversed(greetings_replies):
        if reply.lower() in command:
            command = command.replace(reply.lower(), '')
            break
    return command

def location_find_handler(command, token):
    ''' Is using to handle requests like 'где я' '''
    ''' Raises LocationFound exception with location name if asking for location is found, otherwise returns False'''
    command = greetings_handler(command.lower())
    if 'где я' in command:
        sessions = Session.objects.all().filter(token = token, expired = 0).order_by('-id')
        session = sessions.first()
        location = session.location
        raise LocationFound(location.title)
    return False

payload = 0

def execute_command(command, request):
    ''' Returns None if value is published or given value otherwise '''
    client.reconnect()
    print(command.value_to_set)
    if command.get_value == True:
        client.reconnect()
        if command.device.connection_read != '':
            client.subscribe(command.device.connection_read)
        else:
            client.subscribe(command.device.connection)
        client.loop_forever()
        print(payload)
        # client.reconnect()
        client.unsubscribe(command.device.connection_read)
        client.unsubscribe(command.device.connection)
        return payload.decode('utf-8')
    
    sessions = Session.objects.all().filter(token = request.data.get('session').get('user_id'), expired = 0).order_by('-id')
    session = sessions.first()
    current_location = session.location
    if current_location != command.device.scene:
        raise WrongLocation
    # in request, value is string so we cast to int assuming it's IntegerField so there will be no exceptions occured
    if int(command.value_to_set) == -1: # if Alice is supposed to get value from user and set it to device
        for entity in request.data.get('request').get('nlu').get('entities'):
            if entity.get('type') == 'YANDEX.NUMBER':
                value = entity.get('value')
                if command.device.percent:
                    if value > 100 or value < 0:
                        raise ValueIsNotPercent('Value is not a percent')
                    value = int(scale_value(old_value = value, old_min = 0, old_max = 100, new_min = 
                    command.device.start_value, new_max = command.device.max_value))
                client.publish(command.device.connection, value, retain = True)
    elif int(command.value_to_set) == -2:
        client.publish(command.device.connection, command.device.start_value, retain = True)
    elif int(command.value_to_set) == -3:
        client.publish(command.device.connection, command.device.max_value, retain = True)
    else:
        client.publish(command.device.connection, command.value_to_set, retain = True)
    return None
    

def text_handler(request):
    command = request.data.get('request').get('command')
    try:
        print(request.data.get('session').get('user_id'))
        introduction_handler(request) # Check if it is start of dialog
        usual_phrases_handler(command) # Checking for any simple phrase
        initialization_handler(request, request.data.get('session').get('user_id')) # Checking initialization in specific board, handles resets as well
        auth_handler(request, request.data.get('session').get('user_id')) # Checking auth, also handles logging out from rooms
        location_find_handler(command, request.data.get('session').get('user_id')) # Check if user requested current location

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
                text_to_return += ' ' + str(int(float(value_to_return)))
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
                session = Session.objects.all().get(token = request.data.get('session').get('user_id'), expired = False)
                location = Scene.objects.all().get(activation__iexact = key_word, board = session.board) # if there is location with certain key word
                session.location = location
                # session = Session(token = request.data.get('session').get('user_id'), location = location, expired = False)
                session.save()
                text_to_return = 'Спасибо, вы авторизовались в помещении ' + location.title
            except Scene.DoesNotExist:
                return 'К сожалению, я не знаю такого кодового слова'
            except:
                return 'К сожалению, произошла внутренняя ошибка с кодовыми словами. Возможно, одинаковых кодовых слов больше одного.'
        else:
            print('No auth provided exception') # TODO auth
            text_to_return = "Вам нужно авторизоваться в помещении. Пожалуйста, скажите кодовое слово"
        return text_to_return

    except NoDeviceStateChange as e:
        text_to_return = e.strerror # Hacky way to pass data through blocks with exceptions
        return text_to_return

    except StartOfDialog:
        return 'Добро пожаловать в голосовой помощник умного дома, чтобы узнать больше о возможностях, скажите "помощь"'
        
    except LocationFound as e:
        text_to_return = e.strerror
        return 'Текущая локация ' + text_to_return

    except WrongLocation:
        return 'К сожалению, в этом помещении такой команды нет'

    except ResetInProgress:
        global reset_in_progress
        if reset_in_progress == False:
            reset_in_progress = True
            text_to_return = 'Вы уверены, что хотите произвести полный сброс? Скажите "да" или "нет"'
            return text_to_return
        if reset_in_progress == True:
            if command == 'да':
                sessions = Session.objects.all().filter(token = request.data.get('session').get('user_id'), expired = False)
                for s in sessions:
                    s.expired = True
                    s.save()
                text_to_return = "Вам нужно авторизоваться в управляющем щите. Пожалуйста, скажите кодовое число"
                reset_in_progress = False
                return text_to_return
            else:
                text_to_return = "Процесс сброса отменен"
                reset_in_progress = False
                return text_to_return

    except NotInitializedYet:
        command = greetings_handler(command.lower())
        if 'авторизация' in command:
            word_list = command.split()
            key_word = word_list[-1]
            try:
                key_word = int(key_word)
                board = Board.objects.all().get(activation_code__iexact = key_word) # if there is board with certain activation code
                session = Session(token = request.data.get('session').get('user_id'), board = board, expired = False)
                session.save()
                text_to_return = 'Спасибо, авторизация в щите ' + board.title + ' прошла успешно'
            except Board.DoesNotExist:
                return 'К сожалению, я не знаю такого кодового числа'
            except ValueError:
                return 'Код авторизации должен быть числом'
            except:
                return 'К сожалению, произошла внутренняя ошибка с кодами. Возможно, одинаковых кодовых слов больше одного.'
        else:
            print('No initialization provided exception') 
            text_to_return = "Вам нужно авторизоваться в управляющем щите. Пожалуйста, скажите кодовое число"
        return text_to_return