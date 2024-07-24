from flask import Flask, request, jsonify
from flask_restful import Resource, Api
import requests

app = Flask(__name__)
api = Api(app)

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
    if response.status_code == 200:
        data = response.json()
        return data['properties']['parameter']['ALLSKY_SFC_SW_DWN']
    else:
        return None

def calculate_sunlight_hours(ghi_data):
    total_sunlight_hours = 0
    for ghi in ghi_data.values():
        sunlight_hours = ghi
        total_sunlight_hours += sunlight_hours
    average_sunlight_hours = total_sunlight_hours / len(ghi_data)
    return average_sunlight_hours

def recommend_panel_type(rooftop_space, sunlight_hours, power_consumption):
    large_space_threshold = 500  # threshold for large rooftop space in sq.feet
    high_sunlight_threshold = 5  # threshold for high sunlight availability in hours per day
    high_consumption_threshold = 400  # Example threshold for high power consumption in kWh per month

    if rooftop_space < large_space_threshold:
        return "monocrystalline"
    elif sunlight_hours < high_sunlight_threshold:
        return "monocrystalline"
    elif power_consumption > high_consumption_threshold:
        return "monocrystalline"
    else:
        return "polycrystalline"

class SolarPanelRecommendation(Resource):
    def get(self):
        latitude = 11.065249
        longitude = 77.091971
        rooftop_space = 1000
        power_consumption = 1000
        #latitude = get(float(request.args.get('latitude')),latitude)
        latitude = request.args.get('latitude',latitude,type=float)
        longitude = request.args.get('longitude',longitude,type=float)
        #longitude = float(request.args.get('longitude'))
        #rooftop_space = float(request.args.get('rooftop_space'))
        #power_consumption = float(request.args.get('power_consumption'))
        rooftop_space = request.args.get('rooftop_space',rooftop_space,type=float)
        power_consumption = request.args.get('power_consumption',power_consumption,type=float)

        start_date = '20230101'
        end_date = '20231230'

        ghi_data = get_ghi_data(latitude, longitude, start_date, end_date)

        if ghi_data:
            sunlight_hours = calculate_sunlight_hours(ghi_data)
            panel_type = recommend_panel_type(rooftop_space, sunlight_hours, power_consumption)
            return jsonify({"panel_type_recommended": panel_type})
        else:
            return jsonify({"error": "Failed to retrieve GHI data."})

api.add_resource(SolarPanelRecommendation, '/recommend')

#if __name__ == '__main__':
#    app.run(debug=True)