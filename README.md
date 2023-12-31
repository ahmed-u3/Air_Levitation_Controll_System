# Air Levitation System Project

![Project Image](Images/Air_Levitation_System.jpg)

## Table of Contents
- [Introduction](#introduction)
- [Course Instructors](#course-instructors)
- [Team Members](#team-members)
- [Hardware](#hardware)
- [Software](#software)
- [Images](#images)
- [Documents](#documents)
- [Videos](#videos)

## Introduction

This repository showcases the culminating project for the Modern Control Systems Course, centering around an Air Levitation System controlled through PID tuning using both MATLAB and Arduino. The primary objective is to elevate a foam ball to a specified setpoint, initially set at 15 cm, corresponding to the midpoint of a 30 cm 3D-printed tube.

## Course Instructors

- Prof. Mahmoud Gamal
- Eng. Mohammed Hatem

## Team Members
- Fares Hazem 
  - LinkedIn: ([Fares Hazem](https://www.linkedin.com/in/fares-hazem-b5590214b/))
- Ahmed Dawood 
  - LinkedIn: ([Ahmed Dawood](https://www.linkedin.com/in/ahmed-dawod-088539223/))
- Ahmed Yousri
  - LinkedIn: [Ahmed Yousri](https://www.linkedin.com/in/ahmed-yousry-807582196/)
- Ahmed Ashraf 
  - LinkedIn: ([Ahmed Ashraf](https://www.linkedin.com/in/telemachus19/))

## Hardware

- 12v 300mA Adaptor
- L298N Motor Driver (2 Channels, H bridge)
- Arduino UNO with Serial Cable
- 12v DC Fan (6 cm*6 cm)
- Ultrasonic Sensor HC-SR04
- Foam Ball
- LCD Using I2C
- BreadBoard

## Software

### MATLAB
1. **PID Tuning and Analysis:** The MATLAB code for PID tuning and analysis is located in the `MATLAB` folder, named `Analysis.mlx`.
2. **MATLAB-Arduino Connection:** Code enabling the user to assign the set point from MATLAB, plot real-time response, and send new PID parameters to Arduino. The file is in the `MATLAB` folder, named `Bonus.m`.
3. **GUI for Interactive Display:** Interactive display with sliders for Kp and Ts, controlling Step-Response Plot and Pole-Zero Map Plot. Located in the `MATLAB` folder, named `GUI.mlapp`.

### Arduino
- Two codes are available in the `Arduino` folder:
  1. `Air_Leviation_Control_System_With_Connection_With_MATLAB.ino`
  2. `Air_Leviation_Control_System_Without_Connection_With_MATLAB.ino`

## Images

  - `Air Leviation Transfer Function.jpg`
  - `Air_Levitation_System.jpg`
  - `GUI.png`
  - `Hardware Inside the Box.jpg`
  - `Performance Graph after PID.png`
  - `Performance.png`
  - `PID Tuner.png`
  - `Signature.jpg`

## Documents

- `Report.pdf`: Full report describing the project.
- `Schema.pdf`: Schematic circuit drawn in Fritzing Software.

## Videos

- `Video With Explanation.mp4`: 1-minute video demonstrating the working project with a brief explanation.
