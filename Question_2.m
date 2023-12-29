% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Sampling time
Ts = 0.1; % Adjust this according to your desired sampling time

% Create the Z-domain transfer function
sys_s = tf(numerator, denominator);
sys_z_c2d = c2d(sys_s, Ts); % 'zoh' stands for zero-order hold

pidTuner(sys_z_c2d,'pid');