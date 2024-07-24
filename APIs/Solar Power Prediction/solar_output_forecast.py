from flask import Flask, request, jsonify
from datetime import datetime, timedelta
import requests

app = Flask(__name__)

def get_solar_irradiance_data(year, month, latitude, longitude):
    endpoint = "https://power.larc.nasa.gov/api/temporal/daily/point"
    start_date = f"{year}{month:02d}01"
    end_date = (datetime(year, month, 1) + timedelta(days=32)).replace(day=1) - timedelta(days=1)
    end_date = end_date.strftime("%Y%m%d")
    
    params = {
        "start": start_date,  # Start date in YYYYMMDD format
        "end": end_date,      # End date in YYYYMMDD format
        "latitude": latitude,
        "longitude": longitude,
        "parameters": "ALLSKY_SFC_SW_DWN",  # Surface downward shortwave radiation
        "community": "RE",
        "format": "JSON"
    }

    response = requests.get(endpoint, params=params)
    response.raise_for_status()
    data = response.json()

    if "properties" in data and "parameter" in data["properties"]:
        return data["properties"]["parameter"]["ALLSKY_SFC_SW_DWN"]
    else:
        return {}

@app.route('/solar-power-expectation', methods=['GET'])
def solar_power():
    latitude = 11.065249
    longitude = 77.091971
    panel_count = 10
    efficiency = 18
    latitude = request.args.get('latitude',latitude,type=float)
    longitude = request.args.get('longitude',longitude,type=float)
    panel_count = request.args.get('panel_count',panel_count,type=int)
    efficiency = request.args.get('efficiency',efficiency,type=float)

    current_date = datetime.now()

    # Calculate the next month
    next_month = current_date.replace(day=28) + timedelta(days=4)
    next_month = next_month.replace(day=1)

    years = [next_month.year - i for i in range(1, 5)]
    month = next_month.month

    irradiance_data = []
    for year in years:
        data = get_solar_irradiance_data(year, month, latitude, longitude)
        irradiance_data.append(data)

    total_irradiance = {}
    for data in irradiance_data:
        for date, value in data.items():
            day = int(date[-2:])  # Extract day from the date string
            if day not in total_irradiance:
                total_irradiance[day] = []
            total_irradiance[day].append(value)

    average_irradiance = {day: sum(values) / len(values) for day, values in total_irradiance.items()}

    panel_area = 1.6 * panel_count
    panel_efficiency = efficiency / 100.0

    total_output = 0  # Initialize total output to zero
    for day, irradiance in average_irradiance.items():
        power_output = irradiance * panel_area * panel_efficiency   # kiloWatt per day
        total_output += power_output  # Sum up the daily outputs

    month_name = next_month.strftime("%B")
    result = {
        "month": month_name,
        "expected_total_power_output": total_output
    }
    return jsonify(result)

#if __name__ == '__main__':
#    app.run(debug=True)

