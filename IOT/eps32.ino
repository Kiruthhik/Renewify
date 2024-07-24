#include <WiFi.h>
#include <FirebaseESP32.h>
#include <HardwareSerial.h>

// Replace with your network credentials
#define WIFI_SSID "Karthi's Galaxy A23 5G"
#define WIFI_PASSWORD "Karthi800@"

// Firebase project credentials
#define FIREBASE_HOST "https://solar-panel-211c6-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "AIzaSyAg-sw9I-0YEN4rZmiXeWv5jbFar28MLPo"

const int mq6Pin = 34;
const int buzzerPin = 27;

const int gasThreshold = 1800;
// Firebase objects
FirebaseData firebaseData;
FirebaseConfig config;
FirebaseAuth auth;

// Sensor and module pins
#define RELAY_PIN 32

// Battery parameters
#define BATTERY_CAPACITY 4300.0  // in mAh
#define MAX_BATTERY_VOLTAGE 4.2  // in volts (fully charged)
#define MIN_BATTERY_VOLTAGE 3.0  // in volts (empty)

HardwareSerial SerialPort(1); // Use UART1

void setup() {
  Serial.begin(115200); // Initialize serial communication at 115200 baud rate for the ESP32 Serial Monitor
  SerialPort.begin(9600, SERIAL_8N1, 16, 17); // Initialize UART1 at 9600 baud rate, RX = GPIO16, TX = GPIO17
  
  pinMode(mq6Pin, INPUT);
  pinMode(buzzerPin, OUTPUT);
  // Initialize Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("connected");

  // Firebase configuration
  config.host = FIREBASE_HOST;
  config.signer.tokens.legacy_token = FIREBASE_AUTH;
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  // Initialize relay pin
  pinMode(RELAY_PIN, OUTPUT);
}

void loop() {
  if (SerialPort.available()) {
    String data = SerialPort.readStringUntil('\n'); // Read data from the Arduino
    Serial.println("Received Data: " + data); // Print the received data
    
    // Split the received data into individual values
    float values[6];
    int startIndex = 0;
    for (int i = 0; i < 6; i++) {
      int commaIndex = data.indexOf(',', startIndex);
      if (commaIndex == -1) {
        commaIndex = data.length();
      }
      values[i] = data.substring(startIndex, commaIndex).toFloat();
      startIndex = commaIndex + 1;
    }
    
    // Extract individual values
    float voltage1 = values[0];
    float current1 = values[1];
    float voltage2 = values[2];
    float current2 = values[3];
    float batteryVoltage = values[4];
    float batteryCurrent = values[5];

    // Calculate battery percentage
    float batteryPercentage = ((batteryVoltage - MIN_BATTERY_VOLTAGE) / (MAX_BATTERY_VOLTAGE - MIN_BATTERY_VOLTAGE)) * 100.0;
    batteryPercentage = constrain(batteryPercentage, 0, 100);

    // Control relay based on battery percentage
    if (batteryPercentage >= 100) {
      digitalWrite(RELAY_PIN, LOW);  // Stop charging
      Serial.println("not charging");
    } else if (batteryPercentage <= 80) {
      digitalWrite(RELAY_PIN, HIGH);  // Start charging
      Serial.println(" charging");
    }
    int gasValue = analogRead(mq6Pin);
  Serial.println(gasValue);

  if (gasValue > gasThreshold) {
    digitalWrite(buzzerPin, HIGH);
    if (Firebase.setString(firebaseData, "/gasAlert", "Gas Detected!")) {
      Serial.println("Notification sent");
    } else {
      Serial.println("Failed to send notification");
      Serial.println(firebaseData.errorReason());
    }
  } else {
    digitalWrite(buzzerPin, LOW);
    (Firebase.setString(firebaseData, "/gasAlert", "Gas not Detected!"));
  }
  // Prepare JSON data
    FirebaseJson json;
    json.set("solar_panel_1/voltage", voltage1);
    json.set("solar_panel_1/current", current1);
    json.set("solar_panel_2/voltage", voltage2);
    json.set("solar_panel_2/current", current2);
    json.set("battery/voltage", batteryVoltage);
    json.set("battery/current", batteryCurrent);
    json.set("battery/percentage", batteryPercentage);

    // Send data to Firebase
    if (Firebase.setJSON(firebaseData, "/solar_battery_data", json)) {
      Serial.println("Data updated successfully");
    } else {
      Serial.println("Failed to update data: " + firebaseData.errorReason());
    }
  }

  // Wait for a second before the next update
  delay(1000);
}