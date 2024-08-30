from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(panel_type)
admin.site.register(location)
admin.site.register(community_post)
admin.site.register(Complaint)