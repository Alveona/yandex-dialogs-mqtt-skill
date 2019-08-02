from rest_framework import routers
from django.urls import path
from .views import WebhookView
from django.conf import settings

router = routers.DefaultRouter(trailing_slash=True)
#router.register(r'doctors', DoctorViewSet, base_name='doctors')
#router.register(r'patients', PatientViewSet, base_name='patients')

# router.register(r'applies', ApplyView, base_name='applies')
urlpatterns = router.urls
urlpatterns += path('webhook', WebhookView.as_view()),
