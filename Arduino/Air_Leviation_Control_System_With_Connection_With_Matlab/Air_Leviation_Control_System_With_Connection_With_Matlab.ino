#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <PID_v1.h>

// PID constants, set from MATLAB PID tuner
double kp = 0.897;
double ki = 0.1;
double kd = 0.01;

// Variables for PID control
double Input;       // Current value (feedback)
double output = 170; // Output value (control signal to motor)
double SetPoint;    // Desired setpoint

// Create PID controller object
PID myPID(&Input, &output, &SetPoint, kp, ki, kd, REVERSE);

// Pin definitions for ultrasonic sensor and motor control
#define trigPin 9
#define echoPin 11
float duration, distance;

#define iN3 6
#define iN4 7
int ENA = 10;

// Initialize the LCD with its I2C address, number of columns, and number of rows
LiquidCrystal_I2C lcd(0x27, 16, 2);

void setup() {
  // Initialize serial communication
  Serial.begin(9600);

  // Initialize the LCD
  lcd.begin();
  lcd.backlight();
  lcd.clear();

  // Set pin modes
  pinMode(iN3, OUTPUT);
  pinMode(iN4, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // Configure PID controller
  myPID.SetMode(AUTOMATIC);
  myPID.SetOutputLimits(50, 255);
}

void Ultrasonic() {
  // Trigger ultrasonic sensor
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Measure echo duration
  duration = pulseIn(echoPin, HIGH);

  // Calculate distance from duration
  distance = 0.017 * duration;
}

void loop() {
  // Check if there is incoming data on the serial port
  if (Serial.available() > 0) {
    // Read the incoming data
    String incomingData = Serial.readStringUntil('\n');
    
    // Parse the incoming data to extract parameters
    if (incomingData.startsWith("SetPoint:")) {
      SetPoint = incomingData.substring(9).toDouble();
    }
    if (incomingData.startsWith("kp:")) {
      kp = incomingData.substring(3).toDouble();
    }
    if (incomingData.startsWith("ki:")) {
      ki = incomingData.substring(3).toDouble();
    }
    if (incomingData.startsWith("kd:")) {
      kd = incomingData.substring(3).toDouble();
    }
  }

  // Measure distance using ultrasonic sensor
  Ultrasonic();

  // Update Input with current distance from the setpoint
  Input = distance;

  // Compute PID control signal
  myPID.Compute();

  // Apply PID output to control motor speed
  analogWrite(ENA, output);

  // Motor control logic
  digitalWrite(iN3, HIGH);
  digitalWrite(iN4, LOW);

  // Print relevant information to the serial monitor
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.print(" cm\t");
  Serial.print("Setpoint: ");
  Serial.print(SetPoint);
  Serial.print(" cm\t");
  Serial.print("Speed: ");
  Serial.print(output); // Assuming 255 is full speed
  Serial.println(" PWM");

  // Print information to the LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("D: ");
  lcd.print(distance);
  lcd.setCursor(10, 0);
  lcd.print("SP: ");
  lcd.print(SetPoint);
  lcd.setCursor(0, 1);
  lcd.print("S: ");
  lcd.print(output);

  delay(100);
}
