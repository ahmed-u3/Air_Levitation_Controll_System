% - Plot Step response plot before and after the PID response in Z Domain. 

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
SP = 15;

%% Response Before PID in Z Domain

sys_s = tf(numerator_plant, denominator_plant);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); 

%% Response After PID in Z Domain

% PID controller transfer function
num_pid_s = [Kd, Kp, Ki];
den_pid_s = [1, 0];
sys_pid_s = tf(num_pid_s, den_pid_s);

% Discretize the PID controller transfer function
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin');

% Closed-loop transfer function with unity feedback
sys_closed_loop = feedback(series(sys_z_c2d, sys_pid_z), 1);

%% Displaying Transient response parameters before and after the PID Control

% Display transient response parameters before and after PID control
disp('Transient Response Parameters Before PID Control:');
info_before_pid = stepinfo(sys_z_c2d);
disp(info_before_pid);

disp('Transient Response Parameters After PID Control:');
info_after_pid = stepinfo(SP * sys_closed_loop);
disp(info_after_pid);

%% Plot Step response plot before and after the PID

% Plot step response before and after PID control
figure;
subplot(2,1,1);
step(sys_z_c2d);
title('Step Response Before PID Control');
grid on;

subplot(2,1,2);
step(SP * sys_closed_loop);
title('Step Response After PID Control');
grid on;