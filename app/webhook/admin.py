from django.contrib import admin
from .models import Command, Device, Phrase, Scene, UsualPhrase, Board
from django.conf import settings
# Register your models here.
admin.site.register(Command)
admin.site.register(Device)
admin.site.register(Phrase)
admin.site.register(Scene)
admin.site.register(UsualPhrase)
admin.site.register(Board)