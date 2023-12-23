#include <PID_v1.h>

// PID constants, set from MATLAB PID tuner
#define kp 0.36962
#define ki 0.50657
#define kd 0.067425

// Variables for PID control
double Input;       // Current value (feedback)
double output;      // Output value (control signal to motor)
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

void setup() {
  // Initialize serial communication
  Serial.begin(9600);

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
  myPID.SetOutputLimits(0, 255);
}

void Ultrasonic() {
  // Trigger ultrasonic sensor
  digitalWrite(trigPin, 1);
  delayMicroseconds(10);
  digitalWrite(trigPin, 0);

  // Measure echo duration
  duration = pulseIn(echoPin, 1);

  // Calculate distance from duration
  distance = 0.017 * duration;

  // Print distance to serial monitor
  Serial.print(distance);
  Serial.write(13);
  Serial.write(10);

  // Delay to avoid rapid serial prints
  delay(500);
}

void loop() {
  // Measure distance using ultrasonic sensor
  Ultrasonic();

  // Update Input with current distance from the setpoint
  Input = 30 - distance;

  // Set desired setpoint
  SetPoint = 15;

  // Compute PID control signal
  myPID.Compute();

  // Apply PID output to control motor speed
  analogWrite(ENA, output);

  // Motor control logic
  digitalWrite(iN3, 1);
  digitalWrite(iN4, 0);
}
