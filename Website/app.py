from flask import Flask, render_template, request, jsonify
import cv2
import numpy as np
from shapely.geometry import Polygon
from PIL import Image, ImageDraw
from io import BytesIO
import requests

app = Flask(__name__)

latitude = 11.065249
longitude = 77.091971

# Replace with your Google Maps API key
API_KEY = 'YOUR_API_KEY'

area = 0.0

polygon_points = []

def convert_points(points):
    # Convert numpy intc types to Python int types
    #print("coverting points",points)
    return [(int(point[0]), int(point[1])) for point in points]

def get_satellite_image(lat, lng, zoom=21, size="640x640"):
    static_map_url = f'https://maps.googleapis.com/maps/api/staticmap?center={lat},{lng}&zoom={zoom}&size={size}&maptype=satellite&key={API_KEY}'
    response = requests.get(static_map_url)
    response.raise_for_status()
    image = Image.open(BytesIO(response.content))
    return image


def calculate_gsd(lat, zoom):
    earth_circumference = 40075016.686
    lat_rad = np.radians(lat)
    meters_per_pixel = earth_circumference * np.cos(lat_rad) / (2 ** zoom * 256)
    feet_per_pixel = meters_per_pixel * 3.28084
    return feet_per_pixel

@app.route('/')
def landing():
    global latitude, longitude
    latitude = request.args.get('latitude', latitude, type=float)
    longitude = request.args.get('longitude', longitude, type=float)
    return render_template('landing.html')

@app.route('/index')
def index():
    #my home
    #latitude = 12.9651541    
    #longitude = 80.1763840
    #psg eee block
    #latitude = 11.06550283467037
    #longitude = 77.09312557775431
    #latitude = 11.06550283467037
    #psg block
    #latitude = 11.065249
    #longitude = 77.091971
    zoom_level = 21
    image = get_satellite_image(latitude, longitude, zoom=zoom_level)
    image_path = "static/satellite_image.png"
    image.save(image_path)
    return render_template('index.html', image_url=image_path)


@app.route('/calculate_area', methods=['POST'])
def calculate_area():
    data = request.json
    points = data['points']
    latitude = data['latitude']
    #zoom_level = data['zoom']
    zoom_level = 21
    # Convert points to float
    points = [(float(point[0]), float(point[1])) for point in points]
    poly = Polygon(points)
    area_in_pixels = poly.area
    feet_per_pixel = calculate_gsd(latitude, zoom_level)
    area_in_square_feet = area_in_pixels * (feet_per_pixel ** 2)
    global area
    area = area_in_square_feet
    return jsonify({"area": area_in_square_feet})


@app.route('/cut_polygon', methods=['POST'])
def cut_polygon():
    data = request.json
    points = data['points']

    # Convert points to integer
    points = [(int(point[0]), int(point[1])) for point in points]

    # Load the original image
    image = Image.open("static/satellite_image.png").convert("RGBA")

    # Create a mask image
    mask = Image.new('L', (image.width, image.height), 0)
    ImageDraw.Draw(mask).polygon(points, outline=1, fill=1)
    mask = np.array(mask)

    # Convert image to numpy array
    image_np = np.array(image)

    # Create an alpha channel with the same size as the image
    alpha_channel = np.zeros_like(image_np[:, :, 0])

    # Set the alpha channel to 255 for the polygon area
    alpha_channel[mask == 1] = 255

    # Add the alpha channel to the image
    image_np = np.dstack((image_np[:, :, :3], alpha_channel))

    # Convert back to Image
    new_image = Image.fromarray(image_np, 'RGBA')

    # Save the result
    output_path = "static/cut_polygon.png"
    new_image.save(output_path)
    return jsonify({"image_url": output_path})


def extract_polygon_points2(image_path):
    image = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)  # Load with alpha channel if present

    # Check if the image has an alpha channel (transparency)
    if image.shape[2] == 4:
        # Separate the channels
        b, g, r, a = cv2.split(image)

        # Use the alpha channel as a mask
        mask = a
    else:
        # Convert to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        _, mask = cv2.threshold(gray, 127, 255, cv2.THRESH_BINARY)

    # Find contours
    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Assume the largest contour is the polygon
    contour = max(contours, key=cv2.contourArea)

    # Approximate the contour to a polygon
    epsilon = 0.02 * cv2.arcLength(contour, True)
    approx = cv2.approxPolyDP(contour, epsilon, True)

    # Extract the corner points
    corner_points = approx.reshape(-1, 2)
    #print("Corner points of the polygon:", corner_points)
    return corner_points

@app.route('/get_polygon_points')
def get_polygon_points():
    # This endpoint provides the polygon points
    # You should ensure that polygon_points are stored and retrievable
    # Here, we assume it's stored in a variable for simplicity
    # This example assumes polygon points are saved in a global variable
    image_path = 'static/cut_polygon.png'
    polygon_points = convert_points(extract_polygon_points2(image_path))
    #print("points",polygon_points)
    if not polygon_points:
        return jsonify({"error": "No points found"}), 404
    return jsonify({"points": polygon_points})




@app.route('/solar_panels')
def solar_panels():
    #print("area",area)
    no_of_panels =int(area/17.62) - int((int(area/17.62)*0.285))
    #print("panel count",no_of_panels)
    return render_template('solar_panels.html',panel_count=no_of_panels)



'''if __name__ == '__main__':
    app.run(debug=True)'''
