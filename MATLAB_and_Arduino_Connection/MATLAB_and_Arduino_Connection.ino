#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <PID_v1.h>

// Variables for PID control
double Input;       // Current value (feedback)
double output = 200; // Output value (control signal to motor)
double SetPoint;    // Desired setpoint

// Create PID controller object
PID myPID(&Input, &output, &SetPoint, REVERSE);

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

  // Initialize system open-loop output to 0
  float Gs = 0;

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
  // Measure distance using ultrasonic sensor
  Ultrasonic();

  // Update Input with current distance from the setpoint
  Input = distance;

  // Check if MATLAB sent new setpoint
  if (Serial.available() > 0) {
    SetPoint = Serial.parseFloat();
  }

  myPID.Compute();
  analogWrite(ENA, output);
  digitalWrite(iN3, HIGH);
  digitalWrite(iN4, LOW);

  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.print(" cm\t");
  Serial.print("Setpoint: ");
  Serial.print(SetPoint);
  Serial.print(" cm\t");
  Serial.print("Speed: ");
  Serial.print(output);
  Serial.println(" PWM");

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

  // Send data back to MATLAB for plotting
  Serial.print(distance);
  Serial.print(",");
  Serial.print(output);
  Serial.print(",");
  Serial.println(SetPoint);

  delay(100);
}
