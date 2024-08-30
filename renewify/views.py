from rest_framework.permissions import IsAuthenticated
from rest_framework import generics, status
from rest_framework.response import Response
from django.contrib.auth import login
from django.contrib.auth.models import User
from django.shortcuts import get_object_or_404
from .serializers import *
from .models import *
import requests
from decimal import Decimal


class RegisterUserView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer

class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        login(request, user)
        return Response({"detail": "Authenticated successfully"}, status=status.HTTP_200_OK)

class PanelTypeCreateView(generics.GenericAPIView):
    serializer_class = PanelTypeSerializer
    permission_classes = [IsAuthenticated]

    def post(self, request):
        # Extract the data from the request
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        # Get the authenticated user
        user = request.user
        print(user.username)
        location_details = location.objects.get(user=user)
        lat = location_details.latitude
        lng = location_details.longitude
        data = serializer.validated_data
        roof_space = data['roof_space']
        power_consumption = data['power_consumption']

        def get_ghi_data(lat, lon, start_date, end_date):
            url = "https://power.larc.nasa.gov/api/temporal/daily/point"
            params = {
                'start': start_date,
                'end': end_date,
                'latitude': lat,
                'longitude': lon,
                'community': 'RE',
                'parameters': 'ALLSKY_SFC_SW_DWN',
                'format': 'JSON',
                'user': 'anonymous'
            }
            response = requests.get(url, params=params)
            print("Status code:", response.status_code)
            if response.status_code == 200:
                data = response.json()
                return data['properties']['parameter']['ALLSKY_SFC_SW_DWN']
            else:
                print("Error fetching data:", response.json())
                return None

        def calculate_sunlight_hours(ghi_data):
            total_sunlight_hours = 0
            for date, ghi in ghi_data.items():
        # Print each GHI value to check
        #print(f"Date: {date}, GHI: {ghi}")
        # Convert GHI to sunlight hours (approximation)
        #sunlight_hours = ghi / 1000  # kWh/m²/day to hours of sunlight (rough estimate)
                sunlight_hours = ghi 
                total_sunlight_hours += sunlight_hours
            average_sunlight_hours = total_sunlight_hours / len(ghi_data)
            return average_sunlight_hours

# Replace with your own latitude and longitude
#home
#latitude = 13.008413
#longitude = 80.003411  kabul 34.541308, 69.211437 london 51.487711, -0.141856  manchseter 53.481293, -2.241810
# guinea 3.753517, 8.782026   kinshasa -4.303805, 15.308288 green land 75.418081, -40.605744
# ladakh 34.411095, 77.230440 AUs -22.665577, 130.540973 PSG 11.024888, 77.003039 delhi 28.684024, 77.167667
        latitude = lat
        longitude = lng 

# Define the fixed date range
        start_date = '20230101'
        end_date = '20231230'

        ghi_data = get_ghi_data(latitude, longitude, start_date, end_date)

        if ghi_data:
            average_sunlight_hours = calculate_sunlight_hours(ghi_data)
            print(f"The average hours of sunlight per day over the past year at the specified location is: {average_sunlight_hours:.2f} hours")
        else:
            print("Failed to retrieve GHI data.")


        def recommend_panel_type(rooftop_space, sunlight_hours, power_consumption):
    # Define thresholds
            large_space_threshold = 500  # threshold for large rooftop space in sq.feet
            high_sunlight_threshold = 5  # threshold for high sunlight availability in hours per day
            high_consumption_threshold = 400  # Example threshold for high power consumption in kWh per month

    # Rule-based logic
            if rooftop_space < large_space_threshold:
             return "monocrystalline"
            elif sunlight_hours < high_sunlight_threshold:
                return "monocrystalline"
            elif power_consumption > high_consumption_threshold:
                return "monocrystalline"
            else:
                return "polycrystalline"

# Example usage
        #rooftop_space = 40  # Example rooftop space in sq. meters
        sunlight_hours = calculate_sunlight_hours(ghi_data)  # Example average sunlight hours per day
        #power_consumption = 450  # Example power consumption in kWh per month

        solarpanel_type = recommend_panel_type(roof_space, sunlight_hours, power_consumption)
        print(f"Recommended panel type: {solarpanel_type}")

        
        # Use the validated data to create or update the panel_type instance
        panel_data, created = panel_type.objects.update_or_create( 
            user=user,
            defaults={
                'roof_space':roof_space,
                'power_consumption':power_consumption,
                'recommended_panel':solarpanel_type
            }
        )

        # Return the serialized data along with the appropriate status
        response_serializer = PanelTypeSerializer(panel_data)
        return Response(response_serializer.data, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)


class LocationCreateView(generics.GenericAPIView):
    serializer_class = LocationSerializer
    permission_classes = [IsAuthenticated]

    def post(self,request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        user = request.user

        location_data = serializer.validated_data

        # Make the API request to Google Maps Geocoding API
        try:
            response = requests.get(
                f"https://maps.googleapis.com/maps/api/geocode/json",
                params={
                    "address": f"{location_data['address']} {location_data['pincode']}",
                    "key": "AIzaSyAG4nroilWCKF8vjSZGXY3fhH2li6cr7LY"
                }
            )
            response.raise_for_status()  # Raise an exception for HTTP errors

            lat_long_response = response.json()
            if lat_long_response['status'] != 'OK':
                return Response({"error": "Unable to get geolocation data"}, status=status.HTTP_400_BAD_REQUEST)
            
            # Extract latitude and longitude from the API response
            lat_lon = lat_long_response['results'][0]['geometry']['location']
            lat = Decimal(lat_lon['lat'])
            lon = Decimal(lat_lon['lng'])
        
        except requests.RequestException as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        # Update or create the location object for the user
        location_, created = location.objects.update_or_create(
            user=user,
            defaults={
                'address': location_data['address'],
                'pincode': location_data['pincode'],
                'latitude': lat,
                'longitude': lon
            }
        )

        # Serialize the updated/created location object for the response
        response_serializer = LocationSerializer(location_)
        return Response(response_serializer.data, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)
    
class ComplaintCreateView(generics.GenericAPIView):
    serializer_class = ComplaintSerializer
    permission_classes = [IsAuthenticated]

    def post(self,request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = request.user

        complaint_,created = Complaint.objects.update_or_create(
            user = user,
            defaults = serializer.validated_data
        )

        response_serializer = ComplaintSerializer(complaint_)
        return Response(response_serializer.data, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

class CommunityCreateView(generics.GenericAPIView):
    serializer_class = CommunitySerializer
    permission_classes = [IsAuthenticated]
    def post(self,request):
        serializers = self.get_serializer(data=request.data)
        serializers.is_valid(raise_exception =True)
        user = request.user

        post, created = community_post.objects.update_or_create(
            user = user,
            defaults=serializers.validated_data
        )

        response_serializer = CommunitySerializer(post)
        return Response(response_serializer.data, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)
