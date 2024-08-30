from django.urls import path
from .views import *

urlpatterns = [
    path('api/register/', RegisterUserView.as_view(), name='register'),
    path('api/login/', LoginView.as_view(), name='login'),
    path('api/panel-type/', PanelTypeCreateView.as_view(), name='panel-type'),
    path('api/location/',LocationCreateView.as_view(),name='location'),
    path('api/complaint/',ComplaintCreateView.as_view(),name='complaints'),
    path('api/post/',CommunityCreateView.as_view(),name='community-posts'),
]
