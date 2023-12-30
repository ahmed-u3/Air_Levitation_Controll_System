% - Plot the Root Locus for the system before and after PID in Z Domain. 

% Plant transfer function
numerator_plant = [10.06];
denominator_plant = [1, 2.646, 6.462, 5.49];

% PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Sampling time
Ts = 0.1;

% Setpoint
SP = 1;

disp("--------------------------------------------------------");

%% System Before the PID tunning

sys_s = tf(numerator_plant, denominator_plant);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); 

%% System After the PID tunning

% PID controller transfer function
num_pid_s = [Kd, Kp, Ki];
den_pid_s = [1, 0];
sys_pid_s = tf(num_pid_s, den_pid_s);

% Discretize the PID controller transfer function
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin');

% Closed-loop transfer function with unity feedback
sys_closed_loop = feedback(series(sys_z_c2d, sys_pid_z), 1);

%% Plot Root Locus Before and After adding PID in Z domain
figure;
rlocus(sys_z_c2d, '-b', sys_closed_loop, '-r');
title('Root Locus Before and After Adding PID Control (Z Domain)');
legend('Before PID', 'After PID');
grid on;