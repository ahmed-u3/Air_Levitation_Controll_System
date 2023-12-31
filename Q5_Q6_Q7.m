load("Final_Project_1.mat")

%% Steady State Error Before PID in Z Domain

[y, t] = step(SP * sys_z_c2d);           % get the response of the system to a step with amplitude SP
SSerror_Before_PID = abs(SP - y(end));   % get the steady-state error

% Display the steady-state error value
disp(['Steady-State Error Before PID in Z Domain: ' num2str(SSerror_Before_PID)]);

disp("-------------------------------------------------------------");

%% Steady State Error After PID in Z Domain

% Closed-loop transfer function after PID control
sys_closed_loop = feedback(series(sys_z_c2d, sys_pid_z), 1);

[y, t] = step(SP * sys_closed_loop);  % get the response of the system to a step with amplitude SP
SSerror_After_PID = abs(SP - y(end));       % get the steady-state error

% Display the steady-state error value
disp(['Steady-State Error After PID in Z Domain: ' num2str(SSerror_After_PID)]);

disp("-------------------------------------------------------------");

%% Transient Response Before PID on Step Input in Z Domain

[y, t] = step(SP_Step * sys_z_c2d); 

%% Transient Response After PID on Step Input in Z Domain

[y, t] = step(SP_Step * sys_closed_loop);  % Simulate the step response of the closed-loop system

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