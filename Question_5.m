% - Get Steady State Error before and after the PID Control in Z Domain. 

numerator_plant = [10.06];
denominator_plant = [1, 2.646, 6.462, 5.49];

% PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Sampling time
Ts = 0.1;

disp("-------------------------------------------------------------");

%% Steady State Error Before PID in Z Domain

sys_s = tf(numerator_plant, denominator_plant);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); 

SP = 15;                                 % SetPoint --> Input Value
[y, t] = step(SP * sys_z_c2d);           % get the response of the system to a step with amplitude SP
SSerror_Before_PID = abs(SP - y(end));   % get the steady-state error

% Display the steady-state error value
disp(['Steady-State Error Before PID in Z Domain: ' num2str(SSerror_Before_PID)]);

disp("-------------------------------------------------------------");

%% Steady State Error After PID in Z Domain

% S Domain PID transfer function
%-------------------------------
% Create the continuous-time PID transfer function
num_pid_s = [Kd, Kp, Ki];   % Coefficients of the derivative, proportional, and integral terms
den_pid_s = [1, 0];         % Denominator coefficients for a simple unity feedback system
sys_pid_s = tf(num_pid_s, den_pid_s);

% Z Domain PID transfer function
% Create the discrete-time PID controller transfer function
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin');

% Closed-loop transfer function after PID control
sys_closed_loop = feedback(series(sys_z_c2d, sys_pid_z), 1);

SP = 15;                                    % SetPoint --> Input Value
[y, t] = step(SP * sys_closed_loop);  % get the response of the system to a step with amplitude SP
SSerror_After_PID = abs(SP - y(end));       % get the steady-state error

% Display the steady-state error value
disp(['Steady-State Error After PID in Z Domain: ' num2str(SSerror_After_PID)]);

disp("-------------------------------------------------------------");