% Plant transfer function in the Z domain
numerator_plant = [1];
denominator_plant = [1, -0.5];
G_z = tf(numerator_plant, denominator_plant, 'Ts', 0.1);  % Example plant, adjust coefficients and Ts

% PID controller parameters
Kp = 1;
Ki = 0.5;
Kd = 0.2;

% Create the PID controller transfer function in the Z domain
z = tf('z', 0.1);  % Use the sample time as the Ts value
G_controller_z = Kp + Ki * 0.1 / (z - 1) + Kd * z / (0.1);

% Closed-loop system transfer function with PID
G_closed_loop_z = G_z * G_controller_z / (1 + G_z * G_controller_z);

% Simulate and plot the step response without PID controller
figure;
subplot(2, 1, 1);
step(G_z, 'r', 'LineWidth', 2);
title('Step Response Without PID Controller');
grid on;

% Extract transient response parameters without PID controller
step_info_without_pid = stepinfo(G_z);

% Display transient response parameters without PID controller
disp('Transient Response Parameters Without PID Controller:');
disp(step_info_without_pid);

% Simulate and plot the step response with PID controller
subplot(2, 1, 2);
step(G_closed_loop_z, 'b', 'LineWidth', 2);
title('Step Response With PID Controller');
grid on;

% Extract transient response parameters with PID controller
step_info_with_pid = stepinfo(G_closed_loop_z);

% Display transient response parameters with PID controller
disp('Transient Response Parameters With PID Controller:');
disp(step_info_with_pid);