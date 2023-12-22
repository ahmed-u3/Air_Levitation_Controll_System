% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Sampling time
Ts = 0.1; % Adjust this according to your desired sampling time

% Method 1: Using c2d function
sys_s = tf(numerator, denominator);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); % 'zoh' stands for zero-order hold

disp('Using c2d function:');
disp('Z-domain numerator coefficients:');
disp(sys_z_c2d.Numerator);
disp('Z-domain denominator coefficients:');
disp(sys_z_c2d.Denominator);

% Method 2: Using bilinear function
[num_z, den_z] = bilinear(numerator, denominator, 1/Ts);

disp('Using bilinear function:');
disp('Z-domain numerator coefficients:');
disp(num_z);
disp('Z-domain denominator coefficients:');
disp(den_z);
