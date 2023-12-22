% - Get the total transfer function after the PID Tunning (System + Controller) in both Z and S Domain. 
numerator_plant = [10.06];
denominator_plant = [1, 2.646, 6.462, 5.49];
G_s = tf(numerator_plant, denominator_plant);

% Define PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Create the PID controller transfer function
G_controller_s = Kp + Ki/s + Kd*s;

% Compute the closed-loop transfer function
T_s = G_s * G_controller_s;

% Display the transfer function in the S domain
disp('Total Transfer Function in S Domain:')
T_s