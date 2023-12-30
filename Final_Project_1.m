%% Question 1

% - Convert the experimental transfer function from S Domain to Z Domain using MATLAB with two different methods

% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Sampling time
Ts = 0.1; 

% PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% SetPoint --> Input Value
SP = 15;     

% Setpoint of step response
SP_Step = 1;

disp("--------------------------------------------");

%% Method 1: Using c2d function

sys_s = tf(numerator, denominator);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); % 'zoh' stands for zero-order hold

disp('Using c2d function:');
disp('Z-domain numerator coefficients:');
disp(sys_z_c2d.Numerator);
disp('Z-domain denominator coefficients:');
disp(sys_z_c2d.Denominator);

disp("--------------------------------------------");

%% Method 2: Using bilinear function
[num_z, den_z] = bilinear(numerator, denominator, 1/Ts); % or we can use c2d function with 'tustin' method

disp('Using bilinear function:');
disp('Z-domain numerator coefficients:');
disp(num_z);
disp('Z-domain denominator coefficients:');
disp(den_z);

disp("--------------------------------------------");

%% Method 3: Using Euler function
G_d_modified_euler = c2d(sys_s, Ts, 'method', 'euler');

disp('Using Euler function:');
disp('Z-domain numerator coefficients:');
disp(G_d_modified_euler.Numerator);
disp('Z-domain denominator coefficients:');
disp(G_d_modified_euler.Denominator);

disp("--------------------------------------------");

%% Question 2 (PID Tuner)

%% Question 3

%% S Domain PID transfer function
% Create the continuous-time PID transfer function
num_pid_s = [Kd, Kp, Ki];   % Coefficients of the derivative, proportional, and integral terms
den_pid_s = [1, 0];         % Denominator coefficients for a simple unity feedback system
sys_pid_s = tf(num_pid_s, den_pid_s);

% Display the transfer functions
disp('Continuous-time PID transfer function (S-domain):');
disp('S-domain PID numerator coefficients:');
disp(sys_pid_s.Numerator);
disp('S-domain PID denominator coefficients:');
disp(sys_pid_s.Denominator);

disp("------------------------------------------------");

%% Z Domain PID transfer function
% Discretize the continuous-time PID transfer function using the 'tustin' method
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin'); % We used tustin which handle the improper system and proper systems too 
                                          % Why ? because our system is unstable in which the degree of the numerator is greater than the degree of the denomenator
                                          % and the poles is equal 0 which make the system unstable                                                                                   

disp('Discrete-time PID transfer function (Z-domain):');
disp('Z-domain PID numerator coefficients:');
disp(sys_pid_z.Numerator);
disp('Z-domain PID denominator coefficients:');
disp(sys_pid_z.Denominator);

disp("------------------------------------------------");

%% Total Transfer Function after PID in S Domain

% Calculate the total transfer function in the Laplace (s) domain
sys_total_s = sys_s * sys_pid_s;

% Display the total transfer function
disp('Total Transfer Function in the Laplace (s) domain:')
disp('S-domain numerator coefficients:');
disp(sys_total_s.Numerator);
disp('S-domain denominator coefficients:');
disp(sys_total_s.Denominator);

disp("------------------------------------------------");

%% Total Transfer Function after PID in Z Domain

% Calculate the total transfer function in the Z domain
sys_total_z = series(sys_z_c2d, sys_pid_z);

% Display the total transfer function in the Z domain
disp('Total Transfer Function in the Z domain:')
disp('S-domain numerator coefficients:');
disp(sys_total_z.Numerator);
disp('S-domain denominator coefficients:');
disp(sys_total_z.Denominator);

disp("------------------------------------------------");

save Final_Project_1.mat
