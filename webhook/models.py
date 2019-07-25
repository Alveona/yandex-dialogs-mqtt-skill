from django.db import models
from django.conf import settings
from django import forms

class Scene(models.Model):
    title = models.CharField(max_length = 255, null = True)

    def __str__(self):
        return self.title

class Device(models.Model):
    type = models.IntegerField() # 0 - switch, 1 - push
    # command = models.ForeignKey(Command, on_delete=models.CASCADE)
    connection = models.CharField(max_length = 255)
    scene = models.ForeignKey(Scene, on_delete=models.CASCADE)

    def __str__(self):
        type = {
            0: "Переключатель",
            1: "Кнопка"
        }

        return type.get(self.type) + "; id: " + str(self.id)


SET_CHOICES = [('0', '0'), ('1', '1'), ('-1', 'Пользовательское значение от Алисы')]
class Command(models.Model):
    title = models.CharField(max_length = 255, null = True)
    device = models.ForeignKey(Device, on_delete=models.CASCADE, null = True)
    value_to_set = models.CharField(max_length = 255, verbose_name = "Установить значение", choices=SET_CHOICES, null = True)
    def __str__(self):
        return self.title + "; id: " + str(self.id)
    
class Phrase(models.Model):
    phrase = models.TextField(verbose_name="Фраза пользователя", null = True)
    success_response = models.TextField(verbose_name="Ответ Алисы при успехе", null = True)
    fail_response = models.TextField(verbose_name="Ответ Алисы, если что-то пошло не так", null = True)
    command = models.ForeignKey(Command, on_delete=models.CASCADE)

    def __str__(self):
        return self.phrase

