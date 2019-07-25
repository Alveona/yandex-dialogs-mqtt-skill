from django.contrib import admin
from .models import Command, Device, Phrase, Scene
# Register your models here.
admin.site.register(Command)
admin.site.register(Device)
admin.site.register(Phrase)
admin.site.register(Scene)