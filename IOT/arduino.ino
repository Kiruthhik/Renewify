int RelayPin = 6;

void setup() {
  Serial.begin(9600); // Initialize serial communication at 9600 baud rate
  pinMode(RelayPin, OUTPUT);
}


void loop() {
  // Read analog values
  int solarPanel1Voltage = analogRead(A0);
  int solarPanel1Current = analogRead(A2);
  int solarPanel2Voltage = analogRead(A1);
  int solarPanel2Current = analogRead(A3);
  int batteryVoltage = analogRead(A4);
  int batteryCurrent = analogRead(A5);

  // Convert analog readings to actual values
  float solarPanel1VoltageVal = (solarPanel1Voltage / 1023.0) * 25.0;
  float solarPanel1CurrentVal = ((solarPanel1Current / 1023.0) * 5.0) - 2.5;
  float solarPanel2VoltageVal = (solarPanel2Voltage / 1023.0) * 25.0;
  float solarPanel2CurrentVal = ((solarPanel2Current / 1023.0) * 5.0) - 2.5;
  float batteryVoltageVal = ((batteryVoltage / 1023.0) * 25.0)-1;
  float batteryCurrentVal = ((batteryCurrent / 1023.0) * 5.0) - 2.5;

  // Calculate battery percentage
  float batteryPercentage = ((batteryVoltageVal - 3.3) / (4.2 - 3.3)) * 100;
  if (batteryPercentage > 100) batteryPercentage = 100;
  if (batteryPercentage < 0) batteryPercentage = 0;
  // batteryPercentage=batteryPercentage+50;
  if (batteryPercentage<=80){
    digitalWrite(RelayPin, HIGH);
  }
  if(batteryPercentage>=100){
    digitalWrite(RelayPin, LOW);
  }

  // Send the values as a comma-separated string
  Serial.print(solarPanel1VoltageVal);
  Serial.print(",");
  Serial.print(solarPanel1CurrentVal);
  Serial.print(",");
  Serial.print(solarPanel2VoltageVal);
  Serial.print(",");
  Serial.print(solarPanel2CurrentVal);
  Serial.print(",");
  Serial.print(batteryVoltageVal);
  Serial.print(",");
  Serial.print(batteryCurrentVal);
  Serial.print(",");
  Serial.println(batteryPercentage);



  delay(1000); // Wait for a second before sending the next set of values
}