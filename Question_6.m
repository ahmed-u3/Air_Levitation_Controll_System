% - Get Transient response parameters and graph before and after the PID Control on step input in Z Domain. 

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

%% Transient Response Before PID on Step Input in Z Domain

sys_s = tf(numerator_plant, denominator_plant);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); 

[y, t] = step(SP * sys_z_c2d); 

%% Transient Response After PID on Step Input in Z Domain

% PID controller transfer function
num_pid_s = [Kd, Kp, Ki];
den_pid_s = [1, 0];
sys_pid_s = tf(num_pid_s, den_pid_s);

% Discretize the PID controller transfer function
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin');

% Closed-loop transfer function with unity feedback
sys_closed_loop = feedback(series(sys_z_c2d, sys_pid_z), 1);

[y, t] = step(SP * sys_closed_loop);  % Simulate the step response of the closed-loop system

%% Get Transient response parameters before and after the PID Control on step input in Z Domain

% Display transient response parameters before and after PID control
disp('Transient Response Parameters Before PID Control:');
info_before_pid = stepinfo(sys_z_c2d);
disp(info_before_pid);

disp('Transient Response Parameters After PID Control:');
info_after_pid = stepinfo(SP * sys_closed_loop);
disp(info_after_pid);

%% Graph before and after the PID Control on step input in Z Domain

% Plot step response before and after PID control
figure;
subplot(2,1,1);
step(sys_z_c2d);
title('Step Response Before PID Control');

subplot(2,1,2);
step(SP * sys_closed_loop);
title('Step Response After PID Control');