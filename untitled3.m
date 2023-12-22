% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Sampling time
Ts = 0.1; % Adjust this according to your desired sampling time

% Create the Z-domain transfer function
sys_s = tf(numerator, denominator);
sys_z_c2d = c2d(sys_s, Ts); % 'zoh' stands for zero-order hold

% Tuned PID gains (replace with your actual tuned values)
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Create the continuous-time PID transfer function
num_pid_s = [Kd, Kp, Ki];
den_pid_s = [1, 0]; % Assuming a first-order integrator for the continuous-time PID
sys_pid_s = tf(num_pid_s, den_pid_s);

% Discretize the continuous-time PID transfer function using the 'tustin' method
%sys_pid_z = c2d(sys_pid_s, Ts, 'tustin');

% Display the transfer functions
disp('Continuous-time PID transfer function (S-domain):');
disp(sys_pid_s);

disp('Discrete-time PID transfer function (Z-domain):');
disp(sys_pid_z);