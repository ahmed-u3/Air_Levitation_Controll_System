int kp = 0;
int ki = 1;
int kd = 2;

// The setup routine runs once when you press reset:
void setup() {
  // Initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}

// The loop routine runs over and over again forever:
void loop() {
  // Write the sinewave points, followed by the terminator "Carriage Return" and "Linefeed".
  Serial.print(String(kp) + " " + String(ki) + " " + String(kd));
  Serial.write(13); // Carriage Return
  Serial.write(10); // Linefeed
  delay(1000); // Add a delay to slow down the transmission, adjust as needed
}
