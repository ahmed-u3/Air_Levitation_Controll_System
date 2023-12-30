% - Convert the experimental transfer function from S Domain to Z Domain using MATLAB with two different methods

% Transfer function coefficients
numerator = [10.06];
denominator = [1, 2.646, 6.462, 5.49];

% Sampling time
Ts = 0.1; 

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
