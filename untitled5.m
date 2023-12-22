% - Get the S and Z Domain PID transfer functions. 
matlab % ------------ Get S and Z domain of PID TF------------------

% -----------------------------S domain-----------------------------------
% Tuned PID gains (replace with your actual tuned values)
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Create the PID controller transfer function in the S domain
s = tf('s'); %creates a transfer function variable s that represents the complex variable s in laplace domain

G_controller_s = Kp + Ki/s + Kd*s;

% Display the PID transfer function in the S domain
disp('PID Controller Transfer Function in S Domain:')
G_controller_s

%----------------------------------Z domain------------------------------

% Define PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Specify the sample time for discretization
Ts = 0.1;  % 0.1 seconds

% Create the discrete-time PID controller transfer function
z = tf('z', Ts);
G_controller_z = Kp + Ki * Ts/(1 - z^-1) + Kd * z / Ts;

% Display the PID transfer function in the Z domain
disp('PID Controller Transfer Function in Z Domain:')
G_controller_z