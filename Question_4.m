% - Get the total transfer function after the PID Tunning (System + Controller) in both Z and S Domain. 

% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Tuned PID gains
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Transfer function coefficients after PID
num_pid_s = [Kd, Kp, Ki];   % Coefficients of the derivative, proportional, and integral terms
den_pid_s = [1, 0];         % Denominator coefficients for a simple unity feedback system

% Sampling time
Ts = 0.1;

disp("------------------------------------------------");

%% Total Transfer Function after PID in S Domain
sys_plant = tf(numerator, denominator);  % Define your plant transfer function
sys_pid_s = tf(num_pid_s, den_pid_s);   % Define your continuous-time PID transfer function

% Calculate the total transfer function in the Laplace (s) domain
sys_total_s = sys_plant * sys_pid_s;

% Display the total transfer function
disp('Total Transfer Function in the Laplace (s) domain:')
disp('S-domain numerator coefficients:');
disp(sys_total_s.Numerator);
disp('S-domain denominator coefficients:');
disp(sys_total_s.Denominator);

disp("------------------------------------------------");

%% Total Transfer Function after PID in Z Domain
sys_plant_z = c2d(sys_plant, Ts, 'tustin');  % Define your plant transfer function
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin');   % Define your discrete-time PID transfer function using Tustin method

% Calculate the total transfer function in the Z domain
sys_total_z = series(sys_plant_z, sys_pid_z);

% Display the total transfer function in the Z domain
disp('Total Transfer Function in the Z domain:')
disp('S-domain numerator coefficients:');
disp(sys_total_z.Numerator);
disp('S-domain denominator coefficients:');
disp(sys_total_z.Denominator);

disp("------------------------------------------------");