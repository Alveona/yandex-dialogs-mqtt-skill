from django.db import models
from django.conf import settings
from django import forms


class Board(models.Model):
    title = models.CharField(max_length = 255, null = True)
    activation_code = models.IntegerField(null = True)
    connection = models.CharField(max_length = 255, null = True)

    def __str__(self):
        return self.title + '@' + self.connection
class Scene(models.Model):
    title = models.CharField(max_length = 255, null = True, verbose_name = 'Название помещения')
    activation = models.CharField(max_length = 255, verbose_name = 'Кодовая фраза',     help_text = 'Используется для авторизации в конкретном помещении', null = True)
    board = models.ForeignKey(Board, on_delete = models.CASCADE, null = True)
    def __str__(self):
        return self.title + '; Wiren Board: ' + self.board.title

class Device(models.Model):
    type = models.IntegerField(verbose_name='Тип устройства', help_text='0 - переключатель; 1 - кнопка\
        2 - диммер') # 0 - switch, 1 - push; 2 - range
    # command = models.ForeignKey(Command, on_delete=models.CASCADE)
    start_value = models.IntegerField(verbose_name='Минимальное значение', default=0, help_text='Минимальное\
    значение устройства, значение по умолчанию - 0')
    max_value = models.IntegerField(verbose_name='Максимальное значение', default=100, help_text='Минимальное\
    значение устройства, значение по умолчанию - 100')
    connection = models.CharField(max_length = 255, verbose_name = 'Строка подключения к устройству на запись')
    connection_read = models.CharField(max_length = 255, verbose_name = 'Строка подключения к устройству на чтение', default = '')
    scene = models.ForeignKey(Scene, on_delete=models.CASCADE)
    percent = models.BooleanField(verbose_name='Значение в процентах', help_text='Если выбрано, то значения с устройства будут приведены\
    к процентам в соответствии с заданными значениями максимума и минимума как при запросе, так и при ответе', default = False)

    def __str__(self):
        type = {
            0: "Переключатель",
            1: "Кнопка",
            2: "Диммер"
        }

        return type.get(self.type) + "; id: " + str(self.id)


SET_CHOICES = [('0', '0'), ('1', '1'), ('-1', 'Пользовательское значение от Алисы'), ('-2', 'Минимальное значение устройства'), 
('-3', 'Максимальное значение устройства')]
class Command(models.Model):
    title = models.CharField(max_length = 255, null = True)
    device = models.ForeignKey(Device, on_delete=models.CASCADE, null = True)
    value_to_set = models.CharField(max_length = 255, verbose_name = "Установить значение", choices=SET_CHOICES, null = True, blank = True)
    get_value = models.BooleanField(default=False, verbose_name="Получить значение от Алисы", 
    help_text="Если активна опция получения значения от Алисы, установка значения невозможна")
    def __str__(self):
        return self.title + "; id: " + str(self.id)
    
class Phrase(models.Model):
    phrase = models.TextField(verbose_name="Фраза пользователя", null = True)
    success_response = models.TextField(verbose_name="Ответ Алисы при успехе", null = True, 
    help_text='В случае возвращаемого значения, ответ будет выводиться в формате {Ваша фраза} + {Значение}, например "Текущая температура 32"')
    fail_response = models.TextField(verbose_name="Ответ Алисы, если что-то пошло не так", null = True)
    command = models.ForeignKey(Command, on_delete=models.CASCADE)

    def __str__(self):
        return self.phrase

class UsualPhrase(models.Model):
    phrase = models.TextField(verbose_name="Фраза пользователя", null = True)
    success_response = models.TextField(verbose_name="Ответ Алисы при успехе", null = True)
    fail_response = models.TextField(verbose_name="Ответ Алисы, если что-то пошло не так", null = True)

    def __str__(self):
        return self.phrase


class Session(models.Model):
    board = models.ForeignKey(Board, on_delete = models.CASCADE, null = True)
    token = models.CharField(max_length = 255, null = True)
    location = models.ForeignKey(Scene, on_delete = models.CASCADE, null = True)
    expired = models.BooleanField(default = False)
    
    
