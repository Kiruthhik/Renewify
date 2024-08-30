from django.db import models
from django.contrib.auth.models import User
# Create your models here.
class panel_type(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    roof_space = models.DecimalField(max_digits=15,decimal_places=2)
    power_consumption = models.DecimalField(max_digits=10,decimal_places=2)
    recommended_panel = models.CharField(max_length=30,null=True)

    def __str__(self):
        return f"{self.user.username}\'s panel data"

class location(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    address = models.CharField(max_length=200)
    pincode = models.BigIntegerField()
    latitude = models.DecimalField(max_digits=9,decimal_places=6,null=True)
    longitude = models.DecimalField(max_digits=9,decimal_places=6,null=True)

    def __str__(self):
        return f"lat-{self.latitude} long-{self.longitude}"
    
class Complaint(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='complaints')
    phoneno = models.CharField(max_length=12)
    city = models.CharField(max_length=30)
    title = models.CharField(max_length=200)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"complaint by {self.user.username}"
    
class community_post(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE, related_name="posts")
    post_description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"post by {self.user.username}"
