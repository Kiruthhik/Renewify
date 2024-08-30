from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework import serializers
from .models import *

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('username', 'email', 'password')


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        if username and password:
            user = authenticate(username=username, password=password)
            if user is None:
                raise serializers.ValidationError("Invalid login credentials.")
        else:
            raise serializers.ValidationError("Both fields must be filled.")
        
        data['user'] = user
        return data
    
class PanelTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = panel_type
        fields = ('roof_space', 'power_consumption')

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = location
        fields = ('address','pincode')

class ComplaintSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaint
        fields = ('title','description','phoneno','city')

class CommunitySerializer(serializers.ModelSerializer):
    class Meta:
        model = community_post
        fields = ('post_description',)