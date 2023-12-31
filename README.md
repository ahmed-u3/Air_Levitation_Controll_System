# Air Levitation System Project

## Table of Contents
- [Introduction](#introduction)
- [Team Members](#team-members)
- [Hardware](#hardware)
- [Software](#software)
- [Project Structure](#project-structure)
- [Images](#images)
- [Documents](#documents)
- [Videos](#videos)

## Introduction

This repository contains the final project for the Modern Control Systems Course, led by Prof. Mahmoud Gamal and Eng. Mohammed Hatem. The project focuses on an Air Levitation System implemented by the following team members:

- Fares Hazem ([LinkedIn](https://www.linkedin.com/in/fares-hazem-b5590214b/))
- Ahmed Dawood ([LinkedIn](https://www.linkedin.com/in/ahmed-dawod-088539223/))
- Ahmed Yousri ([LinkedIn](https://www.linkedin.com/in/ahmed-yousry-807582196/))
- Ahmed Ashraf ([LinkedIn](link-to-linkedin))

![Project Image](Images/Air_Levitation_System.jpg)

## Hardware

- 12v DC Fan (6 cm*6 cm)
- L298N Motor Driver (2 Channels, H bridge)
- Ultrasonic Sensor HC-SR04
- Arduino UNO with Serial Cable
- Foam Ball
- LCD
- BreadBoard
- 12v 300mA Adaptor

## Software

### Matlab
1. **PID Tuning and Analysis:** The MATLAB code for PID tuning and analysis is located in the `MatLab` folder, named `Analysis.mlx`.
2. **MATLAB-Arduino Connection:** Code enabling the user to assign the set point from MATLAB, plot real-time response, and send new PID parameters to Arduino. The file is in the `MatLab` folder, named `Bonus.m`.
3. **GUI for Interactive Display:** Interactive display with sliders for Kp and Ts, controlling Step-Response Plot and Pole-Zero Map Plot. Located in the `MatLab` folder, named `GUI.mlapp`.

### Arduino
- Two codes are available in the `Arduino` folder:
  1. `Air_Leviation_Control_System_With_Connection_With_Matlab.ino`
  2. `Air_Leviation_Control_System_Without_Connection_With_Matlab.ino`

## Project Structure

- `MatLab/`
  - `Analysis.mlx`
  - `Bonus.m`
  - `GUI.mlapp`
- `Arduino/`
  - `Air_Leviation_Control_System_With_Connection_With_Matlab.ino`
  - `Air_Leviation_Control_System_Without_Connection_With_Matlab.ino`
- `Images/`
  - `Air Leviation Transfer Function.jpg`
  - `Air_Levitation_System.jpg`
  - `GUI.png`
  - `Hardware Inside the Box.jpg`
  - `Performance Graph after PID.png`
  - `Performance.png`
  - `PID Tuner.png`
  - `Signature.jpg`
- `Report.pdf`
- `Schema.pdf`
- `Videos/`
  - Video With Explanation.mp4 (1 min)

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
